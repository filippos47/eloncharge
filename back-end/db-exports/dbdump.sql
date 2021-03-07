--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

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
    energy_delivered integer NOT NULL,
    total_cost integer NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    payment character varying(2) NOT NULL,
    protocol character varying(2) NOT NULL,
    car_id_id integer,
    point_id_id integer,
    pricing_id_id integer,
    CONSTRAINT api_chargesession_energy_delivered_check CHECK ((energy_delivered >= 0)),
    CONSTRAINT api_chargesession_total_cost_check CHECK ((total_cost >= 0))
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
1	464 NNY	Audi	S10 Extended Cab	2006-10-26	6	Sedan, Coupe, Wagon	1
2	685 ZFS	Jeep	Panamera	1993-08-15	8	Pickup	1
3	027NM	Toyota	Jetta	1974-07-22	8	SUV1992	2
4	MBE5597	Ford	S80	1990-10-20	15	Hatchback	2
\.


--
-- Data for Name: api_chargesession; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_chargesession (id, energy_delivered, total_cost, start, "end", payment, protocol, car_id_id, point_id_id, pricing_id_id) FROM stdin;
1	37	27	2020-12-16 09:09:37+02	2020-12-17 01:43:25+02	CH	WD	1	3	8
2	45	37	2020-12-16 00:44:29+02	2020-12-17 04:18:06+02	CH	WR	1	2	5
3	12	23	2020-12-16 08:56:21+02	2020-12-17 09:13:40+02	CH	WR	1	1	2
4	12	38	2020-12-16 17:16:42+02	2020-12-17 11:28:36+02	CH	WR	2	5	9
5	37	47	2020-12-16 23:51:14+02	2020-12-17 06:38:25+02	CH	WD	2	5	10
6	50	49	2020-12-16 19:38:52+02	2020-12-17 14:46:17+02	CH	WD	2	5	10
7	47	45	2020-12-16 18:38:35+02	2020-12-17 21:25:31+02	CH	WR	3	5	10
8	5	32	2020-12-16 08:06:44+02	2020-12-17 22:25:49+02	CH	WD	3	1	2
9	38	49	2020-12-16 05:26:19+02	2020-12-17 06:59:58+02	CD	WD	3	3	7
10	18	32	2020-12-16 00:25:51+02	2020-12-17 01:41:17+02	CD	WD	4	5	9
11	47	31	2020-12-16 20:13:53+02	2020-12-17 03:11:02+02	CH	WR	4	5	9
12	15	33	2020-12-16 19:39:33+02	2020-12-17 18:00:56+02	CD	WR	4	5	10
\.


--
-- Data for Name: api_point; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_point (id, station_id_id) FROM stdin;
1	1
2	2
3	3
4	4
5	4
\.


--
-- Data for Name: api_pricing; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_pricing (id, description, price, station_id_id) FROM stdin;
1	Make stage Congress. Positive natural nearly themselves of.\nNew defense material road whole mind south. Site box power responsibility save outside thousand.	2	1
2	Fly success church relationship special. Kitchen action anything. Certainly else we section question style clearly.\nDevelopment station charge tough agree charge condition.	3	1
3	Approach choose doctor. Easy heart contain have chance. Continue religious character. Partner establish conference level yeah just decide.	2	2
4	Star fast sing know. Thought glass themselves visit option act bag. Far paper reality wait administration enter keep. Option remain rest theory alone customer.	3	2
5	Energy deal tend meet guy key total. Part necessary whatever pattern even wall.\nPopulation serve despite nature space enough. Specific go mission forget dream.	3	2
6	Sort free investment relate thus base end. Federal board raise usually might. If well peace soldier interesting.\nEver power board when before popular learn. Front operation fact author.	1	3
7	Money officer compare those parent. These body explain pay.\nOk let partner almost concern sea edge. Probably yourself artist agreement final main official image.	3	3
8	Many involve follow wide keep. Total pass father. Recognize pretty from share pull situation.	3	3
9	Property certainly city space particularly interesting anything foreign. Control night real local. Themselves attack help around.	1	4
10	Door statement kind affect leave purpose college. Record miss research on television around.	2	4
\.


--
-- Data for Name: api_station; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_station (id, latitude, longtitude, address, number, zipcode, city, region, country, operator_id) FROM stdin;
1	38.0491855000000001	23.8352652999999997	Nikodimou	353	50166	Melissia	Attica	Greece	1
2	37.9667104999999978	23.7479130000000005	Kalyftaki	486	88154	Pagkrati	Attica	Greece	1
3	37.9968599999999981	23.7475300000000011	Aidiniou	152	49871	Agios Stefanos	Attica	Greece	2
4	38.0589700000000022	23.7911499999999982	Virwnos	384	46612	Pefki	Attica	Greece	2
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
1	pbkdf2_sha256$216000$xUvi3DGQ4k2P$uOrdXU0SfqkJraJCtZwtzcrqWy8xgSurVh89+m7bHHA=	\N	f	nbird	Rebecca	Lopez	julie42@yahoo.com	f	t	2021-01-15 00:09:39.280157+02
2	pbkdf2_sha256$216000$joKH75sBPN4c$nzyQSGmPr+W1QY5/NKYmE6ikZt6kYWALnpZA029Az4k=	\N	f	destiny03	Kelly	Russell	cordovajohn@giles.com	f	t	2021-01-15 00:09:39.466771+02
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
1	contenttypes	0001_initial	2021-01-15 00:09:30.770713+02
2	auth	0001_initial	2021-01-15 00:09:31.085793+02
3	admin	0001_initial	2021-01-15 00:09:31.728865+02
4	admin	0002_logentry_remove_auto_add	2021-01-15 00:09:31.873444+02
5	admin	0003_logentry_add_action_flag_choices	2021-01-15 00:09:31.956993+02
6	api	0001_initial	2021-01-15 00:09:32.666549+02
7	api	0002_auto_20210106_1157	2021-01-15 00:09:33.140046+02
8	api	0003_auto_20210106_1218	2021-01-15 00:09:33.411331+02
9	api	0004_auto_20210107_1105	2021-01-15 00:09:33.590528+02
10	contenttypes	0002_remove_content_type_name	2021-01-15 00:09:33.637623+02
11	auth	0002_alter_permission_name_max_length	2021-01-15 00:09:33.664227+02
12	auth	0003_alter_user_email_max_length	2021-01-15 00:09:33.682593+02
13	auth	0004_alter_user_username_opts	2021-01-15 00:09:33.707223+02
14	auth	0005_alter_user_last_login_null	2021-01-15 00:09:33.724362+02
15	auth	0006_require_contenttypes_0002	2021-01-15 00:09:33.736797+02
16	auth	0007_alter_validators_add_error_messages	2021-01-15 00:09:33.764314+02
17	auth	0008_alter_user_username_max_length	2021-01-15 00:09:33.811925+02
18	auth	0009_alter_user_last_name_max_length	2021-01-15 00:09:33.843016+02
19	auth	0010_alter_group_name_max_length	2021-01-15 00:09:33.864288+02
20	auth	0011_update_proxy_permissions	2021-01-15 00:09:33.88458+02
21	auth	0012_alter_user_first_name_max_length	2021-01-15 00:09:33.903709+02
22	sessions	0001_initial	2021-01-15 00:09:33.990816+02
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

SELECT pg_catalog.setval('public.api_chargesession_id_seq', 12, true);


--
-- Name: api_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_point_id_seq', 5, true);


--
-- Name: api_pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_pricing_id_seq', 10, true);


--
-- Name: api_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_station_id_seq', 4, true);


--
-- Name: api_usersession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_usersession_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.django_migrations_id_seq', 22, true);


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
1	108 5551	Mercedes-Benz	EQC	2019-10-04	13	Convertible, Sedan, Coupe	1
2	VUH-5830	Chevrolet	Spark EV	2019-07-03	12	Sedan	1
3	GV2 0570	BMW	i3	2020-10-27	6	Hatchback	2
4	929 XIQ	Nissan	Leaf	2019-06-26	14	Wagon, Sedan	2
\.


--
-- Data for Name: api_chargesession; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_chargesession (id, energy_delivered, total_cost, start, "end", payment, protocol, car_id_id, point_id_id, pricing_id_id) FROM stdin;
1	12.737	29.46	2021-02-05 12:17:11+02	2021-02-05 18:17:36+02	CD	WR	1	10	3
2	49.384	45.5	2021-01-22 23:03:01+02	2021-01-23 06:03:11+02	CD	WD	1	39	18
3	4.909	42.35	2021-01-23 19:51:26+02	2021-01-24 03:52:04+02	CH	WR	1	41	17
4	34.113	32.33	2021-02-24 05:48:56+02	2021-02-24 17:49:41+02	CD	WR	1	25	12
5	24.527	48.91	2021-01-10 06:55:09+02	2021-01-10 15:55:16+02	CH	WR	1	32	15
6	39.397	47.31	2021-01-21 01:17:22+02	2021-01-21 11:18:07+02	CH	WR	1	21	12
7	34.184	22.3	2021-01-12 12:06:13+02	2021-01-12 21:06:56+02	CH	WD	1	21	12
8	49.382	43.38	2021-02-23 11:44:02+02	2021-02-23 14:44:07+02	CH	WD	1	2	1
9	11.537	47.84	2021-02-11 21:52:53+02	2021-02-12 00:53:37+02	CD	WR	1	36	16
10	23.546	22.18	2021-03-03 18:22:15+02	2021-03-04 01:22:55+02	CH	WR	1	6	2
11	14.467	38.85	2021-01-13 14:39:09+02	2021-01-13 19:40:05+02	CD	WD	1	3	1
12	40.789	46.15	2021-01-30 11:48:03+02	2021-01-30 20:48:22+02	CH	WR	1	37	18
13	29.665	32.77	2021-02-11 03:45:02+02	2021-02-11 12:45:04+02	CH	WR	1	33	16
14	3.209	38.97	2021-03-03 13:57:46+02	2021-03-03 21:57:56+02	CD	WD	1	14	7
15	32.895	21.5	2021-02-01 08:14:28+02	2021-02-01 11:14:52+02	CH	WD	1	12	7
16	15.642	31.97	2021-02-04 05:29:31+02	2021-02-04 09:29:44+02	CD	WR	1	11	5
17	42.129	24.91	2021-01-08 15:11:29+02	2021-01-08 18:12:16+02	CH	WD	1	26	13
18	3.625	45.02	2021-02-15 07:15:56+02	2021-02-15 14:16:18+02	CD	WR	1	22	12
19	41.499	43.75	2021-02-05 11:00:13+02	2021-02-05 16:00:15+02	CD	WD	1	2	1
20	12.364	34.67	2021-02-04 02:23:07+02	2021-02-04 13:23:38+02	CH	WD	1	30	13
21	38.559	39.84	2021-01-24 12:22:16+02	2021-01-24 22:22:30+02	CH	WD	2	32	15
22	46.46	28.37	2021-02-28 23:24:12+02	2021-03-01 07:25:00+02	CH	WR	2	33	16
23	4.744	35.84	2021-01-14 22:34:33+02	2021-01-15 01:35:00+02	CD	WR	2	9	3
24	22.633	20.85	2021-01-07 05:30:20+02	2021-01-07 14:31:19+02	CH	WD	2	29	14
25	23.401	43.85	2021-01-08 18:47:35+02	2021-01-08 22:47:50+02	CD	WR	2	41	18
26	32.995	36.69	2021-02-03 16:16:35+02	2021-02-04 02:17:34+02	CH	WR	2	13	7
27	21.534	29.67	2021-02-18 10:09:13+02	2021-02-18 13:09:32+02	CH	WR	2	38	18
28	46.249	23.15	2021-01-07 10:15:06+02	2021-01-07 21:15:31+02	CD	WD	2	26	13
29	47.109	44.54	2021-02-01 21:48:19+02	2021-02-02 04:48:35+02	CD	WD	2	42	18
30	6.315	49.04	2021-02-04 21:35:37+02	2021-02-05 05:36:07+02	CH	WD	2	16	9
31	25.829	47.88	2021-01-29 16:25:12+02	2021-01-29 21:25:21+02	CH	WD	2	28	13
32	49.863	45.42	2021-01-24 21:11:07+02	2021-01-25 06:11:39+02	CH	WD	2	14	5
33	15.877	33.42	2021-02-05 07:18:43+02	2021-02-05 18:19:09+02	CH	WR	2	20	12
34	7.196	32.43	2021-02-19 05:24:34+02	2021-02-19 16:25:18+02	CD	WR	2	13	7
35	15.981	41.46	2021-02-17 15:20:42+02	2021-02-18 01:21:32+02	CH	WD	3	35	16
36	10.726	29.27	2021-01-14 12:46:53+02	2021-01-14 18:47:17+02	CD	WR	3	33	16
37	45.654	41.77	2021-01-19 09:18:19+02	2021-01-19 12:18:37+02	CD	WR	3	23	10
38	44.364	30.54	2021-01-19 00:43:44+02	2021-01-19 10:44:10+02	CD	WD	3	16	9
39	9.484	31.1	2021-02-08 05:03:47+02	2021-02-08 10:03:59+02	CD	WR	3	24	10
40	37.844	25.69	2021-01-22 05:26:22+02	2021-01-22 17:26:53+02	CD	WR	3	14	7
41	30.092	21.02	2021-03-05 01:02:22+02	2021-03-05 13:03:17+02	CD	WD	3	36	16
42	3.175	35.74	2021-03-02 13:04:12+02	2021-03-02 16:04:54+02	CD	WD	3	23	10
43	30.391	21.5	2021-02-15 05:15:51+02	2021-02-15 11:16:13+02	CD	WD	3	23	11
44	35.477	28.87	2021-02-11 05:42:42+02	2021-02-11 13:43:41+02	CD	WD	3	15	6
45	26.847	28.63	2021-02-21 08:52:38+02	2021-02-21 14:53:00+02	CD	WR	3	8	3
46	8.819	32.27	2021-01-16 05:18:40+02	2021-01-16 17:19:06+02	CD	WD	3	40	18
47	13.66	39.2	2021-02-18 14:16:52+02	2021-02-19 01:17:28+02	CD	WR	4	14	6
48	34.394	28.89	2021-01-24 09:14:44+02	2021-01-24 16:14:47+02	CH	WD	4	34	16
49	43.573	20.73	2021-01-30 18:27:25+02	2021-01-31 01:28:24+02	CD	WR	4	26	14
50	17.471	47.43	2021-02-05 16:12:07+02	2021-02-05 21:12:38+02	CD	WD	4	5	2
51	13.43	21.25	2021-01-30 17:28:20+02	2021-01-31 02:28:44+02	CD	WD	4	36	16
52	10.429	42.17	2021-01-10 11:22:56+02	2021-01-10 20:23:11+02	CD	WR	4	27	13
53	28.943	24.27	2021-01-11 07:29:50+02	2021-01-11 16:30:40+02	CD	WD	4	22	12
54	37.019	27.32	2021-01-11 00:13:03+02	2021-01-11 12:13:06+02	CD	WD	4	4	1
55	39.131	41.3	2021-01-16 05:34:43+02	2021-01-16 16:35:32+02	CH	WR	4	41	18
56	41.942	41.11	2021-02-07 15:37:55+02	2021-02-08 01:38:47+02	CD	WR	4	10	4
57	44.792	37.7	2021-01-20 18:48:38+02	2021-01-20 21:49:12+02	CH	WR	4	14	7
58	32.628	32.06	2021-02-20 12:19:35+02	2021-02-20 21:19:37+02	CH	WD	4	30	14
59	45.091	41.31	2021-02-15 08:56:31+02	2021-02-15 17:57:21+02	CH	WR	4	11	6
60	26.052	36.52	2021-01-14 20:27:05+02	2021-01-15 07:27:36+02	CD	WR	4	38	18
61	32.369	44.92	2021-02-12 13:38:10+02	2021-02-12 19:38:11+02	CH	WR	4	31	15
\.


--
-- Data for Name: api_point; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_point (id, station_id_id) FROM stdin;
1	1
2	1
3	1
4	1
5	2
6	2
7	2
8	3
9	3
10	3
11	4
12	4
13	4
14	4
15	4
16	5
17	5
18	5
19	5
20	6
21	6
22	6
23	6
24	6
25	6
26	7
27	7
28	7
29	7
30	7
31	8
32	8
33	9
34	9
35	9
36	9
37	10
38	10
39	10
40	10
41	10
42	10
\.


--
-- Data for Name: api_pricing; Type: TABLE DATA; Schema: public; Owner: eloncharge
--

COPY public.api_pricing (id, description, price, station_id_id) FROM stdin;
1	Consumer determine property during me hard dark. Image trial hope hair film understand head. Certainly bill show compare.\nPerformance own speak everything whose campaign read father.	1.805	1
2	Together else reach least here energy trouble hand.\nDown partner born admit. Answer term car.\nPull must nice city. Happen least check area. Quality seven his practice real enjoy new.	1.826	2
3	Feel team final Democrat health result. Star high look and end project hour.	2.561	3
4	Apply laugh option modern. Smile blood truth strategy add large tax. Article factor measure a structure make.	2.698	3
5	Cultural success probably political suddenly. Morning process eye thing character event response.	2.528	4
6	Ground range assume leave national break young. Sign last him media.\nSenior compare think answer. Process candidate born while.	2.044	4
7	Have listen little nor class here. Rise brother health situation low.	1.059	4
8	Consumer around arrive moment mean western and. Eye beat option certainly almost bill. Increase might wall anything stuff time.	1.746	5
9	Let want call.\nInclude hospital town.\nGlass course catch color. Capital arm often prevent week. There law shake short miss.\nThem across probably begin.	1.013	5
10	Future reality pretty positive edge treat. Determine some book impact camera. Probably investment recent win manage doctor. Most dog address daughter real bank company.	1.938	6
11	Everybody little standard place bad reach reach believe. During civil career try that. Admit board law market item must smile form.	2.651	6
12	Weight we newspaper item. Make fly beautiful language.\nTeam nice detail make letter full. List factor agent behavior.	1.507	6
13	High seem strong mind American. Around prove behind forward one figure.	1.295	7
14	Live study occur late agent piece without.\nLocal its bed. Trade mother travel have.\nPeople language simple card attorney watch gas.	2.291	7
15	Expert religious share. Inside week current unit rise report. Recognize environmental than these throughout effect. Magazine establish surface.	1.264	8
16	Story career ready clear federal. Against situation century. Trip race catch health same respond. Its action particularly fast marriage.	1.253	9
17	At whether alone evidence. Fear forward region good girl hospital film.\nCheck control measure box cut woman. Their throughout church often home here.	1.038	10
18	Large spend list past buy. Between either which bad.\nReport effort free catch hit firm. Small represent less power newspaper state weight. Light item entire hundred one audience fact girl.	1.566	10
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
1	4RvTCM/jS4JPvhstkenz+0UurwcEzbdPQFcDfmopbZNVW5NUlC0N6OMiwu+d/9NXdBWVfz6befCFfbrutZAc3A==	2021-03-07 17:48:43.192853+02	1
2	rrBduaSFSi/ji/1+6zQCITInWkOfZ6OP/Zs1Qf7e2OeJ/KdS9bImM60S4YluYv+Wvb+C4XW23c+JJTXxzgLPDA==	2021-03-07 17:49:26.634846+02	2
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
1	pbkdf2_sha256$216000$P2a9qmKHylWV$LVIFVmFKBChFD5kxOHVTZlulc16ZKHVJZ5pNacRQ+Nw=	\N	f	micheal05	Shawn	Lane	suarezjustin@hotmail.com	f	t	2021-03-07 14:48:17.932755+02
2	pbkdf2_sha256$216000$jCawM8kMbB2E$IfS88kkN2K0EbNtFjFl3Mjy1FTTI6WGxMK8qeYAxTzw=	\N	f	nwilson	Robert	Bishop	amygarcia@reed.org	f	t	2021-03-07 14:48:18.118721+02
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
1	contenttypes	0001_initial	2021-03-07 14:47:53.295759+02
2	auth	0001_initial	2021-03-07 14:47:53.732249+02
3	admin	0001_initial	2021-03-07 14:47:54.558526+02
4	admin	0002_logentry_remove_auto_add	2021-03-07 14:47:54.675168+02
5	admin	0003_logentry_add_action_flag_choices	2021-03-07 14:47:54.686689+02
6	api	0001_initial	2021-03-07 14:47:55.24394+02
7	api	0002_auto_20210106_1157	2021-03-07 14:47:55.858645+02
8	api	0003_auto_20210106_1218	2021-03-07 14:47:56.207745+02
9	api	0004_auto_20210107_1105	2021-03-07 14:47:56.431062+02
10	api	0005_auto_20210307_1447	2021-03-07 14:47:56.855729+02
11	contenttypes	0002_remove_content_type_name	2021-03-07 14:47:56.892981+02
12	auth	0002_alter_permission_name_max_length	2021-03-07 14:47:56.906864+02
13	auth	0003_alter_user_email_max_length	2021-03-07 14:47:56.929355+02
14	auth	0004_alter_user_username_opts	2021-03-07 14:47:56.949017+02
15	auth	0005_alter_user_last_login_null	2021-03-07 14:47:56.960357+02
16	auth	0006_require_contenttypes_0002	2021-03-07 14:47:56.963597+02
17	auth	0007_alter_validators_add_error_messages	2021-03-07 14:47:56.984968+02
18	auth	0008_alter_user_username_max_length	2021-03-07 14:47:57.056386+02
19	auth	0009_alter_user_last_name_max_length	2021-03-07 14:47:57.082518+02
20	auth	0010_alter_group_name_max_length	2021-03-07 14:47:57.098599+02
21	auth	0011_update_proxy_permissions	2021-03-07 14:47:57.121301+02
22	auth	0012_alter_user_first_name_max_length	2021-03-07 14:47:57.142906+02
23	sessions	0001_initial	2021-03-07 14:47:57.279079+02
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

SELECT pg_catalog.setval('public.api_point_id_seq', 42, true);


--
-- Name: api_pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: eloncharge
--

SELECT pg_catalog.setval('public.api_pricing_id_seq', 18, true);


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

