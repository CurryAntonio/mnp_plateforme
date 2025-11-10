from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import get_user_model
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.conf import settings

from .serializers import (
    CustomTokenObtainPairSerializer,
    UserSerializer,
    UserCreateSerializer,
    PasswordResetRequestSerializer,
    PasswordResetConfirmSerializer,
    PasswordChangeSerializer 
)

User = get_user_model()

class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer
    
    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        # Obtenir l'utilisateur à partir des identifiants
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.user
        
        # Vérifier que les clés access et refresh sont présentes
        if 'access' in response.data:
            # Renommer la clé access en token pour correspondre à ce qu'attend le frontend
            response.data['token'] = response.data['access']
            # Optionnel : supprimer la clé access pour éviter la confusion
            # del response.data['access']
        
        # Ajouter les informations utilisateur à la réponse
        response.data['user'] = UserSerializer(user).data
        
        # Ajouter des logs pour déboguer
        print("Réponse de connexion:", response.data)
        
        return response

class RegisterView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = UserCreateSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response({
                "user": UserSerializer(user).data,
                "message": "Utilisateur créé avec succès"
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LogoutView(APIView):
    def post(self, request):
        try:
            refresh_token = request.data.get('refresh')
            if refresh_token:
                token = RefreshToken(refresh_token)
                token.blacklist()
            return Response({"message": "Déconnexion réussie"}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

class ForgotPasswordView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = PasswordResetRequestSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['email']
            try:
                user = User.objects.get(email=email)
                token = default_token_generator.make_token(user)
                uid = urlsafe_base64_encode(force_bytes(user.pk))
                
                # Construire l'URL de réinitialisation
                frontend_url = "http://localhost:3000"  # Remplacer par l'URL de production en environnement de production
                reset_url = f"{frontend_url}/reset-password?uid={uid}&token={token}"
                
                # Préparer le contenu de l'email
                subject = "Réinitialisation de votre mot de passe - Plateforme de Gestion de Stock"
                
                # Définir la version texte du message
                message = f"""Bonjour,
                
Vous avez récemment demandé la réinitialisation de votre mot de passe pour votre compte sur la Plateforme de Gestion de Stock.

Veuillez cliquer sur le lien ci-dessous pour définir un nouveau mot de passe :
{reset_url}

Ce lien expirera dans 24 heures.

Si vous n'avez pas demandé cette réinitialisation, veuillez ignorer cet email ou contacter notre support si vous avez des questions.

Cordialement,
L'équipe de la Plateforme de Gestion de Stock"""
                
                # Définir l'expéditeur et le destinataire
                from_email = settings.DEFAULT_FROM_EMAIL
                recipient_list = [email]
                
                # Après avoir défini le message texte
                html_message = f"""<html>
                <head>
                    <style>
                        body {{ font-family: Arial, sans-serif; line-height: 1.6; color: #333; }}
                        .container {{ max-width: 600px; margin: 0 auto; padding: 20px; }}
                        .button {{ display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; }}
                        .footer {{ margin-top: 30px; font-size: 12px; color: #777; }}
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h2>Réinitialisation de votre mot de passe</h2>
                        <p>Bonjour,</p>
                        <p>Vous avez récemment demandé la réinitialisation de votre mot de passe pour votre compte sur la Plateforme de Gestion de Stock.</p>
                        <p>Veuillez cliquer sur le bouton ci-dessous pour définir un nouveau mot de passe :</p>
                        <p><a href="{reset_url}" class="button">Réinitialiser mon mot de passe</a></p>
                        <p>Ou copiez et collez ce lien dans votre navigateur :</p>
                        <p>{reset_url}</p>
                        <p>Ce lien expirera dans 24 heures.</p>
                        <p>Si vous n'avez pas demandé cette réinitialisation, veuillez ignorer cet email ou contacter notre support si vous avez des questions.</p>
                        <div class="footer">
                            <p>Cordialement,<br>L'équipe de la Plateforme de Gestion de Stock</p>
                        </div>
                    </div>
                </body>
                </html>"""
                
                # Puis modifiez l'appel à send_mail pour inclure le message HTML
                from django.core.mail import send_mail
                send_mail(
                    subject,
                    message,  # Version texte
                    from_email,
                    recipient_list,
                    fail_silently=False,
                    html_message=html_message  # Version HTML
                )
                
                print(f"Email de réinitialisation envoyé à {email} avec le lien: {reset_url}")
                
                return Response({"message": "Instructions de réinitialisation envoyées par email"}, status=status.HTTP_200_OK)
            except User.DoesNotExist:
                # Pour des raisons de sécurité, ne pas indiquer si l'email existe ou non
                pass
            except Exception as e:
                print(f"Erreur lors de l'envoi de l'email: {str(e)}")
                # En production, vous pourriez vouloir logger cette erreur plutôt que de l'afficher
                # Mais ne pas la renvoyer à l'utilisateur pour des raisons de sécurité
            
            # Toujours renvoyer un message positif, même si l'email n'existe pas ou si l'envoi a échoué
            # C'est une bonne pratique de sécurité pour éviter l'énumération des comptes
            return Response({"message": "Si cette adresse email est associée à un compte, des instructions de réinitialisation ont été envoyées."}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class VerifyTokenView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        print("VerifyTokenView - Données reçues:", request.data)
        token = request.data.get('token')
        if not token:
            print("VerifyTokenView - Aucun token fourni")
            return Response({"error": "Token non fourni"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            # Utiliser le décodeur JWT pour vérifier le token
            from rest_framework_simplejwt.tokens import AccessToken
            from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
            
            # Vérifier si le token est valide
            print("VerifyTokenView - Tentative de décodage du token:", token[:10] + "...")
            token_obj = AccessToken(token)
            user_id = token_obj['user_id']
            print("VerifyTokenView - Token valide, user_id:", user_id)
            
            # Récupérer l'utilisateur
            user = User.objects.get(id=user_id)
            print("VerifyTokenView - Utilisateur trouvé:", user.username)
            
            # Renvoyer les informations de l'utilisateur
            response_data = {
                "valid": True,
                "user": UserSerializer(user).data
            }
            print("VerifyTokenView - Réponse:", response_data)
            return Response(response_data, status=status.HTTP_200_OK)
            
        except (TokenError, InvalidToken) as e:
            print("VerifyTokenView - Erreur de token:", str(e))
            return Response({"valid": False, "error": str(e)}, status=status.HTTP_401_UNAUTHORIZED)
        except User.DoesNotExist as e:
            print("VerifyTokenView - Utilisateur non trouvé:", str(e))
            return Response({"valid": False, "error": "Utilisateur non trouvé"}, status=status.HTTP_401_UNAUTHORIZED)
        except Exception as e:
            print("VerifyTokenView - Exception générale:", str(e))
            return Response({"valid": False, "error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

class ResetPasswordView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = PasswordResetConfirmSerializer(data=request.data)
        if serializer.is_valid():
            token = serializer.validated_data['token']
            password = serializer.validated_data['password']
            
            try:
                # Décomposer le token pour obtenir l'uid et le token
                parts = token.split('/')
                if len(parts) >= 2:
                    uid = parts[-2]
                    token = parts[-1]
                    
                    # Décoder l'uid pour obtenir l'id de l'utilisateur
                    user_id = force_str(urlsafe_base64_decode(uid))
                    user = User.objects.get(pk=user_id)
                    
                    # Vérifier que le token est valide
                    if default_token_generator.check_token(user, token):
                        user.set_password(password)
                        user.save()
                        return Response({"message": "Mot de passe réinitialisé avec succès"}, status=status.HTTP_200_OK)
                    else:
                        return Response({"error": "Token invalide"}, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response({"error": "Format de token invalide"}, status=status.HTTP_400_BAD_REQUEST)
            except Exception as e:
                return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class UserProfileView(APIView):
    def get(self, request):
        serializer_data = UserSerializer(request.user).data
        return Response(serializer_data)
    
    def put(self, request):
        # Vérifier si c'est une demande de changement de mot de passe
        if 'current_password' in request.data and 'password' in request.data:
            password_serializer = PasswordChangeSerializer(data=request.data, context={'request': request})
            if password_serializer.is_valid():
                user = request.user
                user.set_password(password_serializer.validated_data['password'])
                user.save()
                return Response({"message": "Mot de passe modifié avec succès"}, status=status.HTTP_200_OK)
            return Response(password_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        # Sinon, c'est une mise à jour normale du profil
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)