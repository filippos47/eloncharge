--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_car; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_car (
    id integer NOT NULL,
    licence character varying(10) NOT NULL,
    brand character varying(255),
    model character varying(255),
    release date,
    consumption integer,
    type character varying(255) NOT NULL,
    user_id_id integer NOT NULL,
    CONSTRAINT api_car_consumption_check CHECK ((consumption >= 0))
);


ALTER TABLE public.api_car OWNER TO eloncharge;

--
-- Name: api_car_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_car_id_seq OWNER TO eloncharge;

--
-- Name: api_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_car_id_seq OWNED BY public.api_car.id;


--
-- Name: api_chargesession; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_chargesession (
    id integer NOT NULL,
    energy_delivered double precision NOT NULL,
    total_cost double precision NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    payment character varying(2) NOT NULL,
    protocol character varying(2) NOT NULL,
    car_id_id integer,
    point_id_id integer,
    pricing_id_id integer
);


ALTER TABLE public.api_chargesession OWNER TO eloncharge;

--
-- Name: api_chargesession_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_chargesession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_chargesession_id_seq OWNER TO eloncharge;

--
-- Name: api_chargesession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_chargesession_id_seq OWNED BY public.api_chargesession.id;


--
-- Name: api_point; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_point (
    id integer NOT NULL,
    station_id_id integer NOT NULL
);


ALTER TABLE public.api_point OWNER TO eloncharge;

--
-- Name: api_point_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_point_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_point_id_seq OWNER TO eloncharge;

--
-- Name: api_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_point_id_seq OWNED BY public.api_point.id;


--
-- Name: api_pricing; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_pricing (
    id integer NOT NULL,
    description character varying(1000) NOT NULL,
    price double precision NOT NULL,
    station_id_id integer NOT NULL
);


ALTER TABLE public.api_pricing OWNER TO eloncharge;

--
-- Name: api_pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_pricing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_pricing_id_seq OWNER TO eloncharge;

--
-- Name: api_pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_pricing_id_seq OWNED BY public.api_pricing.id;


--
-- Name: api_station; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_station (
    id integer NOT NULL,
    latitude double precision NOT NULL,
    longtitude double precision NOT NULL,
    address character varying(255) NOT NULL,
    number character varying(255) NOT NULL,
    zipcode character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    region character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    operator_id integer
);


ALTER TABLE public.api_station OWNER TO eloncharge;

--
-- Name: api_station_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_station_id_seq OWNER TO eloncharge;

--
-- Name: api_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_station_id_seq OWNED BY public.api_station.id;


--
-- Name: api_usersession; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.api_usersession (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires timestamp with time zone,
    user_id_id integer NOT NULL
);


ALTER TABLE public.api_usersession OWNER TO eloncharge;

--
-- Name: api_usersession_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.api_usersession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_usersession_id_seq OWNER TO eloncharge;

--
-- Name: api_usersession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.api_usersession_id_seq OWNED BY public.api_usersession.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO eloncharge;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO eloncharge;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO eloncharge;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO eloncharge;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO eloncharge;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO eloncharge;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO eloncharge;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO eloncharge;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO eloncharge;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO eloncharge;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO eloncharge;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO eloncharge;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO eloncharge;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO eloncharge;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO eloncharge;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO eloncharge;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO eloncharge;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: eloncharge
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO eloncharge;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: eloncharge
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: eloncharge
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO eloncharge;

--
-- Name: api_car id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_car ALTER COLUMN id SET DEFAULT nextval('public.api_car_id_seq'::regclass);


--
-- Name: api_chargesession id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_chargesession ALTER COLUMN id SET DEFAULT nextval('public.api_chargesession_id_seq'::regclass);


--
-- Name: api_point id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_point ALTER COLUMN id SET DEFAULT nextval('public.api_point_id_seq'::regclass);


--
-- Name: api_pricing id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_pricing ALTER COLUMN id SET DEFAULT nextval('public.api_pricing_id_seq'::regclass);


--
-- Name: api_station id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_station ALTER COLUMN id SET DEFAULT nextval('public.api_station_id_seq'::regclass);


--
-- Name: api_usersession id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_usersession ALTER COLUMN id SET DEFAULT nextval('public.api_usersession_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: api_car; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_car (id, licence, brand, model, release, consumption, type, user_id_id) FROM stdin;
1	ZTR Z97	Mercedes-Benz	EQC	2020-05-04	8	Sedan	1
2	996 CWS	Chevrolet	Spark EV	2020-05-20	15	Pickup	1
3	4-75105	BMW	i3	2019-08-23	11	Pickup	2
4	07O 5101	Nissan	Leaf	2019-04-10	5	Sedan	2
\.


--
-- Data for Name: api_chargesession; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_chargesession (id, energy_delivered, total_cost, start, "end", payment, protocol, car_id_id, point_id_id, pricing_id_id) FROM stdin;
1	40.478	43.5	2021-02-11 01:07:56+02	2021-02-11 07:08:09+02	CH	WD	1	15	8
2	26.488	29.58	2021-01-21 16:06:41+02	2021-01-21 19:07:29+02	CD	WD	1	4	2
3	46.383	27.72	2021-02-15 07:48:09+02	2021-02-15 12:48:27+02	CH	WD	1	29	15
4	37.691	44.24	2021-02-26 12:32:32+02	2021-02-26 19:33:10+02	CH	WR	1	6	2
5	46.566	49.29	2021-02-14 12:21:16+02	2021-02-15 00:22:00+02	CD	WR	1	10	6
6	40.164	27.15	2021-02-05 10:06:02+02	2021-02-05 15:06:39+02	CD	WR	1	37	18
7	8.479	49.44	2021-02-27 15:23:29+02	2021-02-28 03:23:36+02	CH	WR	1	4	2
8	31.075	40.26	2021-01-20 21:41:59+02	2021-01-21 05:42:29+02	CH	WR	1	32	17
9	9.442	45.59	2021-02-05 13:22:59+02	2021-02-06 01:23:01+02	CH	WD	1	26	14
10	4.479	23.21	2021-02-08 09:43:36+02	2021-02-08 14:44:22+02	CH	WR	1	23	12
11	26.737	35.46	2021-01-12 06:00:35+02	2021-01-12 18:01:26+02	CH	WD	1	41	20
12	3.047	35.41	2021-01-26 06:56:23+02	2021-01-26 10:57:16+02	CH	WR	1	29	16
13	21.593	41.84	2021-02-20 13:43:52+02	2021-02-21 00:44:43+02	CD	WR	1	35	18
14	10.61	39.27	2021-01-14 09:05:41+02	2021-01-14 18:05:53+02	CD	WR	1	32	17
15	49.746	31.19	2021-03-05 13:17:46+02	2021-03-05 23:18:15+02	CH	WR	1	7	3
16	14.497	44.58	2021-02-22 09:36:12+02	2021-02-22 13:36:21+02	CD	WR	1	3	1
17	20.664	45.2	2021-02-09 19:57:09+02	2021-02-10 02:57:26+02	CH	WR	1	13	6
18	31.375	27.29	2021-02-17 07:26:06+02	2021-02-17 16:26:43+02	CH	WR	1	15	8
19	7.366	32.9	2021-03-01 18:10:48+02	2021-03-02 02:10:50+02	CD	WR	2	40	20
20	43.447	42.61	2021-01-21 09:32:52+02	2021-01-21 15:33:29+02	CD	WD	2	10	5
21	17.04	32.85	2021-01-15 03:35:51+02	2021-01-15 09:36:36+02	CH	WR	2	21	11
22	26.007	48.85	2021-03-03 01:53:56+02	2021-03-03 08:54:02+02	CD	WD	2	28	15
23	40.739	36.91	2021-01-25 04:53:53+02	2021-01-25 15:53:59+02	CH	WR	2	32	17
24	29.689	38.53	2021-01-09 01:58:25+02	2021-01-09 09:58:33+02	CD	WD	2	6	2
25	14.796	34.94	2021-01-13 11:56:34+02	2021-01-13 22:57:20+02	CD	WR	2	9	5
26	48.441	46.33	2021-02-22 23:14:20+02	2021-02-23 11:15:15+02	CH	WR	2	37	18
27	26.388	23.93	2021-01-19 04:57:54+02	2021-01-19 14:58:12+02	CD	WR	2	28	15
28	32.611	39.74	2021-02-22 12:41:31+02	2021-02-22 17:42:11+02	CH	WR	2	17	7
29	11.702	33.94	2021-02-24 02:03:51+02	2021-02-24 12:04:46+02	CH	WR	2	10	6
30	20.467	43	2021-01-09 22:22:25+02	2021-01-10 04:22:33+02	CD	WR	2	39	19
31	35.314	34.66	2021-02-03 20:34:01+02	2021-02-04 08:34:51+02	CH	WD	2	36	18
32	30.001	21.81	2021-01-24 03:15:21+02	2021-01-24 14:16:14+02	CH	WD	2	21	10
33	21.481	44.06	2021-02-26 20:32:19+02	2021-02-27 03:32:59+02	CD	WD	2	26	14
34	23.802	38.29	2021-02-06 12:57:58+02	2021-02-06 19:58:03+02	CH	WD	3	4	3
35	32.09	33.09	2021-02-19 18:29:57+02	2021-02-20 01:30:46+02	CH	WR	3	19	8
36	18.051	37.59	2021-02-18 01:22:59+02	2021-02-18 13:23:27+02	CD	WR	3	18	7
37	12.136	21.86	2021-01-14 21:24:38+02	2021-01-15 03:25:26+02	CH	WD	3	6	3
38	10.088	28.43	2021-02-28 06:31:02+02	2021-02-28 14:31:25+02	CD	WR	3	38	18
39	30.25	31.58	2021-03-03 19:13:22+02	2021-03-03 22:13:47+02	CD	WR	3	41	20
40	44.786	31.37	2021-03-01 06:42:47+02	2021-03-01 18:42:49+02	CH	WR	3	34	18
41	29.54	35.77	2021-02-12 08:00:25+02	2021-02-12 19:01:21+02	CH	WR	3	22	9
42	27.162	43.2	2021-02-23 02:34:37+02	2021-02-23 11:35:30+02	CH	WD	3	14	4
43	14.955	41.14	2021-01-11 00:02:15+02	2021-01-11 10:03:12+02	CD	WR	3	33	18
44	46.436	22.6	2021-01-13 15:26:54+02	2021-01-13 22:27:34+02	CH	WR	3	5	2
45	29.334	25.6	2021-02-03 14:11:01+02	2021-02-03 17:11:21+02	CH	WR	3	19	7
46	20.373	34.04	2021-01-28 15:07:41+02	2021-01-29 02:08:14+02	CH	WD	3	38	18
47	10.633	36.12	2021-01-25 22:33:01+02	2021-01-26 01:33:16+02	CH	WR	4	17	8
48	21.319	20.12	2021-02-26 18:36:00+02	2021-02-27 02:36:54+02	CD	WR	4	20	7
49	35.207	27.16	2021-01-18 19:21:09+02	2021-01-18 22:22:03+02	CH	WD	4	4	3
50	17.005	48.15	2021-01-26 06:41:06+02	2021-01-26 18:41:55+02	CH	WR	4	11	4
51	6.781	36.48	2021-03-05 01:59:45+02	2021-03-05 06:00:12+02	CD	WD	4	34	18
52	46.135	32.23	2021-01-31 21:31:17+02	2021-02-01 00:31:30+02	CH	WD	4	31	17
53	43.753	45.06	2021-01-16 22:07:00+02	2021-01-17 07:07:08+02	CH	WR	4	13	4
54	24.212	39.39	2021-03-04 12:32:40+02	2021-03-05 00:32:41+02	CH	WR	4	31	17
55	38.564	40.62	2021-01-21 17:02:53+02	2021-01-22 00:03:01+02	CH	WD	4	7	3
56	44.88	47.36	2021-01-07 10:17:52+02	2021-01-07 21:18:03+02	CD	WR	4	7	3
57	12.763	37.01	2021-01-08 13:03:00+02	2021-01-08 16:03:45+02	CD	WR	4	18	8
58	32.955	44.15	2021-01-26 03:48:16+02	2021-01-26 07:49:03+02	CH	WD	4	34	18
59	31.614	46.76	2021-01-30 14:34:46+02	2021-01-30 18:35:20+02	CH	WD	4	21	9
60	3.609	49.38	2021-01-26 06:25:19+02	2021-01-26 14:26:07+02	CH	WD	4	23	12
61	8.874	24.19	2021-02-27 01:27:07+02	2021-02-27 07:27:44+02	CH	WR	4	5	3
\.


--
-- Data for Name: api_point; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_point (id, station_id_id) FROM stdin;
1	1
2	1
3	1
4	2
5	2
6	2
7	2
8	2
9	3
10	3
11	3
12	3
13	3
14	3
15	4
16	4
17	4
18	4
19	4
20	4
21	5
22	5
23	6
24	6
25	6
26	7
27	7
28	7
29	7
30	8
31	8
32	8
33	9
34	9
35	9
36	9
37	9
38	9
39	10
40	10
41	10
\.


--
-- Data for Name: api_pricing; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_pricing (id, description, price, station_id_id) FROM stdin;
1	Treat card international these system modern. Often street kid local born.\nStay case PM choice choose certain forget. Always cover once look around hundred. Head prepare candidate surface little lot.	1.688	1
2	North south perhaps analysis make federal. By them consider appear same whose.\nAnd feeling man sport never rich here. Ahead drug travel itself question buy. Reflect across field.	1.893	2
3	Soon situation production brother. Especially mind two red board people. Station cause blue not.\nCar bed human near personal medical focus. Give top degree east simply.	2.401	2
4	Cut interview green everyone and two. Quality air language each itself that. Drop value budget stuff month.	1.45	3
5	Full surface line. Available pattern bar herself like human give. Billion share again different compare second popular.	2.73	3
6	Tax population tax building. Think game federal choice able me.\nAfter choice such anything side. Name western mother measure.	1.61	3
7	Big thousand network building partner artist early many.\nDiscover rule chair factor with yet. Star several remain voice leg career strong. Modern eye role.	1.601	4
8	Town adult window type that industry memory. Bit begin though evidence visit. Small performance scene across either baby.\nItself we fly center. Travel then force night agree describe although.	2.627	4
9	Store increase better bring answer. But source public work wonder large. Receive bad space wife every prevent. Image radio political reality enough me.\nSimply break administration instead.	1.021	5
10	Physical degree try include total. Lay get room gun car smile sort. Citizen system care office never new central create.\nOthers wide police threat when enjoy fine.	2.984	5
11	Thousand service line what today learn. Street partner something central ground skin cost. Artist town just someone.	2.808	5
12	Majority much new free director doctor.\nEntire process family small north per teacher. Fill throughout son commercial television despite little surface.	2.346	6
13	Move key particularly between notice. Could color their themselves discussion.\nAlong maintain study treatment for or write. Day moment cost current house development.	1.509	6
14	Turn campaign talk manage. Go support term these hour.\nClear may family her send reduce tonight. Station worker return energy.	2.728	7
15	Citizen time meeting. Here strategy sit change education future.\nCitizen land move specific. Last community movement with employee seek open. Onto report American soldier.	2.188	7
16	Course possible positive say. However our letter maybe foreign range. Station return cultural tree.	2.128	7
17	Serve data lose idea today minute thing. Democrat total into by pick. Life reflect somebody civil they.\nSystem hard between usually. Collection glass relate kid.	2.051	8
18	Ahead young adult firm risk involve possible. Maintain soon me pressure chance day. Success rich call various might what employee.	1.003	9
19	Everyone at themselves old often interest these. When source indeed important bad. Traditional job election ten role deal sport.\nSix teach concern out. Inside never exactly. Concern pull join.	1.963	10
20	Performance produce computer senior reduce. Take already instead talk accept cut.\nThere popular pressure college I effort political.	2.298	10
\.


--
-- Data for Name: api_station; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_station (id, latitude, longtitude, address, number, zipcode, city, region, country, operator_id) FROM stdin;
1	38.05949907359015	23.78756308974072	Leoforos Eirinis	53	15121	Pefki	Attica	Greece	1
2	38.11965411202746	23.857860528706954	Leoforos Marathwnos	10	14569	Drosia	Attica	Greece	1
3	37.95926272048575	23.615749635453312	Leoforos Dimokratias	132	18756	Keratsini	Attica	Greece	1
4	38.050580129610026	23.76473209312465	Leoforos Irakleioy	388-390	14122	Irakleio	Attica	Greece	1
5	37.98854473330098	23.763610728706777	Leoforos Kifisias	34	11526	Ampelokipoi	Attica	Greece	1
6	38.119084482991894	23.823922406478125	SEA	Varimpompis	14671	Nea Erithraia	Attica	Greece	2
7	37.986598667856775	23.73448064249625	Spirou Trikoupi	3	10683	Exarcheia	Attica	Greece	2
8	38.041298981745726	23.688213063498598	Kosta Varnali	70	13231	Petroupoli	Attica	Greece	2
9	37.871181514356174	23.758470864288803	Paradromos Leoforou Vouliagmenis	96	16675	Glifada	Attica	Greece	2
10	38.01819548661664	23.803064271035588	Palaiologou	85	15232	Chalandri	Attica	Greece	2
\.


--
-- Data for Name: api_usersession; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_usersession (id, token, expires, user_id_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: eloncharge
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
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add car	7	add_car
26	Can change car	7	change_car
27	Can delete car	7	delete_car
28	Can view car	7	view_car
29	Can add user session	8	add_usersession
30	Can change user session	8	change_usersession
31	Can delete user session	8	delete_usersession
32	Can view user session	8	view_usersession
33	Can add station	9	add_station
34	Can change station	9	change_station
35	Can delete station	9	delete_station
36	Can view station	9	view_station
37	Can add pricing	10	add_pricing
38	Can change pricing	10	change_pricing
39	Can delete pricing	10	delete_pricing
40	Can view pricing	10	view_pricing
41	Can add point	11	add_point
42	Can change point	11	change_point
43	Can delete point	11	delete_point
44	Can view point	11	view_point
45	Can add charge session	12	add_chargesession
46	Can change charge session	12	change_chargesession
47	Can delete charge session	12	delete_chargesession
48	Can view charge session	12	view_chargesession
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$216000$p2TLpqGniDhw$78nL12XvYZs9ysg4CzhkAJo4W7TQJWs2DkUxIiWl8C4=	\N	f	hfrank	Kenneth	Phillips	william41@gmail.com	f	t	2021-03-07 15:53:26.00812+02
2	pbkdf2_sha256$216000$PDHS0lMS41nq$ygdogGdZAG9lvX46KTLDBx5jmeI2FJEJ+R8M8F3xpMs=	\N	f	silvajoseph	Jennifer	Benson	blackburnrobert@sherman.com	f	t	2021-03-07 15:53:26.165309+02
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	car
8	api	usersession
9	api	station
10	api	pricing
11	api	point
12	api	chargesession
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-03-07 15:53:12.899611+02
2	auth	0001_initial	2021-03-07 15:53:13.349235+02
3	admin	0001_initial	2021-03-07 15:53:14.076183+02
4	admin	0002_logentry_remove_auto_add	2021-03-07 15:53:14.186536+02
5	admin	0003_logentry_add_action_flag_choices	2021-03-07 15:53:14.198442+02
6	api	0001_initial	2021-03-07 15:53:14.736002+02
7	api	0002_auto_20210106_1157	2021-03-07 15:53:15.447055+02
8	api	0003_auto_20210106_1218	2021-03-07 15:53:15.899445+02
9	api	0004_auto_20210107_1105	2021-03-07 15:53:16.10045+02
10	api	0005_auto_20210307_1447	2021-03-07 15:53:16.515942+02
11	contenttypes	0002_remove_content_type_name	2021-03-07 15:53:16.546047+02
12	auth	0002_alter_permission_name_max_length	2021-03-07 15:53:16.577473+02
13	auth	0003_alter_user_email_max_length	2021-03-07 15:53:16.595949+02
14	auth	0004_alter_user_username_opts	2021-03-07 15:53:16.617088+02
15	auth	0005_alter_user_last_login_null	2021-03-07 15:53:16.638562+02
16	auth	0006_require_contenttypes_0002	2021-03-07 15:53:16.649377+02
17	auth	0007_alter_validators_add_error_messages	2021-03-07 15:53:16.671605+02
18	auth	0008_alter_user_username_max_length	2021-03-07 15:53:16.749385+02
19	auth	0009_alter_user_last_name_max_length	2021-03-07 15:53:16.76825+02
20	auth	0010_alter_group_name_max_length	2021-03-07 15:53:16.795399+02
21	auth	0011_update_proxy_permissions	2021-03-07 15:53:16.813772+02
22	auth	0012_alter_user_first_name_max_length	2021-03-07 15:53:16.839352+02
23	sessions	0001_initial	2021-03-07 15:53:16.937162+02
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Name: api_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_car_id_seq', 4, true);


--
-- Name: api_chargesession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_chargesession_id_seq', 61, true);


--
-- Name: api_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_point_id_seq', 41, true);


--
-- Name: api_pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_pricing_id_seq', 20, true);


--
-- Name: api_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_station_id_seq', 10, true);


--
-- Name: api_usersession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_usersession_id_seq', 2, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);


--
-- Name: api_car api_car_licence_key; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_car
    ADD CONSTRAINT api_car_licence_key UNIQUE (licence);


--
-- Name: api_car api_car_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_car
    ADD CONSTRAINT api_car_pkey PRIMARY KEY (id);


--
-- Name: api_chargesession api_chargesession_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_chargesession
    ADD CONSTRAINT api_chargesession_pkey PRIMARY KEY (id);


--
-- Name: api_point api_point_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_point
    ADD CONSTRAINT api_point_pkey PRIMARY KEY (id);


--
-- Name: api_pricing api_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_pricing
    ADD CONSTRAINT api_pricing_pkey PRIMARY KEY (id);


--
-- Name: api_station api_station_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_station
    ADD CONSTRAINT api_station_pkey PRIMARY KEY (id);


--
-- Name: api_usersession api_usersession_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_usersession
    ADD CONSTRAINT api_usersession_pkey PRIMARY KEY (id);


--
-- Name: api_usersession api_usersession_token_db7f435c_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_usersession
    ADD CONSTRAINT api_usersession_token_db7f435c_uniq UNIQUE (token);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_car_licence_9dc362a3_like; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_car_licence_9dc362a3_like ON public.api_car USING btree (licence varchar_pattern_ops);


--
-- Name: api_car_user_id_id_eb952f05; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_car_user_id_id_eb952f05 ON public.api_car USING btree (user_id_id);


--
-- Name: api_chargesession_car_id_id_f4f200ee; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_chargesession_car_id_id_f4f200ee ON public.api_chargesession USING btree (car_id_id);


--
-- Name: api_chargesession_point_id_id_d4073913; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_chargesession_point_id_id_d4073913 ON public.api_chargesession USING btree (point_id_id);


--
-- Name: api_chargesession_pricing_id_id_b0bc5944; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_chargesession_pricing_id_id_b0bc5944 ON public.api_chargesession USING btree (pricing_id_id);


--
-- Name: api_point_station_id_id_3341fed8; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_point_station_id_id_3341fed8 ON public.api_point USING btree (station_id_id);


--
-- Name: api_pricing_station_id_id_f1a77174; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_pricing_station_id_id_f1a77174 ON public.api_pricing USING btree (station_id_id);


--
-- Name: api_station_operator_id_43c8c9d7; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_station_operator_id_43c8c9d7 ON public.api_station USING btree (operator_id);


--
-- Name: api_usersession_token_db7f435c_like; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_usersession_token_db7f435c_like ON public.api_usersession USING btree (token varchar_pattern_ops);


--
-- Name: api_usersession_user_id_id_22c9636b; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX api_usersession_user_id_id_22c9636b ON public.api_usersession USING btree (user_id_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: eloncharge
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_car api_car_user_id_id_eb952f05_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_car
    ADD CONSTRAINT api_car_user_id_id_eb952f05_fk_auth_user_id FOREIGN KEY (user_id_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_chargesession api_chargesession_car_id_id_f4f200ee_fk_api_car_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_chargesession
    ADD CONSTRAINT api_chargesession_car_id_id_f4f200ee_fk_api_car_id FOREIGN KEY (car_id_id) REFERENCES public.api_car(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_chargesession api_chargesession_point_id_id_d4073913_fk_api_point_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_chargesession
    ADD CONSTRAINT api_chargesession_point_id_id_d4073913_fk_api_point_id FOREIGN KEY (point_id_id) REFERENCES public.api_point(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_chargesession api_chargesession_pricing_id_id_b0bc5944_fk_api_pricing_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_chargesession
    ADD CONSTRAINT api_chargesession_pricing_id_id_b0bc5944_fk_api_pricing_id FOREIGN KEY (pricing_id_id) REFERENCES public.api_pricing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_point api_point_station_id_id_3341fed8_fk_api_station_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_point
    ADD CONSTRAINT api_point_station_id_id_3341fed8_fk_api_station_id FOREIGN KEY (station_id_id) REFERENCES public.api_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_pricing api_pricing_station_id_id_f1a77174_fk_api_station_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_pricing
    ADD CONSTRAINT api_pricing_station_id_id_f1a77174_fk_api_station_id FOREIGN KEY (station_id_id) REFERENCES public.api_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_station api_station_operator_id_43c8c9d7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_station
    ADD CONSTRAINT api_station_operator_id_43c8c9d7_fk_auth_user_id FOREIGN KEY (operator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_usersession api_usersession_user_id_id_22c9636b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.api_usersession
    ADD CONSTRAINT api_usersession_user_id_id_22c9636b_fk_auth_user_id FOREIGN KEY (user_id_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: eloncharge
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

