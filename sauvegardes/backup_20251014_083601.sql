--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-10-14 08:36:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_20aca447_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_perm_permission_id_0b93982e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_5f6f5a90_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_group_id_9afc8d0e_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.reports_reorderanalysis DROP CONSTRAINT IF EXISTS reports_reorderanaly_produit_id_5b323c68_fk_products_;
ALTER TABLE IF EXISTS ONLY public.products_produit DROP CONSTRAINT IF EXISTS products_produit_groupe_id_8ec8d707_fk_products_groupe_id;
ALTER TABLE IF EXISTS ONLY public.products_inventaireproduit DROP CONSTRAINT IF EXISTS products_inventairep_utilisateur_id_78349851_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.products_inventaireproduit DROP CONSTRAINT IF EXISTS products_inventairep_produit_id_081864c6_fk_products_;
ALTER TABLE IF EXISTS ONLY public.products_inventaireproduit DROP CONSTRAINT IF EXISTS products_inventairep_mouvement_ajustement_e5e4a56d_fk_journal_m;
ALTER TABLE IF EXISTS ONLY public.journal_mouvement DROP CONSTRAINT IF EXISTS journal_mouvement_utilisateur_id_9c9197d6_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.journal_mouvement DROP CONSTRAINT IF EXISTS journal_mouvement_produit_id_f6def3e9_fk_products_produit_id;
ALTER TABLE IF EXISTS ONLY public.inventory_sessioninventaire DROP CONSTRAINT IF EXISTS inventory_sessioninv_responsable_id_b337bdf2_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.inventory_lignecomptage DROP CONSTRAINT IF EXISTS inventory_lignecomptage_operateur_id_31bb95d7_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.inventory_lignecomptage DROP CONSTRAINT IF EXISTS inventory_lignecompt_session_id_a2e28985_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.inventory_lignecomptage DROP CONSTRAINT IF EXISTS inventory_lignecompt_produit_id_91aff6b1_fk_products_;
ALTER TABLE IF EXISTS ONLY public.inventory_ajustementinventaire DROP CONSTRAINT IF EXISTS inventory_ajustement_valide_par_id_6e981e77_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.inventory_ajustementinventaire DROP CONSTRAINT IF EXISTS inventory_ajustement_session_id_33c4352b_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.inventory_ajustementinventaire DROP CONSTRAINT IF EXISTS inventory_ajustement_produit_id_f268bb1d_fk_products_;
ALTER TABLE IF EXISTS ONLY public.import_export_importhistory DROP CONSTRAINT IF EXISTS import_export_importhistory_user_id_65394061_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.import_export_exporthistory DROP CONSTRAINT IF EXISTS import_export_exporthistory_user_id_d541b1ba_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.ai_recommandation DROP CONSTRAINT IF EXISTS ai_recommandation_produit_id_7ffec4eb_fk_products_produit_id;
ALTER TABLE IF EXISTS ONLY public.ai_recommandation DROP CONSTRAINT IF EXISTS ai_recommandation_groupe_id_2739be33_fk_products_groupe_id;
ALTER TABLE IF EXISTS ONLY public.ai_prediction DROP CONSTRAINT IF EXISTS ai_prediction_produit_id_181df729_fk_products_produit_id;
ALTER TABLE IF EXISTS ONLY public.ai_anomalie DROP CONSTRAINT IF EXISTS ai_anomalie_produit_id_2c48ea36_fk_products_produit_id;
DROP INDEX IF EXISTS public.users_user_username_06e46fe6_like;
DROP INDEX IF EXISTS public.users_user_user_permissions_user_id_20aca447;
DROP INDEX IF EXISTS public.users_user_user_permissions_permission_id_0b93982e;
DROP INDEX IF EXISTS public.users_user_groups_user_id_5f6f5a90;
DROP INDEX IF EXISTS public.users_user_groups_group_id_9afc8d0e;
DROP INDEX IF EXISTS public.users_user_email_243f6e77_like;
DROP INDEX IF EXISTS public.reports_reorderanalysis_produit_id_5b323c68;
DROP INDEX IF EXISTS public.products_produit_groupe_id_8ec8d707;
DROP INDEX IF EXISTS public.products_produit_code_e00638ca_like;
DROP INDEX IF EXISTS public.products_inventaireproduit_utilisateur_id_78349851;
DROP INDEX IF EXISTS public.products_inventaireproduit_produit_id_081864c6;
DROP INDEX IF EXISTS public.products_inventaireproduit_mouvement_ajustement_id_e5e4a56d;
DROP INDEX IF EXISTS public.journal_mouvement_utilisateur_id_9c9197d6;
DROP INDEX IF EXISTS public.journal_mouvement_produit_id_f6def3e9;
DROP INDEX IF EXISTS public.inventory_sessioninventaire_responsable_id_b337bdf2;
DROP INDEX IF EXISTS public.inventory_sessioninventaire_reference_54d96633_like;
DROP INDEX IF EXISTS public.inventory_lignecomptage_session_id_a2e28985;
DROP INDEX IF EXISTS public.inventory_lignecomptage_produit_id_91aff6b1;
DROP INDEX IF EXISTS public.inventory_lignecomptage_operateur_id_31bb95d7;
DROP INDEX IF EXISTS public.inventory_l_session_926ee4_idx;
DROP INDEX IF EXISTS public.inventory_ajustementinventaire_valide_par_id_6e981e77;
DROP INDEX IF EXISTS public.inventory_ajustementinventaire_session_id_33c4352b;
DROP INDEX IF EXISTS public.inventory_ajustementinventaire_produit_id_f268bb1d;
DROP INDEX IF EXISTS public.import_export_importhistory_user_id_65394061;
DROP INDEX IF EXISTS public.import_export_exporthistory_user_id_d541b1ba;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_q_task_id_32882367_like;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.ai_recommandation_produit_id_7ffec4eb;
DROP INDEX IF EXISTS public.ai_recommandation_groupe_id_2739be33;
DROP INDEX IF EXISTS public.ai_prediction_produit_id_181df729;
DROP INDEX IF EXISTS public.ai_anomalie_produit_id_2c48ea36;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_username_key;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_permission_id_43338c45_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_group_id_b88eab82_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_email_key;
ALTER TABLE IF EXISTS ONLY public.reports_reordermonitoring DROP CONSTRAINT IF EXISTS reports_reordermonitoring_pkey;
ALTER TABLE IF EXISTS ONLY public.reports_reordermonitoring DROP CONSTRAINT IF EXISTS reports_reordermonitoring_date_key;
ALTER TABLE IF EXISTS ONLY public.reports_reorderconfiguration DROP CONSTRAINT IF EXISTS reports_reorderconfiguration_pkey;
ALTER TABLE IF EXISTS ONLY public.reports_reorderanalysis DROP CONSTRAINT IF EXISTS reports_reorderanalysis_produit_id_depot_calcula_55d2656d_uniq;
ALTER TABLE IF EXISTS ONLY public.reports_reorderanalysis DROP CONSTRAINT IF EXISTS reports_reorderanalysis_pkey;
ALTER TABLE IF EXISTS ONLY public.products_produit DROP CONSTRAINT IF EXISTS products_produit_pkey;
ALTER TABLE IF EXISTS ONLY public.products_produit DROP CONSTRAINT IF EXISTS products_produit_code_key;
ALTER TABLE IF EXISTS ONLY public.products_inventaireproduit DROP CONSTRAINT IF EXISTS products_inventaireproduit_pkey;
ALTER TABLE IF EXISTS ONLY public.products_groupe DROP CONSTRAINT IF EXISTS products_groupe_pkey;
ALTER TABLE IF EXISTS ONLY public.journal_mouvement DROP CONSTRAINT IF EXISTS journal_mouvement_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_sessioninventaire DROP CONSTRAINT IF EXISTS inventory_sessioninventaire_reference_key;
ALTER TABLE IF EXISTS ONLY public.inventory_sessioninventaire DROP CONSTRAINT IF EXISTS inventory_sessioninventaire_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_lignecomptage DROP CONSTRAINT IF EXISTS inventory_lignecomptage_session_id_produit_id_3ee03fa3_uniq;
ALTER TABLE IF EXISTS ONLY public.inventory_lignecomptage DROP CONSTRAINT IF EXISTS inventory_lignecomptage_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_ajustementinventaire DROP CONSTRAINT IF EXISTS inventory_ajustementinventaire_pkey;
ALTER TABLE IF EXISTS ONLY public.import_export_importhistory DROP CONSTRAINT IF EXISTS import_export_importhistory_pkey;
ALTER TABLE IF EXISTS ONLY public.import_export_exporthistory DROP CONSTRAINT IF EXISTS import_export_exporthistory_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_q_task DROP CONSTRAINT IF EXISTS django_q_task_pkey;
ALTER TABLE IF EXISTS ONLY public.django_q_schedule DROP CONSTRAINT IF EXISTS django_q_schedule_pkey;
ALTER TABLE IF EXISTS ONLY public.django_q_ormq DROP CONSTRAINT IF EXISTS django_q_ormq_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.ai_recommandation DROP CONSTRAINT IF EXISTS ai_recommandation_pkey;
ALTER TABLE IF EXISTS ONLY public.ai_prediction DROP CONSTRAINT IF EXISTS ai_prediction_pkey;
ALTER TABLE IF EXISTS ONLY public.ai_anomalie DROP CONSTRAINT IF EXISTS ai_anomalie_pkey;
DROP TABLE IF EXISTS public.users_user_user_permissions;
DROP TABLE IF EXISTS public.users_user_groups;
DROP TABLE IF EXISTS public.users_user;
DROP TABLE IF EXISTS public.reports_reordermonitoring;
DROP TABLE IF EXISTS public.reports_reorderconfiguration;
DROP TABLE IF EXISTS public.reports_reorderanalysis;
DROP TABLE IF EXISTS public.products_produit;
DROP TABLE IF EXISTS public.products_inventaireproduit;
DROP TABLE IF EXISTS public.products_groupe;
DROP TABLE IF EXISTS public.journal_mouvement;
DROP TABLE IF EXISTS public.inventory_sessioninventaire;
DROP TABLE IF EXISTS public.inventory_lignecomptage;
DROP TABLE IF EXISTS public.inventory_ajustementinventaire;
DROP TABLE IF EXISTS public.import_export_importhistory;
DROP TABLE IF EXISTS public.import_export_exporthistory;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_q_task;
DROP TABLE IF EXISTS public.django_q_schedule;
DROP TABLE IF EXISTS public.django_q_ormq;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.ai_recommandation;
DROP TABLE IF EXISTS public.ai_prediction;
DROP TABLE IF EXISTS public.ai_anomalie;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 25718)
-- Name: ai_anomalie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_anomalie (
    id bigint NOT NULL,
    date_detection timestamp with time zone NOT NULL,
    description text NOT NULL,
    score_anomalie double precision NOT NULL,
    est_resolue boolean NOT NULL,
    produit_id bigint NOT NULL
);


ALTER TABLE public.ai_anomalie OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25723)
-- Name: ai_anomalie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_anomalie ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_anomalie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 25724)
-- Name: ai_prediction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_prediction (
    id bigint NOT NULL,
    date_prediction timestamp with time zone NOT NULL,
    intervalle_confiance double precision NOT NULL,
    horizon integer NOT NULL,
    produit_id bigint NOT NULL
);


ALTER TABLE public.ai_prediction OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25727)
-- Name: ai_prediction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_prediction ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_prediction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 25728)
-- Name: ai_recommandation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_recommandation (
    id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    contenu text NOT NULL,
    type character varying(50) NOT NULL,
    est_appliquee boolean NOT NULL,
    groupe_id bigint,
    produit_id bigint
);


ALTER TABLE public.ai_recommandation OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25733)
-- Name: ai_recommandation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_recommandation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ai_recommandation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 25734)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25737)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 25738)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25741)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 25742)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25745)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 25746)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25752)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 25753)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25756)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 25757)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25762)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 25763)
-- Name: django_q_ormq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_ormq (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    payload text NOT NULL,
    lock timestamp with time zone
);


ALTER TABLE public.django_q_ormq OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 25768)
-- Name: django_q_ormq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_q_ormq ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_q_ormq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 25769)
-- Name: django_q_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_schedule (
    id integer NOT NULL,
    func character varying(256) NOT NULL,
    hook character varying(256),
    args text,
    kwargs text,
    schedule_type character varying(1) NOT NULL,
    repeats integer NOT NULL,
    next_run timestamp with time zone,
    task character varying(100),
    name character varying(100),
    minutes smallint,
    cron character varying(100),
    cluster character varying(100),
    CONSTRAINT django_q_schedule_minutes_check CHECK ((minutes >= 0))
);


ALTER TABLE public.django_q_schedule OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 25775)
-- Name: django_q_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_q_schedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_q_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 25776)
-- Name: django_q_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_task (
    name character varying(100) NOT NULL,
    func character varying(256) NOT NULL,
    hook character varying(256),
    args text,
    kwargs text,
    result text,
    started timestamp with time zone NOT NULL,
    stopped timestamp with time zone NOT NULL,
    success boolean NOT NULL,
    id character varying(32) NOT NULL,
    "group" character varying(100),
    attempt_count integer NOT NULL
);


ALTER TABLE public.django_q_task OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 25781)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 25786)
-- Name: import_export_exporthistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_export_exporthistory (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    export_type character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    filters jsonb NOT NULL,
    row_count integer NOT NULL,
    user_id bigint NOT NULL,
    completed_at timestamp with time zone,
    error_details text,
    status character varying(20) NOT NULL
);


ALTER TABLE public.import_export_exporthistory OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 25791)
-- Name: import_export_exporthistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.import_export_exporthistory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.import_export_exporthistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 243 (class 1259 OID 25792)
-- Name: import_export_importhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_export_importhistory (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    import_type character varying(20) NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    total_rows integer NOT NULL,
    processed_rows integer NOT NULL,
    success_rows integer NOT NULL,
    error_rows integer NOT NULL,
    error_details text,
    user_id bigint NOT NULL,
    file_size bigint
);


ALTER TABLE public.import_export_importhistory OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 25797)
-- Name: import_export_importhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.import_export_importhistory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.import_export_importhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 245 (class 1259 OID 25798)
-- Name: inventory_ajustementinventaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_ajustementinventaire (
    id bigint NOT NULL,
    quantite_theorique numeric(14,3) NOT NULL,
    quantite_physique numeric(14,3) NOT NULL,
    ecart numeric(14,3) NOT NULL,
    date_ajustement timestamp with time zone NOT NULL,
    commentaire text NOT NULL,
    produit_id bigint NOT NULL,
    session_id bigint NOT NULL,
    valide_par_id bigint
);


ALTER TABLE public.inventory_ajustementinventaire OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 25803)
-- Name: inventory_ajustementinventaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_ajustementinventaire ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_ajustementinventaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 25804)
-- Name: inventory_lignecomptage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_lignecomptage (
    id bigint NOT NULL,
    quantite_physique numeric(14,3) NOT NULL,
    date_comptage timestamp with time zone NOT NULL,
    operateur_id bigint NOT NULL,
    produit_id bigint NOT NULL,
    session_id bigint NOT NULL
);


ALTER TABLE public.inventory_lignecomptage OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 25807)
-- Name: inventory_lignecomptage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_lignecomptage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_lignecomptage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 249 (class 1259 OID 25808)
-- Name: inventory_sessioninventaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_sessioninventaire (
    id bigint NOT NULL,
    reference character varying(40) NOT NULL,
    date_debut timestamp with time zone NOT NULL,
    date_fin timestamp with time zone,
    statut character varying(10) NOT NULL,
    responsable_id bigint NOT NULL
);


ALTER TABLE public.inventory_sessioninventaire OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25811)
-- Name: inventory_sessioninventaire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_sessioninventaire ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_sessioninventaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 251 (class 1259 OID 25812)
-- Name: journal_mouvement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.journal_mouvement (
    id bigint NOT NULL,
    mouvement character varying(20) NOT NULL,
    quantite integer NOT NULL,
    stock_avant integer NOT NULL,
    stock_apres integer NOT NULL,
    demandeur character varying(100) NOT NULL,
    date timestamp with time zone NOT NULL,
    observation text,
    produit_id bigint NOT NULL,
    utilisateur_id bigint
);


ALTER TABLE public.journal_mouvement OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25817)
-- Name: journal_mouvement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.journal_mouvement ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.journal_mouvement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 253 (class 1259 OID 25818)
-- Name: products_groupe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_groupe (
    id bigint NOT NULL,
    nom character varying(100) NOT NULL,
    description text,
    couleur character varying(20),
    date_creation timestamp with time zone NOT NULL,
    date_modification timestamp with time zone NOT NULL
);


ALTER TABLE public.products_groupe OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25823)
-- Name: products_groupe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products_groupe ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_groupe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 255 (class 1259 OID 25824)
-- Name: products_inventaireproduit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_inventaireproduit (
    id bigint NOT NULL,
    stock_systeme numeric(10,2) NOT NULL,
    stock_physique numeric(10,2) NOT NULL,
    ecart numeric(10,2) NOT NULL,
    date_inventaire timestamp with time zone NOT NULL,
    observation text,
    ajustement_effectue boolean NOT NULL,
    mouvement_ajustement_id bigint,
    produit_id bigint NOT NULL,
    utilisateur_id bigint NOT NULL
);


ALTER TABLE public.products_inventaireproduit OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25829)
-- Name: products_inventaireproduit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products_inventaireproduit ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_inventaireproduit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 257 (class 1259 OID 25830)
-- Name: products_produit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_produit (
    id bigint NOT NULL,
    code character varying(50) NOT NULL,
    nom character varying(200) NOT NULL,
    stock_initial integer NOT NULL,
    seuil integer NOT NULL,
    unite character varying(50) NOT NULL,
    zone character varying(100),
    observation text,
    date_creation timestamp with time zone NOT NULL,
    date_modification timestamp with time zone NOT NULL,
    groupe_id bigint,
    lead_time integer NOT NULL
);


ALTER TABLE public.products_produit OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 25835)
-- Name: products_produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products_produit ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_produit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 259 (class 1259 OID 25836)
-- Name: reports_reorderanalysis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports_reorderanalysis (
    id bigint NOT NULL,
    depot character varying(100) NOT NULL,
    avg_daily_demand numeric(10,3) NOT NULL,
    sigma_daily_demand numeric(10,3) NOT NULL,
    lead_time_days integer NOT NULL,
    safety_stock numeric(10,2) NOT NULL,
    reorder_point numeric(10,2) NOT NULL,
    predicted_30d numeric(10,2) NOT NULL,
    days_of_coverage numeric(10,2) NOT NULL,
    suggested_qty numeric(10,2) NOT NULL,
    status character varying(20) NOT NULL,
    confidence_level character varying(10) NOT NULL,
    confidence_reason text NOT NULL,
    calculation_date timestamp with time zone NOT NULL,
    window_days_used integer NOT NULL,
    z_factor_used numeric(5,2) NOT NULL,
    movements_count integer NOT NULL,
    explanation jsonb NOT NULL,
    produit_id bigint NOT NULL
);


ALTER TABLE public.reports_reorderanalysis OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 25841)
-- Name: reports_reorderanalysis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reports_reorderanalysis ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reports_reorderanalysis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 261 (class 1259 OID 25842)
-- Name: reports_reorderconfiguration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports_reorderconfiguration (
    id bigint NOT NULL,
    window_days integer NOT NULL,
    forecast_horizon integer NOT NULL,
    z_factor numeric(5,2) NOT NULL,
    default_lead_time integer NOT NULL,
    urgent_threshold_multiplier numeric(3,1) NOT NULL,
    monitor_threshold_multiplier numeric(3,1) NOT NULL,
    min_historical_days_for_confidence integer NOT NULL,
    min_movements_for_confidence integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE public.reports_reorderconfiguration OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25845)
-- Name: reports_reorderconfiguration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reports_reorderconfiguration ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reports_reorderconfiguration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 263 (class 1259 OID 25846)
-- Name: reports_reordermonitoring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports_reordermonitoring (
    id bigint NOT NULL,
    date date NOT NULL,
    urgent_count integer NOT NULL,
    monitor_count integer NOT NULL,
    ok_count integer NOT NULL,
    total_suggested_units numeric(15,2) NOT NULL,
    draft_orders_created integer NOT NULL,
    draft_orders_approved integer NOT NULL,
    batch_execution_time numeric(10,2),
    batch_success boolean NOT NULL,
    batch_error_message text NOT NULL,
    average_confidence numeric(5,2),
    low_confidence_count integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.reports_reordermonitoring OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25851)
-- Name: reports_reordermonitoring_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reports_reordermonitoring ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reports_reordermonitoring_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 265 (class 1259 OID 25852)
-- Name: users_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    email character varying(254) NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    date_modification timestamp with time zone NOT NULL,
    password_changed_at timestamp with time zone NOT NULL,
    password_expiry_days integer NOT NULL,
    session_timeout integer NOT NULL
);


ALTER TABLE public.users_user OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 25857)
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 25860)
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 268 (class 1259 OID 25861)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 269 (class 1259 OID 25862)
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25865)
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5070 (class 0 OID 25718)
-- Dependencies: 217
-- Data for Name: ai_anomalie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_anomalie (id, date_detection, description, score_anomalie, est_resolue, produit_id) FROM stdin;
\.


--
-- TOC entry 5072 (class 0 OID 25724)
-- Dependencies: 219
-- Data for Name: ai_prediction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_prediction (id, date_prediction, intervalle_confiance, horizon, produit_id) FROM stdin;
\.


--
-- TOC entry 5074 (class 0 OID 25728)
-- Dependencies: 221
-- Data for Name: ai_recommandation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_recommandation (id, date_creation, contenu, type, est_appliquee, groupe_id, produit_id) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 25734)
-- Dependencies: 223
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 5078 (class 0 OID 25738)
-- Dependencies: 225
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 5080 (class 0 OID 25742)
-- Dependencies: 227
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add Groupe	7	add_groupe
26	Can change Groupe	7	change_groupe
27	Can delete Groupe	7	delete_groupe
28	Can view Groupe	7	view_groupe
29	Can add Produit	8	add_produit
30	Can change Produit	8	change_produit
31	Can delete Produit	8	delete_produit
32	Can view Produit	8	view_produit
33	Can add Mouvement	9	add_mouvement
34	Can change Mouvement	9	change_mouvement
35	Can delete Mouvement	9	delete_mouvement
36	Can view Mouvement	9	view_mouvement
37	Can add Recommandation	10	add_recommandation
38	Can change Recommandation	10	change_recommandation
39	Can delete Recommandation	10	delete_recommandation
40	Can view Recommandation	10	view_recommandation
41	Can add Prédiction	11	add_prediction
42	Can change Prédiction	11	change_prediction
43	Can delete Prédiction	11	delete_prediction
44	Can view Prédiction	11	view_prediction
45	Can add Anomalie	12	add_anomalie
46	Can change Anomalie	12	change_anomalie
47	Can delete Anomalie	12	delete_anomalie
48	Can view Anomalie	12	view_anomalie
49	Can add import history	13	add_importhistory
50	Can change import history	13	change_importhistory
51	Can delete import history	13	delete_importhistory
52	Can view import history	13	view_importhistory
53	Can add export history	14	add_exporthistory
54	Can change export history	14	change_exporthistory
55	Can delete export history	14	delete_exporthistory
56	Can view export history	14	view_exporthistory
57	Can add Inventaire Produit	15	add_inventaireproduit
58	Can change Inventaire Produit	15	change_inventaireproduit
59	Can delete Inventaire Produit	15	delete_inventaireproduit
60	Can view Inventaire Produit	15	view_inventaireproduit
61	Can add Session d'inventaire	16	add_sessioninventaire
62	Can change Session d'inventaire	16	change_sessioninventaire
63	Can delete Session d'inventaire	16	delete_sessioninventaire
64	Can view Session d'inventaire	16	view_sessioninventaire
65	Can add Ajustement d'inventaire	17	add_ajustementinventaire
66	Can change Ajustement d'inventaire	17	change_ajustementinventaire
67	Can delete Ajustement d'inventaire	17	delete_ajustementinventaire
68	Can view Ajustement d'inventaire	17	view_ajustementinventaire
69	Can add Ligne de comptage	18	add_lignecomptage
70	Can change Ligne de comptage	18	change_lignecomptage
71	Can delete Ligne de comptage	18	delete_lignecomptage
72	Can view Ligne de comptage	18	view_lignecomptage
73	Can add Configuration Point de Commande	19	add_reorderconfiguration
74	Can change Configuration Point de Commande	19	change_reorderconfiguration
75	Can delete Configuration Point de Commande	19	delete_reorderconfiguration
76	Can view Configuration Point de Commande	19	view_reorderconfiguration
77	Can add Monitoring Recommandations	20	add_reordermonitoring
78	Can change Monitoring Recommandations	20	change_reordermonitoring
79	Can delete Monitoring Recommandations	20	delete_reordermonitoring
80	Can view Monitoring Recommandations	20	view_reordermonitoring
81	Can add Bon de Commande Brouillon	21	add_draftpurchaseorder
82	Can change Bon de Commande Brouillon	21	change_draftpurchaseorder
83	Can delete Bon de Commande Brouillon	21	delete_draftpurchaseorder
84	Can view Bon de Commande Brouillon	21	view_draftpurchaseorder
85	Can add Analyse Point de Commande	22	add_reorderanalysis
86	Can change Analyse Point de Commande	22	change_reorderanalysis
87	Can delete Analyse Point de Commande	22	delete_reorderanalysis
88	Can view Analyse Point de Commande	22	view_reorderanalysis
89	Can add Scheduled task	23	add_schedule
90	Can change Scheduled task	23	change_schedule
91	Can delete Scheduled task	23	delete_schedule
92	Can view Scheduled task	23	view_schedule
93	Can add task	24	add_task
94	Can change task	24	change_task
95	Can delete task	24	delete_task
96	Can view task	24	view_task
97	Can add Failed task	25	add_failure
98	Can change Failed task	25	change_failure
99	Can delete Failed task	25	delete_failure
100	Can view Failed task	25	view_failure
101	Can add Successful task	26	add_success
102	Can change Successful task	26	change_success
103	Can delete Successful task	26	delete_success
104	Can view Successful task	26	view_success
105	Can add Queued task	27	add_ormq
106	Can change Queued task	27	change_ormq
107	Can delete Queued task	27	delete_ormq
108	Can view Queued task	27	view_ormq
\.


--
-- TOC entry 5082 (class 0 OID 25746)
-- Dependencies: 229
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 5084 (class 0 OID 25753)
-- Dependencies: 231
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	users	user
7	products	groupe
8	products	produit
9	journal	mouvement
10	ai	recommandation
11	ai	prediction
12	ai	anomalie
13	import_export	importhistory
14	import_export	exporthistory
15	products	inventaireproduit
16	inventory	sessioninventaire
17	inventory	ajustementinventaire
18	inventory	lignecomptage
19	reports	reorderconfiguration
20	reports	reordermonitoring
21	reports	draftpurchaseorder
22	reports	reorderanalysis
23	django_q	schedule
24	django_q	task
25	django_q	failure
26	django_q	success
27	django_q	ormq
\.


--
-- TOC entry 5086 (class 0 OID 25757)
-- Dependencies: 233
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-06-18 14:49:49.220976+02
2	contenttypes	0002_remove_content_type_name	2025-06-18 14:49:49.243117+02
3	auth	0001_initial	2025-06-18 14:49:49.347667+02
4	auth	0002_alter_permission_name_max_length	2025-06-18 14:49:49.359193+02
5	auth	0003_alter_user_email_max_length	2025-06-18 14:49:49.371888+02
6	auth	0004_alter_user_username_opts	2025-06-18 14:49:49.383771+02
7	auth	0005_alter_user_last_login_null	2025-06-18 14:49:49.395503+02
8	auth	0006_require_contenttypes_0002	2025-06-18 14:49:49.401818+02
9	auth	0007_alter_validators_add_error_messages	2025-06-18 14:49:49.417459+02
10	auth	0008_alter_user_username_max_length	2025-06-18 14:49:49.431813+02
11	auth	0009_alter_user_last_name_max_length	2025-06-18 14:49:49.445765+02
12	auth	0010_alter_group_name_max_length	2025-06-18 14:49:49.469028+02
13	auth	0011_update_proxy_permissions	2025-06-18 14:49:49.482461+02
14	auth	0012_alter_user_first_name_max_length	2025-06-18 14:49:49.497043+02
15	users	0001_initial	2025-06-18 14:49:49.641185+02
16	admin	0001_initial	2025-06-18 14:49:49.691587+02
17	admin	0002_logentry_remove_auto_add	2025-06-18 14:49:49.710691+02
18	admin	0003_logentry_add_action_flag_choices	2025-06-18 14:49:49.738268+02
19	products	0001_initial	2025-06-18 14:49:49.798393+02
20	ai	0001_initial	2025-06-18 14:49:49.901976+02
21	import_export	0001_initial	2025-06-18 14:49:49.99652+02
22	journal	0001_initial	2025-06-18 14:49:50.052266+02
23	sessions	0001_initial	2025-06-18 14:49:50.07468+02
24	users	0002_remove_user_departement_remove_user_poste	2025-06-18 15:34:41.811729+02
25	products	0002_remove_groupe_responsable_remove_groupe_zone	2025-06-20 10:04:23.335226+02
26	products	0003_remove_produit_prix	2025-06-20 11:13:57.622836+02
27	users	0003_user_date_format_user_theme	2025-07-15 10:43:34.622484+02
28	users	0004_alter_user_date_format_alter_user_theme	2025-07-15 10:51:28.41164+02
29	users	0005_remove_user_date_format_remove_user_theme	2025-07-15 11:09:50.456158+02
30	ai	0002_remove_prediction_valeur_predite	2025-07-15 11:18:53.318144+02
31	import_export	0002_alter_exporthistory_export_type	2025-07-15 11:18:53.350985+02
32	import_export	0003_alter_exporthistory_export_type	2025-07-30 10:52:45.839717+02
33	import_export	0004_importhistory_file_size	2025-08-05 09:31:07.404889+02
34	products	0004_produit_stock_initial_fixe_inventaireproduit	2025-08-06 11:13:29.58802+02
35	inventory	0001_initial	2025-08-18 09:34:04.761841+02
36	products	0005_remove_produit_stock_initial_fixe	2025-08-18 11:43:06.52767+02
37	reports	0001_initial	2025-08-19 09:52:18.481207+02
38	django_q	0001_initial	2025-08-19 10:43:43.876678+02
39	django_q	0002_auto_20150630_1624	2025-08-19 10:43:43.907695+02
40	django_q	0003_auto_20150708_1326	2025-08-19 10:43:43.989032+02
41	django_q	0004_auto_20150710_1043	2025-08-19 10:43:44.003625+02
42	django_q	0005_auto_20150718_1506	2025-08-19 10:43:44.020276+02
43	django_q	0006_auto_20150805_1817	2025-08-19 10:43:44.035408+02
44	django_q	0007_ormq	2025-08-19 10:43:44.062169+02
45	django_q	0008_auto_20160224_1026	2025-08-19 10:43:44.073776+02
46	django_q	0009_auto_20171009_0915	2025-08-19 10:43:44.102501+02
47	django_q	0010_auto_20200610_0856	2025-08-19 10:43:44.135861+02
48	django_q	0011_auto_20200628_1055	2025-08-19 10:43:44.148666+02
49	django_q	0012_auto_20200702_1608	2025-08-19 10:43:44.157211+02
50	django_q	0013_task_attempt_count	2025-08-19 10:43:44.170404+02
51	django_q	0014_schedule_cluster	2025-08-19 10:43:44.176427+02
52	users	0006_user_password_changed_at_user_password_expiry_days_and_more	2025-09-01 13:05:40.091577+02
53	reports	0002_delete_draftpurchaseorder	2025-09-01 15:17:20.178275+02
54	import_export	0005_exporthistory_completed_at_and_more	2025-09-04 08:48:25.388106+02
55	import_export	0006_alter_exporthistory_export_type	2025-09-04 09:02:34.680244+02
56	products	0006_produit_lead_time	2025-09-04 12:28:15.612196+02
57	journal	0002_mouvement_date_effective_mouvement_type_document	2025-10-06 10:47:24.840556+02
58	journal	0003_remove_mouvement_date_effective_and_more	2025-10-06 10:52:53.87778+02
59	journal	0004_alter_mouvement_date	2025-10-06 11:12:42.323603+02
\.


--
-- TOC entry 5088 (class 0 OID 25763)
-- Dependencies: 235
-- Data for Name: django_q_ormq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_ormq (id, key, payload, lock) FROM stdin;
458	plateforme_avance	gAWV9QAAAAAAAAB9lCiMAmlklIwgODIxYzQwZjRjOTMyNDNhMDgwZTI2Y2ZjYzlkZDE4NjmUjARuYW1llIwWY29sb3JhZG8tYmx1ZS13ZXN0LWlua5SMBGZ1bmOUjBxiYWNrdXAudGFza3MuYmFja3VwX2RhdGFiYXNllIwEYXJnc5QpjAthY2tfZmFpbHVyZZSIjAZrd2FyZ3OUfZSMB3N0YXJ0ZWSUjAhkYXRldGltZZSMCGRhdGV0aW1llJOUQwoH6QoOBiQBAxw3lGgMjAh0aW1lem9uZZSTlGgMjAl0aW1lZGVsdGGUk5RLAEsASwCHlFKUhZRSlIaUUpR1Lg:1v8Ydd:PvV2mZdRoVocToZraq5ZKCA7Nsubr7AH3VPB1cwWrXw	2025-10-14 08:36:01.31079+02
\.


--
-- TOC entry 5090 (class 0 OID 25769)
-- Dependencies: 237
-- Data for Name: django_q_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_schedule (id, func, hook, args, kwargs, schedule_type, repeats, next_run, task, name, minutes, cron, cluster) FROM stdin;
46	reports.tasks.daily_reorder_calculation	\N	()	{'kwargs': {'depot': 'Principal'}}	D	-13	2025-10-15 04:00:00+02	0fdb2ffcb1f14cfb83d6c04e1556cfb1	daily_reorder_calculation	\N	\N	\N
48	reports.tasks.generate_critical_alerts	\N	()	{}	H	-55	2025-10-14 09:00:00+02	5acacd6949f944609fa01b2f8ace8d85	hourly_critical_alerts	\N	\N	\N
47	reports.tasks.cleanup_old_analyses	\N	()	{'kwargs': {'days_to_keep': 90}}	W	-5	2025-10-15 05:00:00+02	e61a93a8c4d947599a8f43bf62a3714d	weekly_cleanup	\N	\N	\N
\.


--
-- TOC entry 5092 (class 0 OID 25776)
-- Dependencies: 239
-- Data for Name: django_q_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_task (name, func, hook, args, kwargs, result, started, stopped, success, id, "group", attempt_count) FROM stdin;
high-sierra-paris-uncle	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 12:46:47.085923+02	2025-09-04 12:46:48.14342+02	t	e9154ced576f46bbadb690271a17c42c	weekly_cleanup	1
saturn-rugby-music-nevada	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 12:46:47.091622+02	2025-09-04 12:46:48.194412+02	t	86f35fea06d64a27a864d78da774aae3	hourly_critical_alerts	1
tennis-high-ink-vegan	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVXwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiYwFZXJyb3KUjERwcm9wZXJ0eSAnYXBwcm92YWxfcmF0ZScgb2YgJ1Jlb3JkZXJNb25pdG9yaW5nJyBvYmplY3QgaGFzIG5vIHNldHRlcpR1Lg==	2025-09-04 12:46:47.052974+02	2025-09-04 12:46:48.950053+02	t	6b778242f26543898e0535db5911c664	daily_reorder_calculation	1
fix-mobile-west-cat	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgqUhZRSlHUu	2025-09-08 11:42:43.627353+02	2025-09-08 11:42:44.355357+02	t	c590f0ed3a234fd9a66a043abfa4efd7	weekly_cleanup	1
bacon-hydrogen-eleven-gee	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 11:42:43.631298+02	2025-09-08 11:42:44.365539+02	t	939b445c3ecb45d0967515cb879797d5	hourly_critical_alerts	1
twenty-violet-yankee-oscar	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/1EVWAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-09-08 11:42:43.600336+02	2025-09-08 11:42:44.453142+02	t	ee1c2736143b44848cb530f5b5ca5285	daily_reorder_calculation	1
orange-connecticut-pip-six	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 12:58:40.066696+02	2025-09-04 12:58:40.629803+02	t	e458021b3ef84ca6b2a817a2ed1982be	weekly_cleanup	1
fifteen-speaker-tango-bacon	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 12:58:40.072403+02	2025-09-04 12:58:40.637657+02	t	06550d1df5514c39b64d6c4e0518b6bb	hourly_critical_alerts	1
wolfram-muppet-fifteen-maine	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVPgAAAAAAAAB9lCiMB3N1Y2Nlc3OUiYwFZXJyb3KUjCNuYW1lICdtb25pdG9yX2NvdW50JyBpcyBub3QgZGVmaW5lZJR1Lg==	2025-09-04 12:58:40.058472+02	2025-09-04 12:58:40.676567+02	t	49f53b7ed0ff45ff9198b5ff13d699dd	daily_reorder_calculation	1
four-december-william-blossom	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 13:00:10.616303+02	2025-09-04 13:00:10.860878+02	t	ac4d9e3319034f659b6aceca16d3ad7f	hourly_critical_alerts	1
leopard-venus-spring-bacon	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 12:00:21.413539+02	2025-09-08 12:00:22.05711+02	t	40287b6ba5184f1983e7b600ba431cf5	hourly_critical_alerts	1
don-minnesota-minnesota-papa	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 14:00:27.957535+02	2025-09-04 14:00:29.260328+02	t	5e849f7168564affaa94ef5acfc56ccd	hourly_critical_alerts	1
ink-don-ten-robert	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVTAAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLAIwLZXJyb3JfY291bnSUSwSMDmV4ZWN1dGlvbl90aW1llEdABtsKYAAAAHUu	2025-09-08 10:45:02.268027+02	2025-09-08 10:45:07.107995+02	t	bc6c833698ad4f4ea6a4a47c97b751cb	daily_reorder_calculation	1
august-johnny-stairway-sad	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 10:45:02.047819+02	2025-09-08 10:45:10.358624+02	t	6086fb1048dd4eb0bc23337f651031fa	hourly_critical_alerts	1
romeo-one-avocado-ink	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 11:00:28.880478+02	2025-09-08 11:00:38.347663+02	t	9d02dffc0be44a018dfd7d02fe374ce0	hourly_critical_alerts	1
delta-michigan-don-march	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:23:43.319657+02	2025-08-28 20:23:43.486144+02	t	42902fcfd7f946e19e24018f5dd6e6ee	hourly_critical_alerts	1
indigo-friend-september-hot	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:24:13.486476+02	2025-08-28 20:24:13.550714+02	t	0a3dc99a3e5a4773965bb3bf62671e45	hourly_critical_alerts	1
louisiana-kilo-may-jersey	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:24:43.62237+02	2025-08-28 20:24:43.781634+02	t	c3cb582d66f24aafb73376751804582d	hourly_critical_alerts	1
aspen-missouri-eleven-xray	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:25:13.919757+02	2025-08-28 20:25:14.129605+02	t	3040f589afc94ea6aea592a4c0ede432	hourly_critical_alerts	1
oregon-potato-lion-chicken	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:25:44.125942+02	2025-08-28 20:25:44.193764+02	t	8f50a7df6791490d899d6e006461ccef	hourly_critical_alerts	1
red-illinois-network-comet	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:26:14.382104+02	2025-08-28 20:26:14.488303+02	t	c74484bf88064ca0ac89f14d43da0ebc	hourly_critical_alerts	1
asparagus-sad-stream-network	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:26:45.077907+02	2025-08-28 20:26:45.190587+02	t	e097423ee4d845c7930ed29a5f6b6fc2	hourly_critical_alerts	1
maine-leopard-blue-maine	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:27:15.222449+02	2025-08-28 20:27:15.244088+02	t	4b4e4acecab14e4d8182a5be05c98fc2	hourly_critical_alerts	1
single-bakerloo-sweet-red	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:27:45.380856+02	2025-08-28 20:27:45.472843+02	t	c9de24f5c704449697b5d2277087c887	hourly_critical_alerts	1
don-oscar-spring-west	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:28:15.525151+02	2025-08-28 20:28:15.551523+02	t	e9781cb99bd24dacb5fc20bb7ba2052e	hourly_critical_alerts	1
bakerloo-michigan-crazy-two	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:28:45.670409+02	2025-08-28 20:28:45.742901+02	t	783d4317bf4441339b411bec0b8c2e4d	hourly_critical_alerts	1
robin-hydrogen-delaware-pennsylvania	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:29:15.801035+02	2025-08-28 20:29:15.982093+02	t	66564cc72b4a474681a20b190426dc50	hourly_critical_alerts	1
indigo-asparagus-music-spaghetti	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:29:47.189401+02	2025-08-28 20:29:47.5978+02	t	4d00d0f9a4144ff4b9a6e0695a41b279	hourly_critical_alerts	1
comet-network-asparagus-london	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:30:18.355253+02	2025-08-28 20:30:19.565318+02	t	9d4045b3d629412795cbe0b5842d0adf	hourly_critical_alerts	1
venus-papa-magnesium-kentucky	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:30:49.598069+02	2025-08-28 20:30:49.639047+02	t	b197a8651f2442d2a49c4af2e6a681b1	hourly_critical_alerts	1
ink-nineteen-cold-diet	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:31:19.813964+02	2025-08-28 20:31:20.042596+02	t	64224b681cdd431ea7ddf1a2817a18d0	hourly_critical_alerts	1
lamp-ack-golf-black	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:31:49.962816+02	2025-08-28 20:31:50.273508+02	t	b7e71b3dfacc4b7da37af07c287a1652	hourly_critical_alerts	1
green-leopard-music-nineteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:32:20.366604+02	2025-08-28 20:32:20.402444+02	t	01b6fc1d28754c69a949cabc8ecbab72	hourly_critical_alerts	1
tennessee-double-idaho-oregon	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:32:50.507724+02	2025-08-28 20:32:50.692862+02	t	d771ccb1ccfe484f80fabda693bcfe76	hourly_critical_alerts	1
diet-queen-louisiana-colorado	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:33:20.648+02	2025-08-28 20:33:20.782265+02	t	7c976fb7a3b244e38c6d831fcdc8a08f	hourly_critical_alerts	1
quiet-triple-ohio-berlin	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:33:50.788277+02	2025-08-28 20:33:50.851781+02	t	ab37dff4e725436096faa06e75ab7fb5	hourly_critical_alerts	1
leopard-rugby-cold-low	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:34:20.897947+02	2025-08-28 20:34:21.016516+02	t	1bc5319704084ffea28b9f9f5b4e365d	hourly_critical_alerts	1
alpha-ink-delta-nebraska	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:34:50.983804+02	2025-08-28 20:34:51.177847+02	t	1f0d786e1c9f45a3bacd4c0991f9b04f	hourly_critical_alerts	1
seven-happy-carpet-johnny	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:35:21.077215+02	2025-08-28 20:35:21.156369+02	t	5ec37c23e7cf49389e7400c88712e719	hourly_critical_alerts	1
princess-undress-lion-hydrogen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:35:51.17328+02	2025-08-28 20:35:51.320038+02	t	ad49f3a44f8d4a6eac62368255c730c2	hourly_critical_alerts	1
coffee-finch-alanine-princess	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:36:21.269072+02	2025-08-28 20:36:21.281383+02	t	b5e7fa8faf434ce5a0b21101a32497a3	hourly_critical_alerts	1
early-kitten-undress-kansas	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:36:51.353608+02	2025-08-28 20:36:51.386006+02	t	671d1854c75f43a89d0dc7b15a212d39	hourly_critical_alerts	1
beer-burger-hawaii-august	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:37:21.456801+02	2025-08-28 20:37:21.498317+02	t	96b76e5cf5dd4074adc2eeda371f1237	hourly_critical_alerts	1
fish-six-two-low	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:37:51.570584+02	2025-08-28 20:37:51.675189+02	t	88d3726f2e984b358d036f05aef5c7e2	hourly_critical_alerts	1
winner-sierra-avocado-vegan	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:38:21.700153+02	2025-08-28 20:38:21.901717+02	t	bc9a1fcf99234639ae8e7956aefdbf06	hourly_critical_alerts	1
three-sweet-equal-nitrogen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:38:51.844142+02	2025-08-28 20:38:51.922383+02	t	f0cbd5313d4140eb999deca845c17f66	hourly_critical_alerts	1
lemon-quebec-skylark-football	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:39:21.944149+02	2025-08-28 20:39:21.967443+02	t	aaefd7e58ca74cd2890fcb873763b5aa	hourly_critical_alerts	1
foxtrot-tennis-mike-delaware	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:39:54.238132+02	2025-08-28 20:39:54.458758+02	t	b90445b67ae8430d964dfcadad9b2126	hourly_critical_alerts	1
alaska-november-twelve-pizza	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:40:24.346463+02	2025-08-28 20:40:24.582284+02	t	7b627b61b614467b817331218a1fa580	hourly_critical_alerts	1
mango-beryllium-south-georgia	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:40:54.439694+02	2025-08-28 20:40:54.617516+02	t	f7ccee57c62943b9b408dcaf945631a0	hourly_critical_alerts	1
paris-cold-solar-orange	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 20:41:24.642545+02	2025-08-28 20:41:24.775021+02	t	cf866c8932474a16989ccc0687219497	hourly_critical_alerts	1
quebec-october-winner-fanta	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 21:00:10.366591+02	2025-08-28 21:00:10.607106+02	t	a94d13420d4d44a5b1fed16819eab001	hourly_critical_alerts	1
nitrogen-bacon-oscar-pip	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVTQAAAAAAAACMSUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogW1dpbkVycm9yIDJdIExlIGZpY2hpZXIgc3DDqWNpZmnDqSBlc3QgaW50cm91dmFibGWULg==	2025-08-28 21:13:47.110665+02	2025-08-28 21:13:47.59078+02	t	a145dba21a394675a02a6644c24fa785	\N	1
maine-finch-stairway-golf	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVTQAAAAAAAACMSUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogW1dpbkVycm9yIDJdIExlIGZpY2hpZXIgc3DDqWNpZmnDqSBlc3QgaW50cm91dmFibGWULg==	2025-08-28 21:27:13.727042+02	2025-08-28 21:27:14.685862+02	t	db7d3b1ceda2464cbf65d7de70cced04	\N	1
tango-zulu-may-fruit	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVTQAAAAAAAACMSUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogW1dpbkVycm9yIDJdIExlIGZpY2hpZXIgc3DDqWNpZmnDqSBlc3QgaW50cm91dmFibGWULg==	2025-08-28 21:36:58.270105+02	2025-08-28 21:36:58.44112+02	t	f3c5ea05f53e487caa19cefaf6c7f292	\N	1
dakota-wisconsin-montana-london	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 22:02:20.776357+02	2025-08-28 22:02:21.298534+02	t	413af5a109804f3e9d72413ca1e4c5fc	hourly_critical_alerts	1
orange-chicken-emma-pennsylvania	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVJQAAAAAAAACMIUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogJ3Bhc3N3b3JkJ5Qu	2025-08-28 22:03:49.842416+02	2025-08-28 22:03:49.884506+02	t	a59ff46b4d47436f93ae282b150413ac	\N	1
cardinal-maine-gee-romeo	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVJQAAAAAAAACMIUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogJ3Bhc3N3b3JkJ5Qu	2025-08-28 22:24:17.310656+02	2025-08-28 22:24:19.07962+02	t	4eaea9693c7d4282b62977babcfbdd26	\N	1
steak-jupiter-connecticut-wisconsin	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWVJQAAAAAAAACMIUVycmV1ciBkZSBzYXV2ZWdhcmRlIDogJ3Bhc3N3b3JkJ5Qu	2025-08-28 22:41:42.474925+02	2025-08-28 22:41:42.887623+02	t	5fa1270de95a4598b204ad37016dee7a	\N	1
september-violet-blossom-alaska	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-28 23:00:09.316322+02	2025-08-28 23:00:09.66639+02	t	0f0ec303d6654b17b25aae51f88a8dfc	hourly_critical_alerts	1
two-lamp-cardinal-fish	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA4MjhfMjMxNDIyLnNxbCAoMjAwMTI4IGJ5dGVzKZQu	2025-08-28 23:14:21.640833+02	2025-08-28 23:14:22.847259+02	t	fb5e3978debb41528672bb6f37e50f9b	\N	1
illinois-purple-aspen-kilo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 00:00:26.871353+02	2025-08-29 00:00:27.349245+02	t	162d1a4375af4d23b16e21f2944bb618	hourly_critical_alerts	1
cola-quiet-river-vermont	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 07:59:23.030523+02	2025-08-29 07:59:23.984131+02	t	4a553b0cfc7a4f7e88fd32fe0ebaf5ad	hourly_critical_alerts	1
lamp-mars-coffee-robert	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 08:00:23.612354+02	2025-08-29 08:00:23.759372+02	t	9694087c52114582b8c8eabd71f85764	hourly_critical_alerts	1
island-cold-beryllium-mountain	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 09:00:06.400526+02	2025-08-29 09:00:06.940799+02	t	9c75870930e447ba99c2d19f5e68c96b	hourly_critical_alerts	1
vermont-blue-single-william	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 11:24:03.526924+02	2025-08-29 11:24:04.22216+02	t	6d7e2bd43ae8468cb0292679e0deb17a	hourly_critical_alerts	1
jupiter-november-wyoming-massachusetts	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 12:00:01.20178+02	2025-08-29 12:00:01.649648+02	t	dcb464621e094bc3bde40ba8f6a004d4	hourly_critical_alerts	1
item-berlin-monkey-magnesium	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 19:38:30.709841+02	2025-08-29 19:38:31.156277+02	t	f3d2bff6ab894375a125d8cdb10c1825	hourly_critical_alerts	1
montana-nuts-finch-skylark	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 20:00:06.363474+02	2025-08-29 20:00:06.624956+02	t	6bb5276bde384e0897a83842921c9dd9	hourly_critical_alerts	1
early-ink-grey-aspen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 21:00:07.69285+02	2025-08-29 21:00:08.798339+02	t	860c34885d234f54b1fadfc30481951c	hourly_critical_alerts	1
six-wisconsin-tango-high	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 22:00:22.81045+02	2025-08-29 22:00:23.29845+02	t	2b0ac72e5d3f4bd1872f2253afe9bba0	hourly_critical_alerts	1
papa-bakerloo-illinois-thirteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-29 23:00:05.329878+02	2025-08-29 23:00:06.00466+02	t	7fd6919330a147c797de674c297841ce	hourly_critical_alerts	1
connecticut-arizona-north-butter	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-30 22:09:54.801187+02	2025-08-30 22:09:55.63612+02	t	c407c12e34014479bbe81dd065f98706	hourly_critical_alerts	1
sweet-aspen-summer-uniform	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-30 23:00:02.33411+02	2025-08-30 23:00:02.893348+02	t	126e48e3512e4b3896e79433bbaaf402	hourly_critical_alerts	1
saturn-ceiling-pasta-seven	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 02:16:40.499511+02	2025-08-31 02:16:41.462428+02	t	a2349ec85834450db8fe3bd064578475	hourly_critical_alerts	1
zulu-blossom-october-cat	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 14:00:11.396639+02	2025-09-01 14:00:12.037557+02	t	a1913af5ca7149e5b3d0d715399f991c	hourly_critical_alerts	1
april-indigo-diet-single	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 15:00:03.36792+02	2025-09-01 15:00:03.909298+02	t	792d2370701743409c6319d510cd819a	hourly_critical_alerts	1
twenty-quebec-sweet-echo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 18:11:58.127688+02	2025-09-03 18:11:59.478757+02	t	3093470729d84c0898565049c2b91a58	hourly_critical_alerts	1
wolfram-wisconsin-paris-leopard	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 19:00:18.887199+02	2025-09-03 19:00:19.509864+02	t	475cfa18060946b1a8087f738a0ff20f	hourly_critical_alerts	1
quebec-summer-kilo-indigo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 20:33:09.942967+02	2025-09-03 20:33:10.883206+02	t	df61919a507549ba8af2c2cb62d0d503	hourly_critical_alerts	1
chicken-winter-harry-ink	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 22:33:14.423925+02	2025-09-03 22:33:15.826019+02	t	a1d10c5a1aa54901b8b88fd59df37e75	hourly_critical_alerts	1
failed-lithium-magazine-neptune	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 13:14:46.635504+02	2025-08-31 13:14:48.410107+02	t	72fde52b74c64f868a7333b52d56f81b	hourly_critical_alerts	1
sink-network-quebec-mango	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 14:00:17.873304+02	2025-08-31 14:00:18.228507+02	t	02f1093d4fb24125915397e0c93793ef	hourly_critical_alerts	1
river-mango-enemy-hamper	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 15:00:01.403033+02	2025-08-31 15:00:01.632323+02	t	2ed2d491a27b4b108d2a158da280f48e	hourly_critical_alerts	1
lemon-double-low-echo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 16:00:17.610561+02	2025-08-31 16:00:17.97217+02	t	9ff5acb1e73d4aa5bc41c84badc51948	hourly_critical_alerts	1
stairway-mountain-alpha-sink	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 19:21:26.361589+02	2025-08-31 19:21:27.63806+02	t	6457df3f71c2426589e1cfa3a871f7e9	hourly_critical_alerts	1
orange-beer-zebra-kitten	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 20:15:39.462701+02	2025-08-31 20:15:39.763005+02	t	bdbbe84b8cfb47239af22dbbc93f189d	hourly_critical_alerts	1
fruit-bravo-fish-lithium	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 21:19:03.316414+02	2025-08-31 21:19:04.055023+02	t	df8ae5e1850448d380c5a8ab018ff005	hourly_critical_alerts	1
orange-lamp-enemy-don	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA4MzFfMjE0OTI2LnNxbCAoMjA1OTc3IGJ5dGVzKZQu	2025-08-31 21:49:25.904541+02	2025-08-31 21:49:27.970723+02	t	20ab83ad46ad41dca51f21a44829c491	\N	1
low-winter-alaska-triple	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA4MzFfMjE1OTEyLnNxbCAoMjA2MDg2IGJ5dGVzKZQu	2025-08-31 21:59:12.360508+02	2025-08-31 21:59:13.134162+02	t	2e744b6f757b44bd82ebd1bb27267e9e	\N	1
cardinal-yankee-golf-yellow	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 22:00:24.741152+02	2025-08-31 22:00:25.628617+02	t	3312dadbb175437baf017c8764479749	hourly_critical_alerts	1
apart-batman-helium-ohio	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVFQAAAAAAAAB9lIwMZGF5c190b19rZWVwlEtacy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgKUhZRSlHUu	2025-08-31 22:41:06.266696+02	2025-08-31 22:41:06.620569+02	t	f4544bed11254d6bb049298c960ee2d8	weekly_cleanup	1
low-india-princess-eighteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 22:41:06.273993+02	2025-08-31 22:41:06.62778+02	t	1e4dbe93d15f4ca1bf7efc8eb58a0506	hourly_critical_alerts	1
nitrogen-ohio-vermont-fanta	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVGAAAAAAAAAB9lIwFZGVwb3SUjAlQcmluY2lwYWyUcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP8ifAgAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-08-31 22:41:06.245877+02	2025-08-31 22:41:06.687065+02	t	c6df9410511040a3a816e9bb9792783f	daily_reorder_calculation	1
may-muppet-happy-twenty	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgKUhZRSlHUu	2025-08-31 22:49:23.577072+02	2025-08-31 22:49:23.95433+02	t	a6a746c04cf6456ab0db7143030ed43a	weekly_cleanup	1
river-uncle-texas-high	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 22:49:23.580634+02	2025-08-31 22:49:23.962385+02	t	afb5f350c3704e18828202dfb68f7410	hourly_critical_alerts	1
whiskey-yankee-south-washington	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP8jxcAAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-08-31 22:49:23.563088+02	2025-08-31 22:49:24.014346+02	t	4c11e648442d4cd98296ed3688659884	daily_reorder_calculation	1
hydrogen-one-uncle-stream	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgKUhZRSlHUu	2025-08-31 22:52:54.646349+02	2025-08-31 22:52:54.921979+02	t	eb863a370f0441eebb19aaed0bfe2404	weekly_cleanup	1
alaska-emma-lake-tango	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP8HgmgAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-08-31 22:52:54.638446+02	2025-08-31 22:52:54.93116+02	t	79953ad53d604221ae0794486c8ab08f	daily_reorder_calculation	1
potato-island-violet-dakota	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 22:52:54.654012+02	2025-08-31 22:52:54.933108+02	t	8411d0f770f345a1a0b0827d6cc68f0a	hourly_critical_alerts	1
eight-may-kentucky-mockingbird	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-08-31 23:00:11.438436+02	2025-08-31 23:00:11.781137+02	t	89cad1a93df34a039e723ca02f1dc260	hourly_critical_alerts	1
wisconsin-winter-kansas-blossom	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP938yAAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-01 09:08:31.199376+02	2025-09-01 09:08:31.935127+02	t	123219c14a3646cda0d9e1f7bc6ffc38	daily_reorder_calculation	1
diet-echo-robin-spaghetti	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 09:08:31.060422+02	2025-09-01 09:08:31.957562+02	t	b03605b0e02f47b1ac1bf0fcf0a53fba	hourly_critical_alerts	1
pip-india-don-rugby	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 11:34:35.200756+02	2025-09-01 11:34:35.754777+02	t	8f42dab8653a427eb008179be0fc8524	hourly_critical_alerts	1
double-hawaii-november-violet	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 12:54:21.171745+02	2025-09-01 12:54:21.37874+02	t	bce2610ac72043ff8c443f68e08370fc	hourly_critical_alerts	1
lithium-mars-five-river	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 13:00:22.676329+02	2025-09-01 13:00:23.245539+02	t	15c43b9118b748639e5ff97f6020837a	hourly_critical_alerts	1
mountain-twenty-double-jig	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgOUhZRSlHUu	2025-09-01 15:02:32.171724+02	2025-09-01 15:02:34.230865+02	t	ef415f6534294eb0be8b6d6dabd95c44	weekly_cleanup	1
sink-lima-oranges-low	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 15:02:32.175248+02	2025-09-01 15:02:34.238132+02	t	62eae8a7a6a14638a61754438cb17231	hourly_critical_alerts	1
michigan-south-eighteen-alaska	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP/FHxkAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-01 15:02:32.088304+02	2025-09-01 15:02:34.246209+02	t	d03078114daf4b66acc0e7b706621f78	daily_reorder_calculation	1
fillet-sodium-delta-uniform	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA5MDFfMTU1ODM1LnNxbCAoMTg5MTU0IGJ5dGVzKZQu	2025-09-01 15:58:34.741709+02	2025-09-01 15:58:36.694315+02	t	92ae08702a874d2d9c64d2187b21f449	\N	1
equal-berlin-texas-music	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 16:00:09.784783+02	2025-09-01 16:00:10.422886+02	t	bb9f6d0987ae487598d92cb0ed7b1b1b	hourly_critical_alerts	1
triple-seven-magazine-mango	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 19:53:13.042735+02	2025-09-01 19:53:13.751092+02	t	d1c9d8213b214b93be83e9ab619795e1	hourly_critical_alerts	1
kilo-nevada-august-saturn	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 20:00:17.713617+02	2025-09-01 20:00:18.115574+02	t	ca678a561e8d4c458cbf94aaac7d3d2c	hourly_critical_alerts	1
london-july-green-eight	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 21:00:21.385336+02	2025-09-01 21:00:21.939889+02	t	e7a482bdbe7f4ae6b2c9e3cea5da2165	hourly_critical_alerts	1
edward-solar-mars-batman	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 22:00:07.737748+02	2025-09-01 22:00:08.376364+02	t	e021ef1423e1414d90719cf95d13da86	hourly_critical_alerts	1
echo-football-nine-fourteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-01 23:00:26.516975+02	2025-09-01 23:00:27.061842+02	t	33ee739711ae46b292e9bc5c4140baf6	hourly_critical_alerts	1
twelve-saturn-zulu-louisiana	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 08:49:12.891471+02	2025-09-02 08:49:14.804746+02	t	86ebc04ff78041f69d2e2c601d33194a	hourly_critical_alerts	1
quiet-five-jersey-july	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHQAbZ28AAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-02 08:49:13.02065+02	2025-09-02 08:49:16.70892+02	t	351f009d96524dce85c9735602b524fe	daily_reorder_calculation	1
zebra-pip-nitrogen-snake	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 09:00:16.949248+02	2025-09-02 09:00:17.31388+02	t	205dec6fa9504016b6b4da45f944e690	hourly_critical_alerts	1
happy-spring-lactose-zebra	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 10:00:19.783422+02	2025-09-02 10:00:20.427537+02	t	1b8425e39cd847d18b5462c946021aa0	hourly_critical_alerts	1
echo-golf-mexico-east	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 11:00:00.292471+02	2025-09-02 11:00:00.672987+02	t	e3488311f6f24514a20e1b3fa7b2d4f9	hourly_critical_alerts	1
stairway-five-uniform-beryllium	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 17:38:37.008171+02	2025-09-02 17:38:37.725887+02	t	43a2330103654a6bbb9533fa025ed79e	hourly_critical_alerts	1
hawaii-kansas-nuts-red	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 18:00:14.176045+02	2025-09-02 18:00:14.644802+02	t	4541085702bb4395a43dccf5bf3d5963	hourly_critical_alerts	1
oklahoma-november-carolina-foxtrot	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 19:00:26.900382+02	2025-09-02 19:00:27.51674+02	t	9c2f8b9bd9314037ac85060e9b4d77ef	hourly_critical_alerts	1
jupiter-gee-autumn-batman	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 20:00:21.787618+02	2025-09-02 20:00:22.564462+02	t	cfc24f2ce79c456cb6280696f4c83a14	hourly_critical_alerts	1
winter-texas-quiet-kansas	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-02 21:00:19.130989+02	2025-09-02 21:00:19.921561+02	t	794f894878f8431e8e6a683b398c22f8	hourly_critical_alerts	1
sierra-kitten-fillet-hotel	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 07:13:41.147239+02	2025-09-03 07:13:42.346612+02	t	f02724360d874bb2aea7dc911b4e515b	hourly_critical_alerts	1
nine-nebraska-one-fruit	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP+SfooAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-03 07:13:41.325322+02	2025-09-03 07:13:42.611142+02	t	c112246cee77434d92913097bb3c78ae	daily_reorder_calculation	1
bluebird-london-alabama-colorado	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 08:00:22.510059+02	2025-09-03 08:00:22.976502+02	t	7bb9459e58d94ab7b16a1bc17e603c08	hourly_critical_alerts	1
black-pasta-uniform-idaho	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 09:00:03.856604+02	2025-09-03 09:00:04.303433+02	t	e49feb860ab84d529e15e98572cea67b	hourly_critical_alerts	1
seventeen-sierra-asparagus-william	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 10:00:14.209791+02	2025-09-03 10:00:14.699026+02	t	542b5de19b244b31b3d29bf1a0604075	hourly_critical_alerts	1
cold-golf-monkey-queen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 11:00:00.385889+02	2025-09-03 11:00:00.731525+02	t	fa785bf06be54d96b0e19d5df769664e	hourly_critical_alerts	1
violet-pluto-kilo-enemy	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 12:00:16.174855+02	2025-09-03 12:00:16.704876+02	t	0ce1b2b0b8c4418c84c27245ad0569fe	hourly_critical_alerts	1
network-don-whiskey-eighteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-03 23:00:23.236111+02	2025-09-03 23:00:23.755064+02	t	40c77866ffd84754a70b1946736dc6e4	hourly_critical_alerts	1
freddie-sierra-ack-social	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 00:00:06.065794+02	2025-09-04 00:00:06.503008+02	t	cd98c5dfda4b44109cff3d5e14086aba	hourly_critical_alerts	1
saturn-video-coffee-iowa	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 08:12:20.707817+02	2025-09-04 08:12:22.200804+02	t	c49139ac99ba4984802b068a4fdbcb39	hourly_critical_alerts	1
victor-mike-hotel-neptune	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP+9B9gAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-04 08:12:20.834793+02	2025-09-04 08:12:22.632266+02	t	6855db0b9ba94ff7a72131e8aa045761	daily_reorder_calculation	1
sweet-rugby-eleven-venus	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-26 14:38:39.011736+02	2025-09-26 14:38:40.028666+02	t	7a3fc557e5044f13b532c67cc78f05a6	hourly_critical_alerts	1
twenty-eleven-freddie-dakota	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 08:15:53.719203+02	2025-09-04 08:15:54.032079+02	t	1abee1a6148c47e2bff54b4e151b0c2d	weekly_cleanup	1
uranus-mango-neptune-alpha	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 08:15:53.727299+02	2025-09-04 08:15:54.057259+02	t	26a2224e3a0c41f5be31fceb281a281e	hourly_critical_alerts	1
minnesota-muppet-michigan-sixteen	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP9zObgAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-04 08:15:53.66369+02	2025-09-04 08:15:54.402909+02	t	711dd63154d34052b652442994338ae4	daily_reorder_calculation	1
fillet-three-october-nuts	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP8cV5AAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-04 08:31:04.651251+02	2025-09-04 08:31:05.05378+02	t	2e6f666394264825a157e5b29f64306b	daily_reorder_calculation	1
venus-rugby-johnny-east	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 08:31:04.670412+02	2025-09-04 08:31:05.07171+02	t	0c223aff187a419eb717864d969e4272	hourly_critical_alerts	1
uncle-berlin-crazy-thirteen	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 08:31:04.666531+02	2025-09-04 08:31:05.079979+02	t	5386be8e3f74411e83bea8b86f568a6d	weekly_cleanup	1
shade-alabama-east-table	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 09:00:24.581007+02	2025-09-04 09:00:26.167109+02	t	e4233c3f9e474c948c5d0de4c335d3fd	hourly_critical_alerts	1
sink-vermont-river-rugby	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 09:37:30.774792+02	2025-09-04 09:37:31.188867+02	t	1d82e6be83ee49c8a2cd7badcd8d679a	weekly_cleanup	1
washington-oven-nitrogen-louisiana	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 09:37:30.778608+02	2025-09-04 09:37:31.218533+02	t	1944d37fc8a14383b14cc7a76d445d09	hourly_critical_alerts	1
robert-bravo-finch-black	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwGMC2Vycm9yX2NvdW50lEsDjA5leGVjdXRpb25fdGltZZRHP9BpXwAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsBdXUu	2025-09-04 09:37:30.760749+02	2025-09-04 09:37:31.271477+02	t	a2eba053dcca4c40a79b3148661a254f	daily_reorder_calculation	1
october-four-monkey-table	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 10:00:09.441193+02	2025-09-04 10:00:10.086173+02	t	15823204c0c74c07a435e5e5055cb839	hourly_critical_alerts	1
lactose-oscar-north-finch	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 11:00:00.472016+02	2025-09-04 11:00:01.198791+02	t	343f9fe0deeb4cd196f339c27fcdfa0d	hourly_critical_alerts	1
eleven-comet-florida-lion	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 11:36:40.998516+02	2025-09-04 11:36:41.695793+02	t	596a727c2a4f4907b561e37d14be70a0	weekly_cleanup	1
nevada-hotel-two-william	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 11:36:41.008409+02	2025-09-04 11:36:41.73938+02	t	694d02bcb9b24410b81f307307b53c7b	hourly_critical_alerts	1
mexico-tennis-nevada-pluto	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwCMC2Vycm9yX2NvdW50lEsEjA5leGVjdXRpb25fdGltZZRHP+Ptt4AAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsAdXUu	2025-09-04 11:36:40.937356+02	2025-09-04 11:36:41.949334+02	t	be18ae80ae564662823eaf894c028e71	daily_reorder_calculation	1
steak-rugby-texas-bakerloo	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 11:58:20.223436+02	2025-09-04 11:58:20.81093+02	t	a4b64c8a6ede414cbe27c78399ff0a7d	weekly_cleanup	1
oklahoma-alaska-west-tennis	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 11:58:20.229556+02	2025-09-04 11:58:20.834062+02	t	08ae11146969434090d8d2688bc655c4	hourly_critical_alerts	1
spaghetti-orange-mountain-idaho	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwCMC2Vycm9yX2NvdW50lEsEjA5leGVjdXRpb25fdGltZZRHP9lsbwAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsAdXUu	2025-09-04 11:58:20.167931+02	2025-09-04 11:58:20.871206+02	t	ce7af195b99944c1919304925311a182	daily_reorder_calculation	1
cold-yankee-island-triple	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 12:00:20.731539+02	2025-09-04 12:00:20.992873+02	t	5d8549b8277143e9a395f5a4705a27ec	hourly_critical_alerts	1
october-monkey-thirteen-north	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgaUhZRSlHUu	2025-09-04 12:29:04.158636+02	2025-09-04 12:29:04.698002+02	t	c6014d2b780a44a7b5b0db0002f9593c	weekly_cleanup	1
arkansas-foxtrot-hamper-kilo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-04 12:29:04.172861+02	2025-09-04 12:29:04.717822+02	t	2fd9ca3519ed43f996102cf2ad2eac5e	hourly_critical_alerts	1
chicken-hydrogen-stream-virginia	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVkQAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOdG90YWxfcHJvZHVjdHOUSwSMDXN1Y2Nlc3NfY291bnSUSwCMC2Vycm9yX2NvdW50lEsEjA5leGVjdXRpb25fdGltZZRHP/kvRQAAAACMDXN0YXR1c19jb3VudHOUfZQojAZ1cmdlbnSUSwCMB21vbml0b3KUSwCMAm9rlEsAdXUu	2025-09-04 12:29:04.04985+02	2025-09-04 12:29:06.042953+02	t	e38ddd958be3424ab8b33be5c6163a1a	daily_reorder_calculation	1
happy-pasta-cardinal-sweet	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBhyUhZRSlHUu	2025-09-26 14:38:39.059872+02	2025-09-26 14:38:40.039323+02	t	f541f81579d54647980878c8c738b49c	weekly_cleanup	1
pluto-pennsylvania-vermont-massachusetts	backup.tasks.restore_database	\N	gAWVaAAAAAAAAACMYkM6XFVzZXJzXHZpb3RlY2hcT25lRHJpdmVcQnVyZWF1XHBsYXRlZm9ybWVfYXZhbmNlXGJhY2tfZW5kXHNhdXZlZ2FyZGVzXGJhY2t1cF8yMDI1MDkwOF8xMjE4MDguc3FslIWULg==	gAV9lC4=	gAWVgwAAAAAAAACMf1Jlc3RhdXJhdGlvbiByw6l1c3NpZSBkZXB1aXMgQzpcVXNlcnNcdmlvdGVjaFxPbmVEcml2ZVxCdXJlYXVccGxhdGVmb3JtZV9hdmFuY2VcYmFja19lbmRcc2F1dmVnYXJkZXNcYmFja3VwXzIwMjUwOTA4XzEyMTgwOC5zcWyULg==	2025-09-08 13:07:13.67351+02	2025-09-08 13:07:18.734205+02	t	0398c4ee9a294a57a965ab8bc4189ec4	\N	1
william-table-hot-thirteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 13:07:22.970343+02	2025-09-08 13:07:31.712264+02	t	26088e557396437ea1ec36257d52da2b	hourly_critical_alerts	1
cold-speaker-neptune-mirror	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA5MDhfMTMxODA4LnNxbCAoMjAxOTAwIGJ5dGVzKZQu	2025-09-08 12:18:08.27789+02	2025-09-08 13:18:09.822179+02	t	5d408cb87cef4103a33ff6f2e077f1ea	\N	1
michigan-lamp-saturn-montana	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 14:00:16.687699+02	2025-09-08 14:00:17.421933+02	t	c6a214f941454c3eaade8f3be36e312e	hourly_critical_alerts	1
fish-nine-alanine-triple	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTA5MDhfMTQwODMwLnNxbCAoMjAyODU0IGJ5dGVzKZQu	2025-09-08 14:08:30.666891+02	2025-09-08 14:08:31.726496+02	t	ed29e466a2294c5cab90526b6e51954b	\N	1
low-cup-one-friend	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 15:00:05.387511+02	2025-09-08 15:00:05.969364+02	t	619bc044ac2041e3849c6cd06567bfed	hourly_critical_alerts	1
steak-undress-hotel-mars	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 18:24:09.154553+02	2025-09-08 18:24:09.831454+02	t	726936f9115149efbdd362536118d22f	hourly_critical_alerts	1
kansas-beer-monkey-one	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 19:26:01.896933+02	2025-09-08 19:26:02.309266+02	t	a4612d87eba2461cbbbbc0519f4e5421	hourly_critical_alerts	1
johnny-uniform-lemon-black	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 20:00:10.73973+02	2025-09-08 20:00:11.143137+02	t	2ff55feedbf74a818259f9554c7beacb	hourly_critical_alerts	1
batman-ohio-crazy-island	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-08 21:00:25.073378+02	2025-09-08 21:00:25.667349+02	t	c583da8e782649b5bc3117b786067097	hourly_critical_alerts	1
fifteen-cold-enemy-virginia	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-09 08:18:40.503775+02	2025-09-09 08:18:41.873301+02	t	4e8bd05628bd43ff91d4b0cadd55a4dc	hourly_critical_alerts	1
equal-california-colorado-xray	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/8jQ9gAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-09-09 08:18:40.614518+02	2025-09-09 08:18:42.412133+02	t	243fa2f962404975ab8b8a80e6146d64	daily_reorder_calculation	1
nevada-louisiana-magazine-tango	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-09 09:00:21.500902+02	2025-09-09 09:00:22.158236+02	t	b450bfc1d65146bc971619e7ba2f115d	hourly_critical_alerts	1
delta-speaker-paris-angel	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-09 10:00:03.682603+02	2025-09-09 10:00:04.117746+02	t	cf2af82feb974fe289b4c8590bd715cc	hourly_critical_alerts	1
social-bluebird-north-ack	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-09 11:00:18.329919+02	2025-09-09 11:00:18.891483+02	t	9328a4d378344b1eade9419bf63dd11a	hourly_critical_alerts	1
romeo-mars-carbon-white	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-09 12:00:04.461878+02	2025-09-09 12:00:04.983637+02	t	a278ea8c7831498485664db1131dc13b	hourly_critical_alerts	1
shade-nebraska-high-nineteen	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-10 11:35:03.959695+02	2025-09-10 11:35:04.940214+02	t	be00166c4dbe40249ed5332583b0ec43	hourly_critical_alerts	1
muppet-winner-montana-hawaii	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/4aLfgAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-09-10 11:35:03.985817+02	2025-09-10 11:35:05.033035+02	t	f4b122f253c14f2bb87c7224be3f16cc	daily_reorder_calculation	1
sink-jersey-shade-oxygen	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBgyUhZRSlHUu	2025-09-10 11:35:34.261646+02	2025-09-10 11:35:34.444074+02	t	366035a4e7d244189e51909be1b146bc	weekly_cleanup	1
purple-shade-spring-lima	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-10 11:35:34.271085+02	2025-09-10 11:35:34.452558+02	t	e6e005b7fcc541bca76a6b74adde2822	hourly_critical_alerts	1
undress-princess-three-johnny	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/uCpEAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-09-10 11:35:34.25398+02	2025-09-10 11:35:34.541524+02	t	4c5fe114361744d6aefe018eadbdc2b9	daily_reorder_calculation	1
quiet-missouri-double-one	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-10 12:00:12.175846+02	2025-09-10 12:00:12.641768+02	t	d300e783ec704250ab4e7aaa055c768b	hourly_critical_alerts	1
neptune-jersey-robin-apart	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-10 13:06:48.013936+02	2025-09-10 13:06:48.741402+02	t	b775ffa5792741769fdb14eb1b50216c	hourly_critical_alerts	1
river-india-happy-december	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-12 14:02:05.353557+02	2025-09-12 14:02:06.393311+02	t	95c73fd4826542c683ed794ebf316ed0	hourly_critical_alerts	1
nitrogen-twenty-muppet-comet	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/58krgAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-09-12 14:02:05.390439+02	2025-09-12 14:02:06.61728+02	t	c967e1d21cc94771a40e0a35824949a9	daily_reorder_calculation	1
fish-low-freddie-cup	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/0h2MAAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-09-26 14:38:39.042166+02	2025-09-26 14:38:40.08253+02	t	bb628d12ab3c43aab17df0736cf6bf0b	daily_reorder_calculation	1
bluebird-timing-yellow-crazy	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-26 15:48:12.423754+02	2025-09-26 15:48:13.233937+02	t	1a6ac6afb73e422baffbcf664dc2f250	hourly_critical_alerts	1
magnesium-connecticut-twelve-pennsylvania	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-30 18:55:08.713422+02	2025-09-30 18:55:10.079163+02	t	4f914a14f61a42828b66b0bf90a3960b	hourly_critical_alerts	1
robin-table-fifteen-nuts	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/+S9FAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-09-30 18:55:08.813093+02	2025-09-30 18:55:10.655415+02	t	70e5b19fba1e4935b7853140492d9f5b	daily_reorder_calculation	1
four-washington-edward-mockingbird	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-09-30 19:00:12.429098+02	2025-09-30 19:00:12.551839+02	t	4de3799be00e46599377c41a37ff93cb	hourly_critical_alerts	1
mountain-early-victor-island	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 14:21:08.381172+02	2025-10-02 14:21:09.034494+02	t	7758e05b34b04cfebb448597d9f13e71	hourly_critical_alerts	1
pasta-cardinal-glucose-washington	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBwSUhZRSlHUu	2025-10-02 14:21:08.425325+02	2025-10-02 14:21:09.070108+02	t	2cbb91ab16664b1bb41aac56fb10afb5	weekly_cleanup	1
mango-early-august-glucose	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/3xMuAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-10-02 14:21:08.416439+02	2025-10-02 14:21:09.260723+02	t	3965b9670e40433b805a8651d472699b	daily_reorder_calculation	1
thirteen-tango-maine-lion	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 15:00:16.160353+02	2025-10-02 15:00:16.670374+02	t	647a5292cb4b481183aa52fa10f2049c	hourly_critical_alerts	1
oxygen-saturn-steak-crazy	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 16:00:25.725693+02	2025-10-02 16:00:26.224875+02	t	dc946d8f45fc4930b1d96dd19d480df5	hourly_critical_alerts	1
vermont-uranus-earth-carolina	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 17:00:05.021661+02	2025-10-02 17:00:05.360375+02	t	bfb82ec5bd634e78a610d3529d7a19df	hourly_critical_alerts	1
berlin-vegan-lithium-freddie	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 18:00:13.72443+02	2025-10-02 18:00:14.270042+02	t	c605e037780f49d4a64cd84915d41997	hourly_critical_alerts	1
ten-five-two-utah	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 19:00:23.29675+02	2025-10-02 19:00:23.593215+02	t	28cc231d346d4a54a96b092f8fc2ee4a	hourly_critical_alerts	1
delta-speaker-floor-tennis	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 20:00:01.383671+02	2025-10-02 20:00:01.695989+02	t	cf698115047644e79d1eca007b975a6a	hourly_critical_alerts	1
emma-ceiling-lima-spaghetti	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-02 21:00:28.002133+02	2025-10-02 21:00:28.35598+02	t	c66ba1325e3f4e0bbd84d79754d65301	hourly_critical_alerts	1
carbon-two-india-salami	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-03 00:01:29.676985+02	2025-10-03 00:01:30.063251+02	t	c56cc4726ce84121b940f06a87e27ca6	hourly_critical_alerts	1
oxygen-happy-robert-iowa	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-04 12:32:10.230275+02	2025-10-04 12:32:10.508262+02	t	93aa8f1c4316474b88838031149655b1	hourly_critical_alerts	1
enemy-kilo-hot-solar	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/2onNAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-10-04 12:32:10.241035+02	2025-10-04 12:32:10.731993+02	t	09dd917a1dd04cf0a9b26623f61d4663	daily_reorder_calculation	1
alanine-bacon-wyoming-cup	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-04 13:00:14.885528+02	2025-10-04 13:00:15.538599+02	t	d98b0353f2db4d74a8b16083d5edfee8	hourly_critical_alerts	1
item-ohio-rugby-comet	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 09:40:41.461918+02	2025-10-06 09:40:42.096123+02	t	252782e8f4de4ac2874288f0c4c0103f	hourly_critical_alerts	1
ink-fillet-fish-river	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/3JSFAAAAAIwMdXJnZW50X2NvdW50lEsDjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwF1Lg==	2025-10-06 09:40:41.504056+02	2025-10-06 09:40:42.136958+02	t	b464ab1e441046568d1d63b550c3f7dd	daily_reorder_calculation	1
golf-charlie-spring-sodium	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 10:00:17.666349+02	2025-10-06 10:00:18.073729+02	t	fcf9f8a8408a4aa58287479009eb1639	hourly_critical_alerts	1
bakerloo-echo-music-bravo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 11:00:24.255432+02	2025-10-06 11:00:28.046934+02	t	3543a6c12c7a4e21abfb894f9d8f1e16	hourly_critical_alerts	1
oklahoma-saturn-florida-gee	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTEwMDZfMTE1MTU2LnNxbCAoMjA3MDIyIGJ5dGVzKZQu	2025-10-06 11:51:56.346453+02	2025-10-06 11:52:01.657268+02	t	2fedbedf9e6b4a7fa9304596c2694bb2	\N	1
twelve-october-nitrogen-paris	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 12:00:25.359526+02	2025-10-06 12:00:26.090877+02	t	72301fbf324e409d94901c85bc207040	hourly_critical_alerts	1
wyoming-comet-diet-equal	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTEwMDZfMTIwNzU0LnNxbCAoMjA3Mzk3IGJ5dGVzKZQu	2025-10-06 12:07:53.267917+02	2025-10-06 12:07:55.660499+02	t	0f3e21ea22df4294803eed6063c911fb	\N	1
september-october-wyoming-west	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 13:00:29.625717+02	2025-10-06 13:00:30.220899+02	t	50b99db5fab944a68bf355d7c597eb4b	hourly_critical_alerts	1
sixteen-stream-tennessee-echo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 14:13:16.175709+02	2025-10-06 14:13:17.101201+02	t	b7bd4e8d024347d3b3cde1447bc3a120	hourly_critical_alerts	1
nebraska-sweet-indigo-high	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 15:00:06.724119+02	2025-10-06 15:00:07.409052+02	t	d58877bd5499465cb5a4e095ef11fb58	hourly_critical_alerts	1
texas-edward-eight-ink	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 16:00:06.337837+02	2025-10-06 16:00:06.846164+02	t	c0fb4fa9839a4e6d9745d138b866e75c	hourly_critical_alerts	1
lithium-hotel-hydrogen-winter	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 17:00:08.053419+02	2025-10-06 17:00:08.609011+02	t	162b90d6e50440fe97bdf8b294589ea5	hourly_critical_alerts	1
sodium-triple-one-purple	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 18:00:06.271352+02	2025-10-06 18:00:06.653038+02	t	9f8ff825e9f242b882437e1b20128006	hourly_critical_alerts	1
earth-mountain-foxtrot-undress	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 19:00:26.134173+02	2025-10-06 19:00:27.580762+02	t	73f31ea98d294a7abd8b225a51286bf4	hourly_critical_alerts	1
sierra-fourteen-bacon-mobile	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 20:00:12.703035+02	2025-10-06 20:00:13.73864+02	t	20bfb1eba57e43d5b67d73a80b6f35de	hourly_critical_alerts	1
queen-asparagus-social-sierra	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 21:00:04.018161+02	2025-10-06 21:00:04.708922+02	t	4a9b15726a0d49259246dcc41d09a677	hourly_critical_alerts	1
music-leopard-red-skylark	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-06 22:00:26.757909+02	2025-10-06 22:00:28.368513+02	t	f4a8e228837b4aca8ca3851226402589	hourly_critical_alerts	1
cup-failed-queen-uniform	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/2HgOAAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-10-07 10:38:19.838965+02	2025-10-07 10:38:20.94137+02	t	528ef10356304265950faf8383969163	daily_reorder_calculation	1
alpha-hawaii-bravo-yellow	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-07 10:38:19.794623+02	2025-10-07 10:38:21.107689+02	t	f26c821895b248349d6433d0e58db722	hourly_critical_alerts	1
april-july-failed-uncle	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-07 11:00:22.752453+02	2025-10-07 11:00:23.347841+02	t	2ebc20b50d3e4e10a62d559f0fd4536d	hourly_critical_alerts	1
hamper-carolina-early-cold	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-07 14:31:42.483021+02	2025-10-07 14:31:43.655753+02	t	c84b30ebaa534f97bfbe4c7b0e360415	hourly_critical_alerts	1
orange-early-alaska-apart	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-08 10:50:07.455459+02	2025-10-08 10:50:07.923515+02	t	ed6ef8de6d6c4671ac8de1c31e66453b	hourly_critical_alerts	1
sink-alaska-utah-yellow	reports.tasks.cleanup_old_analyses	\N	gAUpLg==	gAWVIQAAAAAAAAB9lIwGa3dhcmdzlH2UjAxkYXlzX3RvX2tlZXCUS1pzcy4=	gAWVTwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNZGVsZXRlZF9jb3VudJRLAIwLY3V0b2ZmX2RhdGWUjAhkYXRldGltZZSMBGRhdGWUk5RDBAfpBwqUhZRSlHUu	2025-10-08 10:50:07.477629+02	2025-10-08 10:50:07.991871+02	t	e61a93a8c4d947599a8f43bf62a3714d	weekly_cleanup	1
missouri-hawaii-grey-enemy	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/4OuPAAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-10-08 10:50:07.46785+02	2025-10-08 10:50:08.111729+02	t	00d81442a10b48b997e94b62677c0a2e	daily_reorder_calculation	1
item-uniform-three-mississippi	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-08 11:00:12.897461+02	2025-10-08 11:00:13.532811+02	t	d1e9c8985c694c9ebef9970f1b55f132	hourly_critical_alerts	1
carbon-muppet-louisiana-stream	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-08 12:00:18.004832+02	2025-10-08 12:00:18.744784+02	t	887f2ac275e74f48a236eb025477aa5c	hourly_critical_alerts	1
west-quebec-march-jig	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/4IY5gAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-10-11 07:57:25.326545+02	2025-10-11 07:57:26.217423+02	t	d9ce51b4d1004e2aae6a05425cbef77f	daily_reorder_calculation	1
triple-iowa-emma-mockingbird	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-11 07:57:25.060253+02	2025-10-11 07:57:26.514981+02	t	65b7bb88c8e6460eb089d6d1aeeef222	hourly_critical_alerts	1
florida-alpha-texas-apart	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-11 08:00:27.443482+02	2025-10-11 08:00:27.801689+02	t	0e4c1d1573f04acd9165e9c0568dc419	hourly_critical_alerts	1
mango-two-sink-kitten	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 10:28:52.603032+02	2025-10-13 10:28:54.27195+02	t	e40a6905eed4459bade1e368cf8e1a28	hourly_critical_alerts	1
winner-quiet-autumn-july	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEc/yuDAAAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-10-13 10:28:52.631324+02	2025-10-13 10:28:54.475383+02	t	ec1dd0d759e34f4295c2c9906dcaf73d	daily_reorder_calculation	1
shade-hydrogen-friend-network	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 11:00:04.8867+02	2025-10-13 11:00:05.959665+02	t	331409eaea0d4bccb09c4c30c848c0d9	hourly_critical_alerts	1
fish-finch-victor-saturn	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 16:43:41.966834+02	2025-10-13 16:43:42.530894+02	t	07535b49f66a4e97b1971ad19ed6a62e	hourly_critical_alerts	1
bulldog-sad-seven-bravo	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 17:00:15.894902+02	2025-10-13 17:00:16.921121+02	t	2a84843192394055a19cd7285dbaba47	hourly_critical_alerts	1
floor-montana-helium-venus	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 18:00:29.192678+02	2025-10-13 18:00:29.88272+02	t	dd875340a1634515bad42d1fa11b5100	hourly_critical_alerts	1
mars-north-william-johnny	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 19:24:08.219633+02	2025-10-13 19:24:09.017727+02	t	f9dc3091185a4a9698bca574ce01d672	hourly_critical_alerts	1
bacon-juliet-lactose-delta	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 20:00:17.652806+02	2025-10-13 20:00:18.161946+02	t	67d451f2c3d74e36a7634efef3e00021	hourly_critical_alerts	1
seventeen-florida-delta-ohio	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 21:13:03.25604+02	2025-10-13 21:13:03.850855+02	t	28c26049cd7742b29ac23a5014fc460c	hourly_critical_alerts	1
queen-charlie-lake-maryland	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-13 22:00:18.092328+02	2025-10-13 22:00:18.709555+02	t	0e11a90064ef4be58d2039e1fc484475	hourly_critical_alerts	1
georgia-oklahoma-robin-bacon	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-14 04:16:23.602543+02	2025-10-14 04:16:25.52123+02	t	7d9457ed7d954c078642552a392fbfb9	hourly_critical_alerts	1
april-winter-tennessee-eleven	reports.tasks.daily_reorder_calculation	\N	gAUpLg==	gAWVJAAAAAAAAAB9lIwGa3dhcmdzlH2UjAVkZXBvdJSMCVByaW5jaXBhbJRzcy4=	gAWVegAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwNc3VjY2Vzc19jb3VudJRLBIwLZXJyb3JfY291bnSUSwCMDmV4ZWN1dGlvbl90aW1llEdAAMu2gAAAAIwMdXJnZW50X2NvdW50lEsEjAt3YXRjaF9jb3VudJRLAIwIb2tfY291bnSUSwB1Lg==	2025-10-14 04:16:23.619007+02	2025-10-14 04:16:26.178986+02	t	0fdb2ffcb1f14cfb83d6c04e1556cfb1	daily_reorder_calculation	1
burger-hawaii-may-may	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-14 05:00:05.801584+02	2025-10-14 05:00:06.294871+02	t	c889bae7815949ca98322b06991f9d9c	hourly_critical_alerts	1
muppet-white-queen-fanta	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-14 07:33:35.564981+02	2025-10-14 07:33:36.110385+02	t	6161c95cbbaf48a8b8b166d9b9fe3d38	hourly_critical_alerts	1
mountain-early-wyoming-maine	backup.tasks.backup_database	\N	gAUpLg==	gAV9lC4=	gAWViwAAAAAAAACMh1NhdXZlZ2FyZGUgcsOpdXNzaWUgOiBDOlxVc2Vyc1x2aW90ZWNoXE9uZURyaXZlXEJ1cmVhdVxwbGF0ZWZvcm1lX2F2YW5jZVxiYWNrX2VuZFxzYXV2ZWdhcmRlc1xiYWNrdXBfMjAyNTEwMTRfMDc1NzI2LnNxbCAoMjA4Njc3IGJ5dGVzKZQu	2025-10-14 07:57:25.471478+02	2025-10-14 07:57:29.442646+02	t	76384399459644a1bf71b5813e837448	\N	1
don-mountain-asparagus-four	reports.tasks.generate_critical_alerts	\N	gAUpLg==	gAV9lC4=	gAWVIwAAAAAAAAB9lCiMB3N1Y2Nlc3OUiIwOY3JpdGljYWxfY291bnSUSwB1Lg==	2025-10-14 08:08:21.54749+02	2025-10-14 08:08:22.215434+02	t	5acacd6949f944609fa01b2f8ace8d85	hourly_critical_alerts	1
\.


--
-- TOC entry 5093 (class 0 OID 25781)
-- Dependencies: 240
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- TOC entry 5094 (class 0 OID 25786)
-- Dependencies: 241
-- Data for Name: import_export_exporthistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_export_exporthistory (id, file_name, export_type, created_at, filters, row_count, user_id, completed_at, error_details, status) FROM stdin;
1	products_20250623_073614.xlsx	products	2025-06-23 09:36:14.551639+02	{}	0	2	\N	\N	pending
2	products_20250623_074043.xlsx	products	2025-06-23 09:40:43.850678+02	{}	0	2	\N	\N	pending
3	products_20250623_074046.xlsx	products	2025-06-23 09:40:46.516697+02	{}	0	2	\N	\N	pending
4	products_20250623_075013.xlsx	products	2025-06-23 09:50:13.979729+02	{}	2	2	\N	\N	pending
5	products_20250623_075826.xlsx	products	2025-06-23 09:58:26.004578+02	{}	2	2	\N	\N	pending
6	products_20250623_075830.xlsx	products	2025-06-23 09:58:30.187718+02	{}	2	2	\N	\N	pending
7	products_20250623_080421.xlsx	products	2025-06-23 10:04:21.601646+02	{}	2	2	\N	\N	pending
8	products_20250623_080454.xlsx	products	2025-06-23 10:04:54.530459+02	{}	2	2	\N	\N	pending
9	products_20250623_081525.xlsx	products	2025-06-23 10:15:25.549992+02	{}	2	2	\N	\N	pending
10	products_20250623_082511.xlsx	products	2025-06-23 10:25:11.394582+02	{}	2	2	\N	\N	pending
11	groups_20250623_082721.xlsx	groups	2025-06-23 10:27:21.311619+02	{}	2	2	\N	\N	pending
12	journal_20250623_084058.xlsx	journal	2025-06-23 10:40:58.580465+02	{}	0	2	\N	\N	pending
13	journal_20250623_091011.xlsx	journal	2025-06-23 11:10:11.863378+02	{}	0	2	\N	\N	pending
14	products_20250623_133401.xlsx	products	2025-06-23 15:34:01.267162+02	{}	3	2	\N	\N	pending
15	products_20250624_072204.xlsx	products	2025-06-24 09:22:04.913816+02	{}	0	2	\N	\N	pending
16	products_20250624_072204.xlsx	products	2025-06-24 09:22:04.949577+02	{}	3	2	\N	\N	pending
17	products_20250624_073419.xlsx	products	2025-06-24 09:34:19.994389+02	{}	0	2	\N	\N	pending
18	products_20250624_073420.xlsx	products	2025-06-24 09:34:20.013393+02	{}	3	2	\N	\N	pending
19	groups_20250624_075536.xlsx	groups	2025-06-24 09:55:36.374228+02	{}	0	2	\N	\N	pending
20	groups_20250624_075536.xlsx	groups	2025-06-24 09:55:36.393577+02	{}	2	2	\N	\N	pending
21	journal_20250624_081309.xlsx	journal	2025-06-24 10:13:09.365892+02	{}	0	2	\N	\N	pending
22	journal_20250624_081309.xlsx	journal	2025-06-24 10:13:09.386192+02	{}	0	2	\N	\N	pending
23	journal_20250630_193617.xlsx	journal	2025-06-30 21:36:17.638407+02	{}	0	2	\N	\N	pending
24	journal_20250630_193617.xlsx	journal	2025-06-30 21:36:17.661023+02	{}	0	2	\N	\N	pending
25	journal_20250702_095320.xlsx	journal	2025-07-02 11:53:20.847478+02	{}	0	2	\N	\N	pending
26	journal_20250702_095320.xlsx	journal	2025-07-02 11:53:20.857941+02	{}	0	2	\N	\N	pending
27	backup_20250716_091945.xlsx	backup	2025-07-16 11:19:45.935243+02	{}	12	2	\N	\N	pending
28	backup_20250716_091956.xlsx	backup	2025-07-16 11:19:56.494437+02	{}	0	2	\N	\N	pending
29	backup_20250716_091956.xlsx	backup	2025-07-16 11:19:56.5017+02	{}	0	2	\N	\N	pending
30	products_20250716_092027.xlsx	products	2025-07-16 11:20:27.548334+02	{}	0	2	\N	\N	pending
31	products_20250716_092027.xlsx	products	2025-07-16 11:20:27.564053+02	{}	3	2	\N	\N	pending
32	products_20250716_100227.xlsx	products	2025-07-16 12:02:27.363112+02	{}	0	2	\N	\N	pending
33	products_20250716_100227.xlsx	products	2025-07-16 12:02:27.371425+02	{}	3	2	\N	\N	pending
34	groups_20250716_100243.xlsx	groups	2025-07-16 12:02:43.112119+02	{}	0	2	\N	\N	pending
35	groups_20250716_100243.xlsx	groups	2025-07-16 12:02:43.117609+02	{}	3	2	\N	\N	pending
36	backup_20250729_062853.xlsx	backup	2025-07-29 08:28:53.312018+02	{}	12	2	\N	\N	pending
37	movements_20250729_062915.xlsx	movements	2025-07-29 08:29:15.750613+02	{"mouvement": "movements"}	0	2	\N	\N	pending
38	products_20250729_062922.xlsx	products	2025-07-29 08:29:22.632907+02	{}	3	2	\N	\N	pending
39	products_20250729_063911.xlsx	products	2025-07-29 08:39:11.660932+02	{}	3	2	\N	\N	pending
40	products_template_20250729_063941.xlsx	products_template	2025-07-29 08:39:41.172674+02	{}	0	2	\N	\N	pending
41	groups_20250729_081024.xlsx	groups	2025-07-29 10:10:24.55074+02	{}	3	2	\N	\N	pending
42	products_20250729_084210.xlsx	products	2025-07-29 10:42:10.938922+02	{}	3	2	\N	\N	pending
43	products_20250729_084253.xlsx	products	2025-07-29 10:42:53.081248+02	{}	3	2	\N	\N	pending
44	groups_20250729_084334.xlsx	groups	2025-07-29 10:43:34.437307+02	{}	3	2	\N	\N	pending
45	groups_20250729_085737.xlsx	groups	2025-07-29 10:57:37.961906+02	{}	3	2	\N	\N	pending
46	groups_20250729_091502.xlsx	groups	2025-07-29 11:15:02.235+02	{}	3	2	\N	\N	pending
47	products_20250729_091521.xlsx	products	2025-07-29 11:15:21.30073+02	{}	3	2	\N	\N	pending
48	journal_20250729_091553.xlsx	journal	2025-07-29 11:15:53.250449+02	{}	0	2	\N	\N	pending
49	products_20250729_092526.xlsx	products	2025-07-29 11:25:26.319267+02	{}	3	2	\N	\N	pending
50	movements_20250729_093546.xlsx	movements	2025-07-29 11:35:46.141458+02	{"mouvement": "movements"}	0	2	\N	\N	pending
51	movements_20250729_094537.xlsx	movements	2025-07-29 11:45:37.68795+02	{"mouvement": "movements"}	0	2	\N	\N	pending
52	products_20250729_095429.xlsx	products	2025-07-29 11:54:29.132793+02	{}	3	2	\N	\N	pending
53	groups_20250729_095432.xlsx	groups	2025-07-29 11:54:32.693399+02	{}	3	2	\N	\N	pending
54	movements_20250729_095435.xlsx	movements	2025-07-29 11:54:35.687548+02	{"mouvement": "movements"}	0	2	\N	\N	pending
55	products_20250729_103825.xlsx	products	2025-07-29 12:38:25.45655+02	{}	3	2	\N	\N	pending
56	groups_20250729_103830.xlsx	groups	2025-07-29 12:38:30.223478+02	{}	3	2	\N	\N	pending
57	movements_20250729_103833.xlsx	movements	2025-07-29 12:38:33.161034+02	{"mouvement": "movements"}	0	2	\N	\N	pending
58	movements_20250729_104952.xlsx	movements	2025-07-29 12:49:52.64455+02	{"date__gte": "2025-06-01", "date__lte": "2025-06-30", "mouvement": "movements"}	0	2	\N	\N	pending
59	products_20250729_105854.xlsx	products	2025-07-29 12:58:54.321686+02	{}	3	2	\N	\N	pending
60	groups_20250729_105859.xlsx	groups	2025-07-29 12:58:59.011579+02	{}	3	2	\N	\N	pending
61	movements_20250729_105906.xlsx	movements	2025-07-29 12:59:06.363319+02	{"mouvement": "movements"}	0	2	\N	\N	pending
62	products_20250729_112522.xlsx	products	2025-07-29 13:25:22.398925+02	{}	3	2	\N	\N	pending
63	groups_20250729_112527.xlsx	groups	2025-07-29 13:25:27.908585+02	{}	3	2	\N	\N	pending
64	products_20250729_114100.xlsx	products	2025-07-29 13:41:00.982665+02	{}	3	2	\N	\N	pending
65	groups_20250729_114106.xlsx	groups	2025-07-29 13:41:06.050941+02	{}	3	2	\N	\N	pending
66	movements_20250729_114113.xlsx	movements	2025-07-29 13:41:13.930693+02	{"mouvement": "movements"}	0	2	\N	\N	pending
67	movements_20250729_120217.xlsx	movements	2025-07-29 14:02:17.37614+02	{"mouvement": "movements"}	0	2	\N	\N	pending
133	export_products_20250818_113531.xlsx	products	2025-08-18 13:35:31.344167+02	{"type": ["products"]}	0	2	\N	\N	pending
134	export_products_20250818_114319.xlsx	products	2025-08-18 13:43:19.518831+02	{"type": ["products"]}	4	2	\N	\N	pending
68	movements_20250729_120243.xlsx	movements	2025-07-29 14:02:43.095088+02	{"date__gte": "2025-06-01", "date__lte": "2025-06-30", "mouvement": "movements"}	0	2	\N	\N	pending
69	movements_20250729_121420.xlsx	movements	2025-07-29 14:14:20.64361+02	{"mouvement": "movements"}	0	2	\N	\N	pending
70	movements_20250729_121427.xlsx	movements	2025-07-29 14:14:27.88905+02	{"mouvement": "movements"}	0	2	\N	\N	pending
71	movements_20250729_122755.xlsx	movements	2025-07-29 14:27:55.058226+02	{}	0	2	\N	\N	pending
72	movements_20250729_122757.xlsx	movements	2025-07-29 14:27:57.347584+02	{}	0	2	\N	\N	pending
73	movements_20250729_131305.xlsx	movements	2025-07-29 15:13:05.068289+02	{}	7	2	\N	\N	pending
74	groups_20250729_132634.xlsx	groups	2025-07-29 15:26:34.609239+02	{}	3	2	\N	\N	pending
75	groups_20250729_134005.xlsx	groups	2025-07-29 15:40:05.968261+02	{}	3	2	\N	\N	pending
76	products_20250729_134014.xlsx	products	2025-07-29 15:40:14.014123+02	{}	3	2	\N	\N	pending
77	products_20250730_061103.xlsx	products	2025-07-30 08:11:03.700528+02	{}	3	2	\N	\N	pending
78	groups_20250730_061114.xlsx	groups	2025-07-30 08:11:14.75902+02	{}	3	2	\N	\N	pending
79	movements_20250730_061118.xlsx	movements	2025-07-30 08:11:18.519945+02	{}	7	2	\N	\N	pending
80	movements_20250730_072354.xlsx	movements	2025-07-30 09:23:54.608045+02	{}	7	2	\N	\N	pending
81	products_20250730_073944.xlsx	products	2025-07-30 09:39:44.465769+02	{}	3	2	\N	\N	pending
82	movements_20250730_074206.xlsx	movements	2025-07-30 09:42:06.617479+02	{}	7	2	\N	\N	pending
83	predictions_20250730_074348.xlsx	predictions	2025-07-30 09:43:48.776695+02	{}	0	2	\N	\N	pending
84	products_20250730_074414.xlsx	products	2025-07-30 09:44:14.6684+02	{}	3	2	\N	\N	pending
85	groups_20250730_074420.xlsx	groups	2025-07-30 09:44:20.069142+02	{}	3	2	\N	\N	pending
86	movements_20250730_085420.xlsx	movements	2025-07-30 10:54:20.661994+02	{}	7	2	\N	\N	pending
87	movements_20250730_091243.xlsx	movements	2025-07-30 11:12:43.925654+02	{}	7	2	\N	\N	pending
88	predictions_20250730_093353.xlsx	predictions	2025-07-30 11:33:53.396749+02	{}	0	2	\N	\N	pending
89	export_complet_20250730_100051.xlsx	complet	2025-07-30 12:00:51.851033+02	{}	13	2	\N	\N	pending
90	export_complet_20250805_063721.xlsx	complet	2025-08-05 08:37:21.946396+02	{}	13	2	\N	\N	pending
91	products_20250805_071948.xlsx	products	2025-08-05 09:19:48.273673+02	{}	3	2	\N	\N	pending
92	groups_20250805_072022.xlsx	groups	2025-08-05 09:20:22.72128+02	{}	3	2	\N	\N	pending
93	movements_20250805_072025.xlsx	movements	2025-08-05 09:20:25.67351+02	{}	7	2	\N	\N	pending
94	export_complet_20250805_072037.xlsx	complet	2025-08-05 09:20:37.934841+02	{}	13	2	\N	\N	pending
95	products_20250805_073218.xlsx	products	2025-08-05 09:32:18.71267+02	{}	3	2	\N	\N	pending
96	groups_20250805_073238.xlsx	groups	2025-08-05 09:32:38.672607+02	{}	3	2	\N	\N	pending
97	movements_20250805_073256.xlsx	movements	2025-08-05 09:32:56.74213+02	{}	7	2	\N	\N	pending
98	export_complet_20250805_073312.xlsx	complet	2025-08-05 09:33:12.531053+02	{}	13	2	\N	\N	pending
99	products_20250805_075046.xlsx	products	2025-08-05 09:50:46.228748+02	{}	3	2	\N	\N	pending
100	groups_20250806_065737.xlsx	groups	2025-08-06 08:57:37.139888+02	{}	3	2	\N	\N	pending
101	groups_20250806_094327.xlsx	groups	2025-08-06 11:43:27.222808+02	{}	3	2	\N	\N	pending
102	export_complet_20250809_074907.xlsx	complet	2025-08-09 09:49:07.208044+02	{}	13	2	\N	\N	pending
103	products_20250809_075233.xlsx	products	2025-08-09 09:52:33.711773+02	{}	4	2	\N	\N	pending
104	products_20250818_070101.xlsx	products	2025-08-18 09:01:01.146012+02	{}	4	2	\N	\N	pending
105	movements_20250818_093418.xlsx	movements	2025-08-18 11:34:18.398826+02	{}	7	2	\N	\N	pending
106	products_20250818_094924.xlsx	products	2025-08-18 11:49:24.411014+02	{}	4	2	\N	\N	pending
107	products_20250818_100004.xlsx	products	2025-08-18 12:00:04.244038+02	{}	0	2	\N	\N	pending
108	groups_20250818_100028.xlsx	groups	2025-08-18 12:00:28.976542+02	{}	3	2	\N	\N	pending
109	movements_20250818_100032.xlsx	movements	2025-08-18 12:00:32.201998+02	{}	7	2	\N	\N	pending
110	export_complet_20250818_100039.xlsx	complet	2025-08-18 12:00:39.142737+02	{}	0	2	\N	\N	pending
111	products_20250818_100701.xlsx	products	2025-08-18 12:07:01.19083+02	{}	4	2	\N	\N	pending
112	export_complet_20250818_100746.xlsx	complet	2025-08-18 12:07:46.749248+02	{}	0	2	\N	\N	pending
113	groups_20250818_100757.xlsx	groups	2025-08-18 12:07:57.479423+02	{}	3	2	\N	\N	pending
114	products_20250818_100801.xlsx	products	2025-08-18 12:08:01.182432+02	{}	4	2	\N	\N	pending
115	movements_20250818_100803.xlsx	movements	2025-08-18 12:08:03.997381+02	{}	7	2	\N	\N	pending
116	export_complet_20250818_100809.xlsx	complet	2025-08-18 12:08:09.821852+02	{}	0	2	\N	\N	pending
117	export_products_20250818_103303.xlsx	products	2025-08-18 12:33:03.377318+02	{"type": ["products"]}	0	2	\N	\N	pending
118	export_products_20250818_104157.xlsx	products	2025-08-18 12:41:57.160231+02	{"type": ["products"]}	0	2	\N	\N	pending
119	export_products_20250818_104159.xlsx	products	2025-08-18 12:41:59.507583+02	{"type": ["products"]}	0	2	\N	\N	pending
120	export_groups_20250818_104205.xlsx	groups	2025-08-18 12:42:05.69712+02	{"type": ["groups"]}	3	2	\N	\N	pending
121	export_movements_20250818_104208.xlsx	movements	2025-08-18 12:42:08.671804+02	{"type": ["movements"]}	7	2	\N	\N	pending
122	export_products_20250818_104753.xlsx	products	2025-08-18 12:47:53.482496+02	{"type": ["products"]}	0	2	\N	\N	pending
123	export_products_20250818_105330.xlsx	products	2025-08-18 12:53:30.118286+02	{"type": ["products"]}	0	2	\N	\N	pending
124	export_products_20250818_110556.xlsx	products	2025-08-18 13:05:56.813225+02	{"type": ["products"]}	0	2	\N	\N	pending
125	export_products_20250818_110610.xlsx	products	2025-08-18 13:06:10.750929+02	{"type": ["products"]}	0	2	\N	\N	pending
126	export_groups_20250818_110613.xlsx	groups	2025-08-18 13:06:13.71011+02	{"type": ["groups"]}	3	2	\N	\N	pending
127	export_products_20250818_111000.xlsx	products	2025-08-18 13:10:00.376164+02	{"type": ["products"]}	4	2	\N	\N	pending
128	export_complet_20250818_111101.xlsx	complet	2025-08-18 13:11:01.788252+02	{}	0	2	\N	\N	pending
129	export_products_20250818_111113.xlsx	products	2025-08-18 13:11:13.046045+02	{"type": ["products"]}	4	2	\N	\N	pending
130	export_products_20250818_112031.xlsx	products	2025-08-18 13:20:31.908424+02	{"type": ["products"]}	4	2	\N	\N	pending
131	export_complet_20250818_112038.xlsx	complet	2025-08-18 13:20:38.778673+02	{}	0	2	\N	\N	pending
132	export_products_20250818_113529.xlsx	products	2025-08-18 13:35:29.492843+02	{"type": ["products"]}	0	2	\N	\N	pending
135	export_complet_20250818_114326.xlsx	complet	2025-08-18 13:43:26.182118+02	{}	11	2	\N	\N	pending
136	export_products_20250818_120125.xlsx	products	2025-08-18 14:01:25.142976+02	{"type": ["products"]}	4	2	\N	\N	pending
137	export_groups_20250818_120129.xlsx	groups	2025-08-18 14:01:29.114447+02	{"type": ["groups"]}	3	2	\N	\N	pending
138	export_movements_20250818_120132.xlsx	movements	2025-08-18 14:01:32.488404+02	{"type": ["movements"]}	7	2	\N	\N	pending
139	export_complet_20250818_120137.xlsx	complet	2025-08-18 14:01:37.487294+02	{}	14	2	\N	\N	pending
140	products_20250818_121023.xlsx	products	2025-08-18 14:10:23.898863+02	{}	4	2	\N	\N	pending
141	groups_20250818_121028.xlsx	groups	2025-08-18 14:10:28.067093+02	{}	3	2	\N	\N	pending
142	movements_20250818_121033.xlsx	movements	2025-08-18 14:10:33.620439+02	{}	7	2	\N	\N	pending
143	export_complet_20250818_121037.xlsx	complet	2025-08-18 14:10:37.767583+02	{}	14	2	\N	\N	pending
144	products_20250818_123256.xlsx	products	2025-08-18 14:32:56.161948+02	{}	4	2	\N	\N	pending
145	groups_20250818_123303.xlsx	groups	2025-08-18 14:33:03.097806+02	{}	3	2	\N	\N	pending
146	movements_20250818_123306.xlsx	movements	2025-08-18 14:33:06.143621+02	{}	7	2	\N	\N	pending
147	export_complet_20250818_123310.xlsx	complet	2025-08-18 14:33:10.337211+02	{}	14	2	\N	\N	pending
148	export_complet_20250818_123854.xlsx	complet	2025-08-18 14:38:54.648416+02	{}	14	2	\N	\N	pending
149	products_20250818_125926.xlsx	products	2025-08-18 14:59:26.714866+02	{}	0	2	\N	\N	pending
150	export_complet_20250818_125938.xlsx	complete	2025-08-18 14:59:38.920348+02	{}	0	2	\N	\N	pending
151	products_20250818_130034.xlsx	products	2025-08-18 15:00:34.372079+02	{}	4	2	\N	\N	pending
152	groups_20250818_130039.xlsx	groups	2025-08-18 15:00:39.513873+02	{}	3	2	\N	\N	pending
153	movements_20250818_130042.xlsx	movements	2025-08-18 15:00:42.901692+02	{}	7	2	\N	\N	pending
154	export_complet_20250818_130052.xlsx	complet	2025-08-18 15:00:52.679022+02	{}	14	2	\N	\N	pending
155	products_20250818_132101.xlsx	products	2025-08-18 15:21:01.261606+02	{}	4	2	\N	\N	pending
156	groups_20250818_132113.xlsx	groups	2025-08-18 15:21:13.038093+02	{}	3	2	\N	\N	pending
157	movements_20250818_132116.xlsx	movements	2025-08-18 15:21:16.416903+02	{}	7	2	\N	\N	pending
158	export_complet_20250818_132123.xlsx	complet	2025-08-18 15:21:23.949086+02	{}	14	2	\N	\N	pending
159	products_20250818_133522.xlsx	products	2025-08-18 15:35:22.951485+02	{}	4	2	\N	\N	pending
160	groups_20250818_133526.xlsx	groups	2025-08-18 15:35:26.356252+02	{}	3	2	\N	\N	pending
161	movements_20250818_133528.xlsx	movements	2025-08-18 15:35:28.645435+02	{}	7	2	\N	\N	pending
162	export_complet_20250818_133532.xlsx	complet	2025-08-18 15:35:32.0592+02	{}	14	2	\N	\N	pending
163	products_20250818_135651.xlsx	products	2025-08-18 15:56:51.328331+02	{}	0	2	\N	\N	pending
164	groups_20250818_135701.xlsx	groups	2025-08-18 15:57:01.121191+02	{}	0	2	\N	\N	pending
165	movements_20250818_135703.xlsx	movements	2025-08-18 15:57:03.787097+02	{}	0	2	\N	\N	pending
166	export_complet_20250818_135708.xlsx	complete	2025-08-18 15:57:08.373234+02	{}	0	2	\N	\N	pending
167	products_20250818_141519.xlsx	products	2025-08-18 16:15:19.189831+02	{}	4	2	\N	\N	pending
168	groups_20250818_141526.xlsx	groups	2025-08-18 16:15:26.964899+02	{}	3	2	\N	\N	pending
169	movements_20250818_141531.xlsx	movements	2025-08-18 16:15:31.590773+02	{}	7	2	\N	\N	pending
170	export_complet_20250818_141535.xlsx	complet	2025-08-18 16:15:35.922317+02	{}	14	2	\N	\N	pending
171	products_20250819_105250.xlsx	products	2025-08-19 12:52:50.961998+02	{}	4	2	\N	\N	pending
172	products_20250819_120753.xlsx	products	2025-08-19 14:07:53.296638+02	{}	4	2	\N	\N	pending
173	products_20250819_121804.xlsx	products	2025-08-19 14:18:04.644615+02	{}	4	2	\N	\N	pending
174	groups_20250819_122113.xlsx	groups	2025-08-19 14:21:13.679458+02	{}	3	2	\N	\N	pending
175	movements_20250819_122425.xlsx	movements	2025-08-19 14:24:25.980162+02	{}	8	2	\N	\N	pending
176	export_complet_20250819_123311.xlsx	complet	2025-08-19 14:33:11.945065+02	{}	15	2	\N	\N	pending
177	movements_20250819_125325.xlsx	movements	2025-08-19 14:53:25.879892+02	{}	8	2	\N	\N	pending
178	movements_20250819_125327.xlsx	movements	2025-08-19 14:53:27.963754+02	{}	8	2	\N	\N	pending
179	products_20250821_075824.xlsx	products	2025-08-21 09:58:24.998842+02	{}	4	2	\N	\N	pending
180	groups_20250821_084922.xlsx	groups	2025-08-21 10:49:22.97339+02	{}	3	2	\N	\N	pending
181	products_20250821_091654.xlsx	products	2025-08-21 11:16:54.086518+02	{}	4	2	\N	\N	pending
182	groups_20250821_091706.xlsx	groups	2025-08-21 11:17:06.423029+02	{}	3	2	\N	\N	pending
183	movements_20250821_091711.xlsx	movements	2025-08-21 11:17:11.633206+02	{}	8	2	\N	\N	pending
184	products_20250821_093608.xlsx	products	2025-08-21 11:36:08.401965+02	{}	4	2	\N	\N	pending
185	groups_20250821_093614.xlsx	groups	2025-08-21 11:36:14.61846+02	{}	3	2	\N	\N	pending
186	movements_20250821_093618.xlsx	movements	2025-08-21 11:36:18.51352+02	{}	8	2	\N	\N	pending
187	products_20250828_191320.xlsx	products	2025-08-28 21:13:20.675596+02	{}	4	2	\N	\N	pending
188	groups_20250828_191330.xlsx	groups	2025-08-28 21:13:30.53819+02	{}	3	2	\N	\N	pending
189	movements_20250828_191333.xlsx	movements	2025-08-28 21:13:33.618969+02	{}	8	2	\N	\N	pending
190	export_complet_20250828_192732.xlsx	complet	2025-08-28 21:27:32.074301+02	{}	15	2	\N	\N	pending
191	products_20250904_063227.xlsx	products	2025-09-04 08:32:27.636307+02	{}	0	2	\N	\N	pending
192	groups_20250904_063236.xlsx	groups	2025-09-04 08:32:36.760535+02	{}	0	2	\N	\N	pending
193	movements_20250904_063240.xlsx	movements	2025-09-04 08:32:40.224249+02	{}	0	2	\N	\N	pending
194	export_complet_20250904_063309.xlsx	complet	2025-09-04 08:33:09.043269+02	{}	0	2	\N	\N	pending
195	products_20250904_070434.xlsx	products	2025-09-04 09:04:34.516425+02	{}	0	2	\N	\N	pending
196	groups_20250904_070439.xlsx	groups	2025-09-04 09:04:39.40085+02	{}	0	2	\N	\N	pending
197	movements_20250904_070443.xlsx	movements	2025-09-04 09:04:43.653534+02	{}	0	2	\N	\N	pending
198	export_complet_20250904_070536.xlsx	complet	2025-09-04 09:05:36.844607+02	{}	0	2	\N	\N	pending
199		products	2025-09-04 09:38:44.453268+02	{}	4	2	\N	\N	pending
200		groups	2025-09-04 09:38:51.370042+02	{}	3	2	\N	\N	pending
201		movements	2025-09-04 09:38:56.126985+02	{}	8	2	\N	\N	pending
202		movements	2025-09-04 09:39:01.4522+02	{}	8	2	\N	\N	pending
203	export_complet_20250904_073910.xlsx	complet	2025-09-04 09:39:10.411519+02	{}	0	2	\N	\N	pending
204		products	2025-09-04 10:00:53.98524+02	{}	4	2	\N	\N	pending
205		groups	2025-09-04 10:00:58.734995+02	{}	3	2	\N	\N	pending
206		movements	2025-09-04 10:01:03.169093+02	{}	8	2	\N	\N	pending
207	export_complet_20250904_080124.xlsx	complet	2025-09-04 10:01:24.06704+02	{}	0	2	\N	\N	pending
208		products	2025-09-04 10:17:18.825803+02	{}	4	2	\N	\N	pending
209		groups	2025-09-04 10:17:26.436202+02	{}	3	2	\N	\N	pending
210		movements	2025-09-04 10:17:30.63152+02	{}	8	2	\N	\N	pending
211		products	2025-09-04 10:28:09.459422+02	{}	4	2	\N	\N	pending
212		groups	2025-09-04 10:28:13.736164+02	{}	3	2	\N	\N	pending
213		movements	2025-09-04 10:28:17.653577+02	{}	8	2	\N	\N	pending
214	export_complet_20250904_082823.xlsx	complet	2025-09-04 10:28:23.848619+02	{}	0	2	\N	\N	pending
215		products	2025-09-04 11:02:04.132511+02	{}	4	2	\N	\N	pending
216		groups	2025-09-04 11:02:08.568345+02	{}	3	2	\N	\N	pending
217		movements	2025-09-04 11:02:13.082065+02	{}	8	2	\N	\N	pending
218		products	2025-09-04 11:26:36.538806+02	{}	4	2	\N	\N	pending
219		groups	2025-09-04 11:26:41.508229+02	{}	3	2	\N	\N	pending
220		movements	2025-09-04 11:26:44.788539+02	{}	8	2	\N	\N	pending
221	export_complet_20250908_101759.xlsx	complet	2025-09-08 12:17:59.995389+02	{}	0	2	\N	\N	pending
222	export_complet_20250908_110823.xlsx	complet	2025-09-08 13:08:23.025877+02	{}	0	2	\N	\N	pending
223		complet	2025-09-08 13:25:24.483401+02	{}	0	2	\N	\N	en_cours
224		complet	2025-09-08 13:37:31.713581+02	{}	0	2	\N	\N	en_cours
225		products	2025-09-08 13:37:40.188115+02	{}	4	2	\N	\N	pending
226		groups	2025-09-08 13:37:49.142773+02	{}	3	2	\N	\N	pending
227		movements	2025-09-08 13:37:58.979791+02	{}	13	2	\N	\N	pending
228		complet	2025-09-08 14:08:05.575078+02	{}	0	2	\N	\N	en_cours
229		complet	2025-09-08 14:08:13.839293+02	{}	0	2	\N	\N	en_cours
230		products	2025-09-08 14:23:29.670906+02	{}	4	2	\N	\N	pending
231		complet	2025-09-08 14:23:31.926528+02	{}	0	2	\N	\N	erreur
232		complet	2025-09-08 14:27:58.356452+02	{}	20	2	\N	\N	terminé
233		complet	2025-09-08 14:36:53.437999+02	{}	0	2	\N	\N	erreur
234		complet	2025-09-08 14:38:52.89451+02	{}	20	2	\N	\N	terminé
235		complet	2025-09-10 12:01:34.630719+02	{}	21	2	\N	\N	terminé
236		movements	2025-10-06 11:33:18.49868+02	{}	0	2	\N	\N	pending
237		products	2025-10-06 11:43:55.566896+02	{}	4	2	\N	\N	pending
238		groups	2025-10-06 11:43:59.791504+02	{}	3	2	\N	\N	terminé
239		movements	2025-10-06 11:44:05.133908+02	{}	17	2	\N	\N	pending
240		complet	2025-10-06 11:50:14.346499+02	{}	0	2	\N	\N	erreur
241		complet	2025-10-06 11:51:50.664708+02	{}	0	2	\N	\N	erreur
242		complet	2025-10-06 12:07:28.063103+02	{}	24	2	\N	\N	completed
243		products	2025-10-06 12:07:39.290288+02	{}	4	2	\N	\N	pending
244		groups	2025-10-06 12:07:44.759207+02	{}	3	2	\N	\N	terminé
245		movements	2025-10-06 12:07:49.913028+02	{}	17	2	\N	\N	pending
246		complet	2025-10-06 13:33:01.838168+02	{}	0	2	\N	\N	failed
247		complet	2025-10-06 13:44:03.13763+02	{}	24	2	\N	\N	completed
248		complet	2025-10-06 20:37:47.036356+02	{}	24	2	\N	\N	completed
249		products	2025-10-11 08:50:28.790345+02	{}	4	2	\N	\N	pending
250		complet	2025-10-14 08:35:53.526175+02	{}	27	2	\N	\N	completed
\.


--
-- TOC entry 5096 (class 0 OID 25792)
-- Dependencies: 243
-- Data for Name: import_export_importhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_export_importhistory (id, file_name, import_type, status, created_at, completed_at, total_rows, processed_rows, success_rows, error_rows, error_details, user_id, file_size) FROM stdin;
1	backup_2025-07-16_11-19.xlsx	products	failed	2025-07-16 11:20:20.621036+02	2025-07-16 11:20:22.781473+02	0	0	0	0	Colonnes manquantes: code, nom, stock_initial, seuil, unite, zone	2	\N
2	produits_2025-06-23.xlsx	products	failed	2025-07-16 12:02:20.659078+02	2025-07-16 12:02:22.521229+02	2	0	0	0	Colonnes manquantes: code, nom, stock_initial, seuil, unite, zone	2	\N
3	mnp_export_2025-07-29_08-29.xlsx	products	failed	2025-07-29 08:30:15.513856+02	2025-07-29 08:30:17.174023+02	3	0	0	0	Colonnes manquantes: code, nom, stock_initial, seuil, unite, zone	2	\N
4	produits_2025-07-29.xlsx	products	failed	2025-07-29 08:39:26.15519+02	2025-07-29 08:39:27.143671+02	3	0	0	0	Colonnes manquantes: code, nom, stock_initial, seuil, unite, zone	2	\N
5	groupes_mnp_2025-07-29.xlsx	products	failed	2025-07-29 10:12:34.607479+02	2025-07-29 10:12:36.066983+02	3	0	0	0	Colonnes manquantes: code, nom, stock_initial, seuil, unite, zone	2	\N
6	groupes_mnp_2025-07-29.xlsx	groups	failed	2025-07-29 10:17:49.898781+02	2025-07-29 10:17:50.730455+02	3	0	0	0	Colonnes manquantes: nom	2	\N
7	groupes_mnp_2025-07-29.xlsx	groups	completed	2025-07-29 10:38:48.382105+02	2025-07-29 10:38:49.86821+02	3	3	3	0	\N	2	\N
8	produits_2025-07-29 (1).xlsx	products	completed	2025-07-29 11:15:42.365718+02	\N	0	0	0	0	\N	2	\N
9	groupes_mnp_2025-07-29 (2).xlsx	groups	completed	2025-07-29 15:28:29.858149+02	\N	0	0	0	0	\N	2	\N
10	produits_2025-08-05.xlsx	products	completed	2025-08-05 09:32:29.605282+02	\N	0	0	0	0	\N	2	\N
11	groupes_mnp_2025-08-05.xlsx	groups	completed	2025-08-05 09:32:49.414594+02	\N	0	0	0	0	\N	2	\N
12	export_complet_2025-08-05_09-20.xlsx	groups	completed	2025-08-05 09:33:32.062869+02	\N	0	0	0	0	\N	2	\N
13	groupes_mnp_2025-08-06.xlsx	groups	completed	2025-08-06 08:58:20.303194+02	\N	0	0	0	0	\N	2	\N
14	groupes_mnp_2025-08-06 (1).xlsx	groups	completed	2025-08-06 12:26:15.286603+02	\N	0	0	0	0	\N	2	\N
15	produits_2025-09-04.xlsx	products	failed	2025-09-04 10:01:50.42876+02	\N	0	0	0	0	Format de fichier non reconnu. Colonnes attendues pour produits: Code, Nom, Stock. Pour groupes: Nom, Description.	2	\N
16	produits_2025-09-04.xlsx	products	failed	2025-09-04 10:17:43.512911+02	\N	0	0	0	0	Format de fichier non reconnu. Colonnes attendues pour produits: Code, Nom, Stock. Pour groupes: Nom, Description.	2	\N
17	produits_2025-09-04.xlsx	products	completed	2025-09-04 10:28:52.568018+02	\N	0	0	0	0	\N	2	\N
18	groupes_mnp_2025-09-04.xlsx	groups	completed	2025-09-04 10:29:13.353031+02	\N	0	0	0	0	\N	2	\N
19	produits_2025-08-28.xlsx	products	completed	2025-09-10 11:58:00.136041+02	\N	0	0	0	0	\N	2	\N
\.


--
-- TOC entry 5098 (class 0 OID 25798)
-- Dependencies: 245
-- Data for Name: inventory_ajustementinventaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_ajustementinventaire (id, quantite_theorique, quantite_physique, ecart, date_ajustement, commentaire, produit_id, session_id, valide_par_id) FROM stdin;
2	150.000	149.000	-1.000	2025-08-19 14:54:32.583107+02	Calcul automatique lors de la clôture	5	3	2
4	90.000	91.000	1.000	2025-09-08 14:07:25.252871+02	Calcul automatique lors de la clôture	4	4	2
3	20.000	19.000	-1.000	2025-09-08 14:07:25.242728+02	Abîmer dans le stock et a été détruit	3	4	2
6	39.000	40.000	1.000	2025-10-14 08:33:51.726719+02	Calcul automatique lors de la clôture jkdsf:kjskf	3	8	2
\.


--
-- TOC entry 5100 (class 0 OID 25804)
-- Dependencies: 247
-- Data for Name: inventory_lignecomptage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_lignecomptage (id, quantite_physique, date_comptage, operateur_id, produit_id, session_id) FROM stdin;
2	149.000	2025-08-19 14:54:13.392198+02	2	5	3
3	91.000	2025-09-08 14:06:52.850891+02	2	4	4
4	19.000	2025-09-08 14:07:23.018465+02	2	3	4
6	40.000	2025-10-14 08:33:45.567003+02	2	3	8
\.


--
-- TOC entry 5102 (class 0 OID 25808)
-- Dependencies: 249
-- Data for Name: inventory_sessioninventaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_sessioninventaire (id, reference, date_debut, date_fin, statut, responsable_id) FROM stdin;
3	INV-20250819125341-2	2025-08-19 14:53:41.085989+02	2025-08-19 14:54:32.591848+02	TERMINEE	2
4	INV-20250908120619-2	2025-09-08 14:06:19.567209+02	2025-09-08 14:07:25.256288+02	TERMINEE	2
1	Test_Inventaire_Mois_Aout	2025-08-18 10:35:12.563511+02	2025-08-18 10:35:48.127558+02	TERMINEE	2
8	Inventaitre_Test	2025-10-14 08:33:31.606173+02	2025-10-14 08:33:51.847231+02	TERMINEE	2
\.


--
-- TOC entry 5104 (class 0 OID 25812)
-- Dependencies: 251
-- Data for Name: journal_mouvement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.journal_mouvement (id, mouvement, quantite, stock_avant, stock_apres, demandeur, date, observation, produit_id, utilisateur_id) FROM stdin;
1	Sortie	30	200	170	DG	2025-06-23 12:17:40.470352+02		1	2
3	Sortie	150	200	50	Gareine	2025-06-23 15:36:42.882594+02		3	2
4	Entrée	50	170	220	Fournisseu	2025-06-23 15:39:14.496834+02		1	2
5	Sortie	30	50	20	KRM	2025-06-23 15:53:38.820175+02		3	2
7	Sortie	100	220	120	Stock	2025-06-30 11:11:53.507467+02		1	2
9	Sortie	28	120	92	DRH	2025-07-02 11:51:04.495387+02		1	2
10	Entrée	20	20	40	Fournisseur	2025-07-29 13:26:23.599324+02		3	2
11	Sortie	50	200	150	KRM	2025-08-19 08:19:52.007431+02		5	2
12	Sortie	40	92	52	DAF	2025-09-04 11:27:27.281036+02		1	2
13	Sortie	30	149	119	Mikea	2025-09-04 11:28:10.504455+02		5	2
14	Sortie	50	119	69	Isalo	2025-09-04 11:29:01.5505+02		5	2
15	Sortie	19	39	20	KRM	2025-09-04 11:29:34.900084+02		3	2
16	Sortie	60	150	90	KRM	2025-09-08 11:21:02.863047+02		4	2
17	Entrée	29	91	120	Fournisseur	2025-09-10 11:40:59.003767+02		4	2
18	Sortie	20	92	72	Gareine	2025-10-06 10:02:33.021208+02		1	2
19	Entrée	15	72	87	Fournisseur	2025-08-08 08:18:00+02	Prix est de 15.000Ar	1	2
20	Entrée	14	87	101	Fournisseur	2025-08-08 10:31:00+02	Prix 15.000Ar/Ram	1	2
21	Sortie	16	20	4	KRM	2025-10-14 07:32:00+02	TRype BEX	6	2
\.


--
-- TOC entry 5106 (class 0 OID 25818)
-- Dependencies: 253
-- Data for Name: products_groupe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_groupe (id, nom, description, couleur, date_creation, date_modification) FROM stdin;
3	Formulaire		#3B82F6	2025-07-01 08:57:28.631603+02	2025-09-04 10:29:13.379778+02
1	Fournitures		#6EE7B7	2025-06-20 09:36:22.639717+02	2025-09-04 10:29:13.382059+02
2	Marketing		#7C3AED	2025-06-20 11:38:31.047442+02	2025-09-04 10:29:13.384128+02
4	Matériel Informatique		#F59E0B	2025-10-14 08:31:14.680829+02	2025-10-14 08:31:14.680883+02
\.


--
-- TOC entry 5108 (class 0 OID 25824)
-- Dependencies: 255
-- Data for Name: products_inventaireproduit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_inventaireproduit (id, stock_systeme, stock_physique, ecart, date_inventaire, observation, ajustement_effectue, mouvement_ajustement_id, produit_id, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5110 (class 0 OID 25830)
-- Dependencies: 257
-- Data for Name: products_produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_produit (id, code, nom, stock_initial, seuil, unite, zone, observation, date_creation, date_modification, groupe_id, lead_time) FROM stdin;
4	PRD-004	DED	150	30	Unité	Bat A		2025-07-01 08:58:53.193775+02	2025-09-10 11:58:00.376051+02	3	7
5	PRD-005	Tickets d'entrée	149	30	Carnet	Bat A		2025-08-09 09:52:05.814389+02	2025-09-10 11:58:00.381648+02	3	7
1	PRD-001	Papier A4	101	20	RAM	Bat A	Papier	2025-06-20 11:55:10.340085+02	2025-10-06 15:10:08.854443+02	1	7
6	PRD6009	HP	4	5	Pièce	Bat A		2025-10-14 08:32:12.646972+02	2025-10-14 08:33:09.565706+02	4	7
3	PRD-003	Affichage	40	30	Unité	Bat A		2025-06-23 15:33:10.210044+02	2025-10-14 08:33:51.845064+02	2	7
\.


--
-- TOC entry 5112 (class 0 OID 25836)
-- Dependencies: 259
-- Data for Name: reports_reorderanalysis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports_reorderanalysis (id, depot, avg_daily_demand, sigma_daily_demand, lead_time_days, safety_stock, reorder_point, predicted_30d, days_of_coverage, suggested_qty, status, confidence_level, confidence_reason, calculation_date, window_days_used, z_factor_used, movements_count, explanation, produit_id) FROM stdin;
2	Principal	0.520	20.153	7	87.98	91.62	15.60	75.00	64.58	URGENT	LOW	Historique insuffisant: 2 mouvements sur -37 jours	2025-10-14 04:16:26.069786+02	90	1.65	2	{"donnees": {"z_factor": 1.65, "point_commande": 91.6157193065223, "stock_securite": 87.9757193065223, "ecart_type_jour": 20.152543263816604, "lead_time_jours": 7, "demande_moyenne_jour": 0.52}, "formules": {"ecart_type": "Écart-type des demandes quotidiennes", "point_commande": "Demande moyenne × Lead time + Stock de sécurité", "stock_securite": "Z-factor (1.65) × σ × √(lead_time)", "demande_moyenne": "Moyenne des sorties quotidiennes sur 90 jours"}, "interpretation": {"niveau_service": "165.0%", "fenetre_analyse": "90 jours"}}	3
4	Principal	1.187	63.640	7	277.82	286.12	35.60	126.40	163.42	URGENT	LOW	Historique insuffisant: 2 mouvements sur -3 jours	2025-10-14 04:16:26.116846+02	90	1.65	2	{"donnees": {"z_factor": 1.65, "point_commande": 286.1247276346318, "stock_securite": 277.81806096796515, "ecart_type_jour": 63.63961030678928, "lead_time_jours": 7, "demande_moyenne_jour": 1.1866666666666668}, "formules": {"ecart_type": "Écart-type des demandes quotidiennes", "point_commande": "Demande moyenne × Lead time + Stock de sécurité", "stock_securite": "Z-factor (1.65) × σ × √(lead_time)", "demande_moyenne": "Moyenne des sorties quotidiennes sur 90 jours"}, "interpretation": {"niveau_service": "165.0%", "fenetre_analyse": "90 jours"}}	4
3	Principal	1.187	30.000	7	130.96	139.27	35.60	85.11	65.56	URGENT	LOW	Historique insuffisant: 4 mouvements sur -60 jours	2025-10-14 04:16:26.131427+02	90	1.65	4	{"donnees": {"z_factor": 1.65, "point_commande": 139.2713565643639, "stock_securite": 130.96468989769724, "ecart_type_jour": 30.0, "lead_time_jours": 7, "demande_moyenne_jour": 1.1866666666666668}, "formules": {"ecart_type": "Écart-type des demandes quotidiennes", "point_commande": "Demande moyenne × Lead time + Stock de sécurité", "stock_securite": "Z-factor (1.65) × σ × √(lead_time)", "demande_moyenne": "Moyenne des sorties quotidiennes sur 90 jours"}, "interpretation": {"niveau_service": "165.0%", "fenetre_analyse": "90 jours"}}	1
1	Principal	1.733	31.820	7	138.91	151.04	52.00	85.96	41.91	URGENT	LOW	Historique insuffisant: 3 mouvements sur -17 jours	2025-10-14 04:16:26.144301+02	90	1.65	3	{"donnees": {"z_factor": 1.65, "point_commande": 151.0423638173159, "stock_securite": 138.90903048398258, "ecart_type_jour": 31.81980515339464, "lead_time_jours": 7, "demande_moyenne_jour": 1.7333333333333334}, "formules": {"ecart_type": "Écart-type des demandes quotidiennes", "point_commande": "Demande moyenne × Lead time + Stock de sécurité", "stock_securite": "Z-factor (1.65) × σ × √(lead_time)", "demande_moyenne": "Moyenne des sorties quotidiennes sur 90 jours"}, "interpretation": {"niveau_service": "165.0%", "fenetre_analyse": "90 jours"}}	5
\.


--
-- TOC entry 5114 (class 0 OID 25842)
-- Dependencies: 261
-- Data for Name: reports_reorderconfiguration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports_reorderconfiguration (id, window_days, forecast_horizon, z_factor, default_lead_time, urgent_threshold_multiplier, monitor_threshold_multiplier, min_historical_days_for_confidence, min_movements_for_confidence, created_at, is_active) FROM stdin;
1	90	30	1.65	7	1.0	2.0	30	10	2025-08-19 10:14:16.467303+02	t
\.


--
-- TOC entry 5116 (class 0 OID 25846)
-- Dependencies: 263
-- Data for Name: reports_reordermonitoring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports_reordermonitoring (id, date, urgent_count, monitor_count, ok_count, total_suggested_units, draft_orders_created, draft_orders_approved, batch_execution_time, batch_success, batch_error_message, average_confidence, low_confidence_count, created_at) FROM stdin;
1	2025-08-19	0	0	1	0.00	0	0	0.25	t		\N	1	2025-08-19 10:45:55.03663+02
2	2025-08-31	0	0	1	0.00	0	0	0.14	t		\N	1	2025-08-31 22:41:06.684013+02
3	2025-09-01	0	0	1	0.00	0	0	1.08	t		\N	1	2025-09-01 09:08:31.929744+02
4	2025-09-02	0	0	1	0.00	0	0	2.86	t		\N	1	2025-09-02 08:49:16.676471+02
5	2025-09-03	0	0	1	0.00	0	0	0.64	t		\N	1	2025-09-03 07:13:42.602024+02
6	2025-09-04	0	0	0	0.00	0	0	0.30	f		0.00	0	2025-09-04 08:12:22.615936+02
7	2025-09-08	3	0	1	0.00	0	0	0.32	t		0.00	4	2025-09-08 10:45:07.089918+02
8	2025-09-09	3	0	1	0.00	0	0	1.14	t		0.00	4	2025-09-09 08:18:42.404509+02
9	2025-09-10	3	0	1	0.00	0	0	0.09	t		0.00	4	2025-09-10 11:35:05.027421+02
10	2025-09-12	4	0	0	0.00	0	0	0.74	t		0.00	4	2025-09-12 14:02:06.609323+02
11	2025-09-26	4	0	0	0.00	0	0	0.28	t		0.00	4	2025-09-26 14:38:40.076598+02
12	2025-09-30	3	0	1	0.00	0	0	1.57	t		0.00	4	2025-09-30 18:55:10.648252+02
13	2025-10-02	3	0	1	0.00	0	0	0.49	t		0.00	4	2025-10-02 14:21:09.254896+02
14	2025-10-04	3	0	1	0.00	0	0	0.41	t		0.00	4	2025-10-04 12:32:10.724191+02
15	2025-10-06	3	0	1	0.00	0	0	0.45	t		0.00	4	2025-10-06 09:40:42.131299+02
16	2025-10-07	4	0	0	0.00	0	0	0.38	t		0.00	4	2025-10-07 10:38:20.935499+02
17	2025-10-08	4	0	0	0.00	0	0	0.53	t		0.00	4	2025-10-08 10:50:08.107882+02
18	2025-10-11	4	0	0	0.00	0	0	0.52	t		0.00	4	2025-10-11 07:57:26.208268+02
19	2025-10-13	4	0	0	0.00	0	0	0.21	t		0.00	4	2025-10-13 10:28:54.472748+02
20	2025-10-14	4	0	0	0.00	0	0	2.10	t		0.00	4	2025-10-14 04:16:26.167267+02
\.


--
-- TOC entry 5118 (class 0 OID 25852)
-- Dependencies: 265
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user (id, password, last_login, is_superuser, username, first_name, last_name, is_staff, is_active, date_joined, email, nom, prenom, date_creation, date_modification, password_changed_at, password_expiry_days, session_timeout) FROM stdin;
1	pbkdf2_sha256$600000$ooz4M23IBVRzfF5vPTfGmF$INRTiwBbJroSYWCXO5dMcxqkwuQiPcbx54buBQ8abW0=	\N	t	blackccess			t	t	2025-06-18 15:03:54.866492+02	aromain310@gmail.com			2025-06-18 15:03:56.65239+02	2025-06-18 15:03:56.652409+02	2025-09-01 13:05:39.980826+02	90	30
2	pbkdf2_sha256$600000$W7zB2QHxvE0z9Id95FTUsm$MmhTmhh4zVp3VPZd1AWbRN96qMXFriPda/Jw5KllZrI=	\N	f	antonioromain25@gmail.com			f	t	2025-06-20 08:15:32.535695+02	antonioromain25@gmail.com	LEBIRIA	Tsilavina Mail Edson	2025-06-20 08:15:33.740397+02	2025-09-01 13:14:54.666649+02	2025-09-01 13:05:39.980826+02	90	30
\.


--
-- TOC entry 5119 (class 0 OID 25857)
-- Dependencies: 266
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 5122 (class 0 OID 25862)
-- Dependencies: 269
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 218
-- Name: ai_anomalie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_anomalie_id_seq', 1, false);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 220
-- Name: ai_prediction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_prediction_id_seq', 1, false);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 222
-- Name: ai_recommandation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_recommandation_id_seq', 1, false);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 224
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 226
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 228
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 108, true);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 230
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 232
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 27, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 234
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 59, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 236
-- Name: django_q_ormq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_q_ormq_id_seq', 458, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 238
-- Name: django_q_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_q_schedule_id_seq', 48, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 242
-- Name: import_export_exporthistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_export_exporthistory_id_seq', 250, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 244
-- Name: import_export_importhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_export_importhistory_id_seq', 19, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 246
-- Name: inventory_ajustementinventaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_ajustementinventaire_id_seq', 6, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 248
-- Name: inventory_lignecomptage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_lignecomptage_id_seq', 6, true);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 250
-- Name: inventory_sessioninventaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_sessioninventaire_id_seq', 8, true);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 252
-- Name: journal_mouvement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.journal_mouvement_id_seq', 21, true);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 254
-- Name: products_groupe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_groupe_id_seq', 4, true);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 256
-- Name: products_inventaireproduit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_inventaireproduit_id_seq', 1, false);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 258
-- Name: products_produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_produit_id_seq', 6, true);


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 260
-- Name: reports_reorderanalysis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_reorderanalysis_id_seq', 4, true);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 262
-- Name: reports_reorderconfiguration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_reorderconfiguration_id_seq', 1, true);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 264
-- Name: reports_reordermonitoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_reordermonitoring_id_seq', 20, true);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 267
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 268
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 2, true);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 270
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 4777 (class 2606 OID 25867)
-- Name: ai_anomalie ai_anomalie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_anomalie
    ADD CONSTRAINT ai_anomalie_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 25869)
-- Name: ai_prediction ai_prediction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_prediction
    ADD CONSTRAINT ai_prediction_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 25871)
-- Name: ai_recommandation ai_recommandation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_recommandation
    ADD CONSTRAINT ai_recommandation_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 25873)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4793 (class 2606 OID 25875)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4796 (class 2606 OID 25877)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 25879)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 25881)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4801 (class 2606 OID 25883)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4804 (class 2606 OID 25885)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4807 (class 2606 OID 25887)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4809 (class 2606 OID 25889)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4811 (class 2606 OID 25891)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4813 (class 2606 OID 25893)
-- Name: django_q_ormq django_q_ormq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_ormq
    ADD CONSTRAINT django_q_ormq_pkey PRIMARY KEY (id);


--
-- TOC entry 4815 (class 2606 OID 25895)
-- Name: django_q_schedule django_q_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_schedule
    ADD CONSTRAINT django_q_schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 25897)
-- Name: django_q_task django_q_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_task
    ADD CONSTRAINT django_q_task_pkey PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 25899)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 4824 (class 2606 OID 25901)
-- Name: import_export_exporthistory import_export_exporthistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_export_exporthistory
    ADD CONSTRAINT import_export_exporthistory_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 25903)
-- Name: import_export_importhistory import_export_importhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_export_importhistory
    ADD CONSTRAINT import_export_importhistory_pkey PRIMARY KEY (id);


--
-- TOC entry 4830 (class 2606 OID 25905)
-- Name: inventory_ajustementinventaire inventory_ajustementinventaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_ajustementinventaire
    ADD CONSTRAINT inventory_ajustementinventaire_pkey PRIMARY KEY (id);


--
-- TOC entry 4837 (class 2606 OID 25907)
-- Name: inventory_lignecomptage inventory_lignecomptage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_lignecomptage
    ADD CONSTRAINT inventory_lignecomptage_pkey PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 25909)
-- Name: inventory_lignecomptage inventory_lignecomptage_session_id_produit_id_3ee03fa3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_lignecomptage
    ADD CONSTRAINT inventory_lignecomptage_session_id_produit_id_3ee03fa3_uniq UNIQUE (session_id, produit_id);


--
-- TOC entry 4843 (class 2606 OID 25911)
-- Name: inventory_sessioninventaire inventory_sessioninventaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sessioninventaire
    ADD CONSTRAINT inventory_sessioninventaire_pkey PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 25913)
-- Name: inventory_sessioninventaire inventory_sessioninventaire_reference_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sessioninventaire
    ADD CONSTRAINT inventory_sessioninventaire_reference_key UNIQUE (reference);


--
-- TOC entry 4849 (class 2606 OID 25915)
-- Name: journal_mouvement journal_mouvement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.journal_mouvement
    ADD CONSTRAINT journal_mouvement_pkey PRIMARY KEY (id);


--
-- TOC entry 4853 (class 2606 OID 25917)
-- Name: products_groupe products_groupe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_groupe
    ADD CONSTRAINT products_groupe_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 25919)
-- Name: products_inventaireproduit products_inventaireproduit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_inventaireproduit
    ADD CONSTRAINT products_inventaireproduit_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 25921)
-- Name: products_produit products_produit_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_produit
    ADD CONSTRAINT products_produit_code_key UNIQUE (code);


--
-- TOC entry 4864 (class 2606 OID 25923)
-- Name: products_produit products_produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_produit
    ADD CONSTRAINT products_produit_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 25925)
-- Name: reports_reorderanalysis reports_reorderanalysis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reorderanalysis
    ADD CONSTRAINT reports_reorderanalysis_pkey PRIMARY KEY (id);


--
-- TOC entry 4869 (class 2606 OID 25927)
-- Name: reports_reorderanalysis reports_reorderanalysis_produit_id_depot_calcula_55d2656d_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reorderanalysis
    ADD CONSTRAINT reports_reorderanalysis_produit_id_depot_calcula_55d2656d_uniq UNIQUE (produit_id, depot, calculation_date);


--
-- TOC entry 4871 (class 2606 OID 25929)
-- Name: reports_reorderconfiguration reports_reorderconfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reorderconfiguration
    ADD CONSTRAINT reports_reorderconfiguration_pkey PRIMARY KEY (id);


--
-- TOC entry 4873 (class 2606 OID 25931)
-- Name: reports_reordermonitoring reports_reordermonitoring_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reordermonitoring
    ADD CONSTRAINT reports_reordermonitoring_date_key UNIQUE (date);


--
-- TOC entry 4875 (class 2606 OID 25933)
-- Name: reports_reordermonitoring reports_reordermonitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reordermonitoring
    ADD CONSTRAINT reports_reordermonitoring_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 25935)
-- Name: users_user users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_email_key UNIQUE (email);


--
-- TOC entry 4886 (class 2606 OID 25937)
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4889 (class 2606 OID 25939)
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4880 (class 2606 OID 25941)
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 25943)
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4895 (class 2606 OID 25945)
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4883 (class 2606 OID 25947)
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- TOC entry 4778 (class 1259 OID 25948)
-- Name: ai_anomalie_produit_id_2c48ea36; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_anomalie_produit_id_2c48ea36 ON public.ai_anomalie USING btree (produit_id);


--
-- TOC entry 4781 (class 1259 OID 25949)
-- Name: ai_prediction_produit_id_181df729; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_prediction_produit_id_181df729 ON public.ai_prediction USING btree (produit_id);


--
-- TOC entry 4782 (class 1259 OID 25950)
-- Name: ai_recommandation_groupe_id_2739be33; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_recommandation_groupe_id_2739be33 ON public.ai_recommandation USING btree (groupe_id);


--
-- TOC entry 4785 (class 1259 OID 25951)
-- Name: ai_recommandation_produit_id_7ffec4eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_recommandation_produit_id_7ffec4eb ON public.ai_recommandation USING btree (produit_id);


--
-- TOC entry 4786 (class 1259 OID 25952)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4791 (class 1259 OID 25953)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 4794 (class 1259 OID 25954)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4797 (class 1259 OID 25955)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 4802 (class 1259 OID 25956)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 4805 (class 1259 OID 25957)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 4816 (class 1259 OID 25958)
-- Name: django_q_task_id_32882367_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_q_task_id_32882367_like ON public.django_q_task USING btree (id varchar_pattern_ops);


--
-- TOC entry 4819 (class 1259 OID 25959)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 4822 (class 1259 OID 25960)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 4825 (class 1259 OID 25961)
-- Name: import_export_exporthistory_user_id_d541b1ba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX import_export_exporthistory_user_id_d541b1ba ON public.import_export_exporthistory USING btree (user_id);


--
-- TOC entry 4828 (class 1259 OID 25962)
-- Name: import_export_importhistory_user_id_65394061; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX import_export_importhistory_user_id_65394061 ON public.import_export_importhistory USING btree (user_id);


--
-- TOC entry 4831 (class 1259 OID 25963)
-- Name: inventory_ajustementinventaire_produit_id_f268bb1d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_ajustementinventaire_produit_id_f268bb1d ON public.inventory_ajustementinventaire USING btree (produit_id);


--
-- TOC entry 4832 (class 1259 OID 25964)
-- Name: inventory_ajustementinventaire_session_id_33c4352b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_ajustementinventaire_session_id_33c4352b ON public.inventory_ajustementinventaire USING btree (session_id);


--
-- TOC entry 4833 (class 1259 OID 25965)
-- Name: inventory_ajustementinventaire_valide_par_id_6e981e77; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_ajustementinventaire_valide_par_id_6e981e77 ON public.inventory_ajustementinventaire USING btree (valide_par_id);


--
-- TOC entry 4834 (class 1259 OID 25966)
-- Name: inventory_l_session_926ee4_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_l_session_926ee4_idx ON public.inventory_lignecomptage USING btree (session_id, produit_id);


--
-- TOC entry 4835 (class 1259 OID 25967)
-- Name: inventory_lignecomptage_operateur_id_31bb95d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_lignecomptage_operateur_id_31bb95d7 ON public.inventory_lignecomptage USING btree (operateur_id);


--
-- TOC entry 4838 (class 1259 OID 25968)
-- Name: inventory_lignecomptage_produit_id_91aff6b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_lignecomptage_produit_id_91aff6b1 ON public.inventory_lignecomptage USING btree (produit_id);


--
-- TOC entry 4839 (class 1259 OID 25969)
-- Name: inventory_lignecomptage_session_id_a2e28985; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_lignecomptage_session_id_a2e28985 ON public.inventory_lignecomptage USING btree (session_id);


--
-- TOC entry 4844 (class 1259 OID 25970)
-- Name: inventory_sessioninventaire_reference_54d96633_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_sessioninventaire_reference_54d96633_like ON public.inventory_sessioninventaire USING btree (reference varchar_pattern_ops);


--
-- TOC entry 4847 (class 1259 OID 25971)
-- Name: inventory_sessioninventaire_responsable_id_b337bdf2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_sessioninventaire_responsable_id_b337bdf2 ON public.inventory_sessioninventaire USING btree (responsable_id);


--
-- TOC entry 4850 (class 1259 OID 25972)
-- Name: journal_mouvement_produit_id_f6def3e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX journal_mouvement_produit_id_f6def3e9 ON public.journal_mouvement USING btree (produit_id);


--
-- TOC entry 4851 (class 1259 OID 25973)
-- Name: journal_mouvement_utilisateur_id_9c9197d6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX journal_mouvement_utilisateur_id_9c9197d6 ON public.journal_mouvement USING btree (utilisateur_id);


--
-- TOC entry 4854 (class 1259 OID 25974)
-- Name: products_inventaireproduit_mouvement_ajustement_id_e5e4a56d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_inventaireproduit_mouvement_ajustement_id_e5e4a56d ON public.products_inventaireproduit USING btree (mouvement_ajustement_id);


--
-- TOC entry 4857 (class 1259 OID 25975)
-- Name: products_inventaireproduit_produit_id_081864c6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_inventaireproduit_produit_id_081864c6 ON public.products_inventaireproduit USING btree (produit_id);


--
-- TOC entry 4858 (class 1259 OID 25976)
-- Name: products_inventaireproduit_utilisateur_id_78349851; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_inventaireproduit_utilisateur_id_78349851 ON public.products_inventaireproduit USING btree (utilisateur_id);


--
-- TOC entry 4859 (class 1259 OID 25977)
-- Name: products_produit_code_e00638ca_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_produit_code_e00638ca_like ON public.products_produit USING btree (code varchar_pattern_ops);


--
-- TOC entry 4862 (class 1259 OID 25978)
-- Name: products_produit_groupe_id_8ec8d707; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_produit_groupe_id_8ec8d707 ON public.products_produit USING btree (groupe_id);


--
-- TOC entry 4867 (class 1259 OID 25979)
-- Name: reports_reorderanalysis_produit_id_5b323c68; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reports_reorderanalysis_produit_id_5b323c68 ON public.reports_reorderanalysis USING btree (produit_id);


--
-- TOC entry 4876 (class 1259 OID 25980)
-- Name: users_user_email_243f6e77_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_email_243f6e77_like ON public.users_user USING btree (email varchar_pattern_ops);


--
-- TOC entry 4884 (class 1259 OID 25981)
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- TOC entry 4887 (class 1259 OID 25982)
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- TOC entry 4890 (class 1259 OID 25983)
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4893 (class 1259 OID 25984)
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- TOC entry 4881 (class 1259 OID 25985)
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4896 (class 2606 OID 25986)
-- Name: ai_anomalie ai_anomalie_produit_id_2c48ea36_fk_products_produit_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_anomalie
    ADD CONSTRAINT ai_anomalie_produit_id_2c48ea36_fk_products_produit_id FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4897 (class 2606 OID 25991)
-- Name: ai_prediction ai_prediction_produit_id_181df729_fk_products_produit_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_prediction
    ADD CONSTRAINT ai_prediction_produit_id_181df729_fk_products_produit_id FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4898 (class 2606 OID 25996)
-- Name: ai_recommandation ai_recommandation_groupe_id_2739be33_fk_products_groupe_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_recommandation
    ADD CONSTRAINT ai_recommandation_groupe_id_2739be33_fk_products_groupe_id FOREIGN KEY (groupe_id) REFERENCES public.products_groupe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4899 (class 2606 OID 26001)
-- Name: ai_recommandation ai_recommandation_produit_id_7ffec4eb_fk_products_produit_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_recommandation
    ADD CONSTRAINT ai_recommandation_produit_id_7ffec4eb_fk_products_produit_id FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4900 (class 2606 OID 26006)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4901 (class 2606 OID 26011)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4902 (class 2606 OID 26016)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4903 (class 2606 OID 26021)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4904 (class 2606 OID 26026)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4905 (class 2606 OID 26031)
-- Name: import_export_exporthistory import_export_exporthistory_user_id_d541b1ba_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_export_exporthistory
    ADD CONSTRAINT import_export_exporthistory_user_id_d541b1ba_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4906 (class 2606 OID 26036)
-- Name: import_export_importhistory import_export_importhistory_user_id_65394061_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_export_importhistory
    ADD CONSTRAINT import_export_importhistory_user_id_65394061_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4907 (class 2606 OID 26041)
-- Name: inventory_ajustementinventaire inventory_ajustement_produit_id_f268bb1d_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_ajustementinventaire
    ADD CONSTRAINT inventory_ajustement_produit_id_f268bb1d_fk_products_ FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4908 (class 2606 OID 26046)
-- Name: inventory_ajustementinventaire inventory_ajustement_session_id_33c4352b_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_ajustementinventaire
    ADD CONSTRAINT inventory_ajustement_session_id_33c4352b_fk_inventory FOREIGN KEY (session_id) REFERENCES public.inventory_sessioninventaire(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4909 (class 2606 OID 26051)
-- Name: inventory_ajustementinventaire inventory_ajustement_valide_par_id_6e981e77_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_ajustementinventaire
    ADD CONSTRAINT inventory_ajustement_valide_par_id_6e981e77_fk_users_use FOREIGN KEY (valide_par_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4910 (class 2606 OID 26056)
-- Name: inventory_lignecomptage inventory_lignecompt_produit_id_91aff6b1_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_lignecomptage
    ADD CONSTRAINT inventory_lignecompt_produit_id_91aff6b1_fk_products_ FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4911 (class 2606 OID 26061)
-- Name: inventory_lignecomptage inventory_lignecompt_session_id_a2e28985_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_lignecomptage
    ADD CONSTRAINT inventory_lignecompt_session_id_a2e28985_fk_inventory FOREIGN KEY (session_id) REFERENCES public.inventory_sessioninventaire(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4912 (class 2606 OID 26066)
-- Name: inventory_lignecomptage inventory_lignecomptage_operateur_id_31bb95d7_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_lignecomptage
    ADD CONSTRAINT inventory_lignecomptage_operateur_id_31bb95d7_fk_users_user_id FOREIGN KEY (operateur_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4913 (class 2606 OID 26071)
-- Name: inventory_sessioninventaire inventory_sessioninv_responsable_id_b337bdf2_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sessioninventaire
    ADD CONSTRAINT inventory_sessioninv_responsable_id_b337bdf2_fk_users_use FOREIGN KEY (responsable_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4914 (class 2606 OID 26076)
-- Name: journal_mouvement journal_mouvement_produit_id_f6def3e9_fk_products_produit_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.journal_mouvement
    ADD CONSTRAINT journal_mouvement_produit_id_f6def3e9_fk_products_produit_id FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4915 (class 2606 OID 26081)
-- Name: journal_mouvement journal_mouvement_utilisateur_id_9c9197d6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.journal_mouvement
    ADD CONSTRAINT journal_mouvement_utilisateur_id_9c9197d6_fk_users_user_id FOREIGN KEY (utilisateur_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4916 (class 2606 OID 26086)
-- Name: products_inventaireproduit products_inventairep_mouvement_ajustement_e5e4a56d_fk_journal_m; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_inventaireproduit
    ADD CONSTRAINT products_inventairep_mouvement_ajustement_e5e4a56d_fk_journal_m FOREIGN KEY (mouvement_ajustement_id) REFERENCES public.journal_mouvement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4917 (class 2606 OID 26091)
-- Name: products_inventaireproduit products_inventairep_produit_id_081864c6_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_inventaireproduit
    ADD CONSTRAINT products_inventairep_produit_id_081864c6_fk_products_ FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4918 (class 2606 OID 26096)
-- Name: products_inventaireproduit products_inventairep_utilisateur_id_78349851_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_inventaireproduit
    ADD CONSTRAINT products_inventairep_utilisateur_id_78349851_fk_users_use FOREIGN KEY (utilisateur_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4919 (class 2606 OID 26101)
-- Name: products_produit products_produit_groupe_id_8ec8d707_fk_products_groupe_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_produit
    ADD CONSTRAINT products_produit_groupe_id_8ec8d707_fk_products_groupe_id FOREIGN KEY (groupe_id) REFERENCES public.products_groupe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4920 (class 2606 OID 26106)
-- Name: reports_reorderanalysis reports_reorderanaly_produit_id_5b323c68_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports_reorderanalysis
    ADD CONSTRAINT reports_reorderanaly_produit_id_5b323c68_fk_products_ FOREIGN KEY (produit_id) REFERENCES public.products_produit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4921 (class 2606 OID 26111)
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4922 (class 2606 OID 26116)
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4923 (class 2606 OID 26121)
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4924 (class 2606 OID 26126)
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-10-14 08:36:02

--
-- PostgreSQL database dump complete
--

