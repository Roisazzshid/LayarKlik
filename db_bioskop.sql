--
-- PostgreSQL database dump
--

\restrict coM6vr92HzJeblaAugZeNDqTIVAP7sqbYc9GlExA2bn174vVRDdXahpfz0f4am3

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-15 23:35:43

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16581)
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    booking_id integer NOT NULL,
    user_id integer,
    schedule_id integer,
    total_price numeric(10,2),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    movie_id integer,
    cinema_id integer,
    seat_numbers text
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16580)
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_booking_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 231
-- Name: bookings_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_booking_id_seq OWNED BY public.bookings.booking_id;


--
-- TOC entry 224 (class 1259 OID 16509)
-- Name: cinemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cinemas (
    cinema_id integer NOT NULL,
    name character varying(255) NOT NULL,
    address text,
    city character varying(100),
    cinema_type character varying(50)
);


ALTER TABLE public.cinemas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16508)
-- Name: cinemas_cinema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cinemas_cinema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cinemas_cinema_id_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 223
-- Name: cinemas_cinema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cinemas_cinema_id_seq OWNED BY public.cinemas.cinema_id;


--
-- TOC entry 222 (class 1259 OID 16497)
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id integer NOT NULL,
    title character varying(255) NOT NULL,
    genre character varying(100),
    duration_minutes integer,
    release_date date,
    rating_score numeric(2,1),
    base_price numeric(10,2),
    synopsis text,
    poster character varying(255),
    CONSTRAINT movies_rating_score_check CHECK (((rating_score >= (1)::numeric) AND (rating_score <= (5)::numeric)))
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16496)
-- Name: movies_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_movie_id_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 221
-- Name: movies_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;


--
-- TOC entry 228 (class 1259 OID 16538)
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    schedule_id integer NOT NULL,
    movie_id integer,
    studio_id integer,
    show_date date,
    show_time time without time zone,
    price numeric(10,2) DEFAULT 50000
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16537)
-- Name: schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedules_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedules_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 227
-- Name: schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedules_schedule_id_seq OWNED BY public.schedules.schedule_id;


--
-- TOC entry 230 (class 1259 OID 16557)
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    seat_id integer NOT NULL,
    studio_id integer,
    seat_number character varying(10) NOT NULL
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16556)
-- Name: seats_seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seats_seat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seats_seat_id_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 229
-- Name: seats_seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seats_seat_id_seq OWNED BY public.seats.seat_id;


--
-- TOC entry 226 (class 1259 OID 16523)
-- Name: studios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.studios (
    studio_id integer NOT NULL,
    cinema_id integer,
    name character varying(50) NOT NULL,
    studio_type character varying(20) DEFAULT '2D'::character varying
);


ALTER TABLE public.studios OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16522)
-- Name: studios_studio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.studios_studio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.studios_studio_id_seq OWNER TO postgres;

--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 225
-- Name: studios_studio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.studios_studio_id_seq OWNED BY public.studios.studio_id;


--
-- TOC entry 234 (class 1259 OID 16601)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    booking_id integer,
    seat_id integer,
    price_at_booking numeric(10,2),
    movie_id integer
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16600)
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 233
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;


--
-- TOC entry 220 (class 1259 OID 16436)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer CONSTRAINT users_id_not_null NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    nama character varying(100),
    role character varying(20) DEFAULT 'user'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16435)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4902 (class 2604 OID 16584)
-- Name: bookings booking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN booking_id SET DEFAULT nextval('public.bookings_booking_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 16512)
-- Name: cinemas cinema_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinemas ALTER COLUMN cinema_id SET DEFAULT nextval('public.cinemas_cinema_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 16500)
-- Name: movies movie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 16541)
-- Name: schedules schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.schedules_schedule_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 16560)
-- Name: seats seat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats ALTER COLUMN seat_id SET DEFAULT nextval('public.seats_seat_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 16526)
-- Name: studios studio_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios ALTER COLUMN studio_id SET DEFAULT nextval('public.studios_studio_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16604)
-- Name: tickets ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 16439)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5098 (class 0 OID 16581)
-- Dependencies: 232
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (booking_id, user_id, schedule_id, total_price, status, created_at, movie_id, cinema_id, seat_numbers) FROM stdin;
\.


--
-- TOC entry 5090 (class 0 OID 16509)
-- Dependencies: 224
-- Data for Name: cinemas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cinemas (cinema_id, name, address, city, cinema_type) FROM stdin;
2	Margo City XXI	Jl. Margonda Raya No.358	Depok	XXI
3	CGV Grand Indonesia	East Mall, Lantai 8	Jakarta Pusat	CGV
4	Cinepolis Plaza Semanggi	Kawasan Bisnis Granadha	Jakarta Selatan	Cinepolis
1	Grand Indonesia Mall	Jl. MH Thamrin No.1, Menteng	Jakarta	CGV
7	amba mall	Jl. MH Thamrin No.1, Menteng	Jakarta Selatan	CGV
\.


--
-- TOC entry 5088 (class 0 OID 16497)
-- Dependencies: 222
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, title, genre, duration_minutes, release_date, rating_score, base_price, synopsis, poster) FROM stdin;
1	Avatar: Fire and Ash	Sci-Fi Action	160	2025-12-17	4.8	50000.00	Perang hebat antara klan laut dan klan api di Pandora.	avatar.jpeg
2	Janur Ireng	Horror	115	2025-12-24	4.5	40000.00	Kisah asal usul santet Sewu Dino yang legendaris.	janur-ireng.jpeg
3	Comic 8 Revolution	Action Comedy	105	2025-12-24	3.9	35000.00	Misi rahasia agen comic yang kacau namun lucu.	comic8.jpeg
4	Mertua Ngeri Kali	Comedy Drama	90	2025-12-11	4.2	35000.00	Drama menantu dan mertua dengan bumbu komedi Batak.	mertuangerikali.jpeg
5	Five Nights at Freddys 2	Horror	105	2025-12-03	4.0	45000.00	Lanjutan teror boneka animatronik yang mencekam.	fivenights2.jpeg
6	Wasiat Warisan	Drama	100	2025-12-04	3.7	35000.00	Rebutan harta warisan keluarga yang mengharukan.	wasiatwarisan.jpeg
7	Gundala: Negeri Ini Butuh Patriot	Action Sci-Fi	120	2025-12-30	4.6	45000.00	Kebangkitan pahlawan super Indonesia dalam menghadapi ketidakadilan.	gundala.jpeg
9	Laskar Pelangi: Sang Pemimpi	Drama Family	125	2025-12-15	4.7	35000.00	Perjuangan anak-anak Belitong mengejar mimpi hingga ke tanah Eropa.	laskarpelangi.jpeg
10	The Big 4: Reborn	Action Comedy	115	2026-01-10	4.3	40000.00	Empat pensiunan pembunuh bayaran kembali beraksi untuk misi tak terduga.	thebig4.jpeg
8	Pengabdi Setan 3	Horror Mystery	120	2026-01-15	4.9	50000.00	Babak akhir dari misteri keluarga rini dan rahasia sekte kegelapan.	pengabdisetan.jpeg
\.


--
-- TOC entry 5094 (class 0 OID 16538)
-- Dependencies: 228
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (schedule_id, movie_id, studio_id, show_date, show_time, price) FROM stdin;
6	1	1	2026-01-05	14:00:00	45000.00
7	1	2	2026-01-05	19:00:00	50000.00
8	2	1	2026-01-06	13:30:00	40000.00
15	1	1	2026-01-07	15:00:00	45000.00
16	2	1	2026-01-07	15:00:00	45000.00
17	3	1	2026-01-07	15:00:00	45000.00
18	4	1	2026-01-07	15:00:00	45000.00
19	5	1	2026-01-07	15:00:00	45000.00
20	6	1	2026-01-07	15:00:00	45000.00
21	7	1	2026-01-07	15:00:00	45000.00
22	8	1	2026-01-07	15:00:00	45000.00
23	9	1	2026-01-07	15:00:00	45000.00
24	10	1	2026-01-07	15:00:00	45000.00
25	1	2	2026-01-07	15:00:00	45000.00
26	2	2	2026-01-07	15:00:00	45000.00
27	3	2	2026-01-07	15:00:00	45000.00
28	4	2	2026-01-07	15:00:00	45000.00
29	5	2	2026-01-07	15:00:00	45000.00
30	6	2	2026-01-07	15:00:00	45000.00
31	7	2	2026-01-07	15:00:00	45000.00
32	8	2	2026-01-07	15:00:00	45000.00
33	9	2	2026-01-07	15:00:00	45000.00
34	10	2	2026-01-07	15:00:00	45000.00
35	1	3	2026-01-07	15:00:00	45000.00
36	2	3	2026-01-07	15:00:00	45000.00
37	3	3	2026-01-07	15:00:00	45000.00
38	4	3	2026-01-07	15:00:00	45000.00
39	5	3	2026-01-07	15:00:00	45000.00
40	6	3	2026-01-07	15:00:00	45000.00
41	7	3	2026-01-07	15:00:00	45000.00
43	9	3	2026-01-07	15:00:00	45000.00
44	10	3	2026-01-07	15:00:00	45000.00
45	8	1	2026-01-07	22:22:00	30000.00
47	6	2	2026-01-06	20:30:00	30000.00
42	8	2	2026-01-07	15:00:00	40000.00
49	8	7	2026-01-10	22:22:00	22222.00
\.


--
-- TOC entry 5096 (class 0 OID 16557)
-- Dependencies: 230
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (seat_id, studio_id, seat_number) FROM stdin;
\.


--
-- TOC entry 5092 (class 0 OID 16523)
-- Dependencies: 226
-- Data for Name: studios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.studios (studio_id, cinema_id, name, studio_type) FROM stdin;
1	1	Studio 1	XXI
2	1	Studio 2	XXI
3	2	Studio 1 Margo	XXI
4	1	Studio 1 Test	2D
\.


--
-- TOC entry 5100 (class 0 OID 16601)
-- Dependencies: 234
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (ticket_id, booking_id, seat_id, price_at_booking, movie_id) FROM stdin;
\.


--
-- TOC entry 5086 (class 0 OID 16436)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, email, password, created_at, updated_at, nama, role) FROM stdin;
1	isamiq	isamiq3@gmail.com	admin123	2025-12-17 10:23:08.17583+07	2025-12-17 10:23:08.17583+07	Rois Azzam	admin
3	admin	admin@admin.com	admin123	2026-01-09 08:35:30.759043+07	2026-01-09 08:35:30.759043+07	admin	admin
4	user	user@user.com	user123	2026-01-09 08:45:30.763239+07	2026-01-09 08:45:30.763239+07	user	user
5	sayid	sayid@gmai.com	sayid123	2026-01-14 14:07:53.460169+07	2026-01-14 14:07:53.460169+07	sayid	user
\.


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 231
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 8, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 223
-- Name: cinemas_cinema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cinemas_cinema_id_seq', 7, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 221
-- Name: movies_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movie_id_seq', 15, true);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 227
-- Name: schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 49, true);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 229
-- Name: seats_seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seats_seat_id_seq', 1, false);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 225
-- Name: studios_studio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.studios_studio_id_seq', 1, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 233
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 1, false);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- TOC entry 4924 (class 2606 OID 16589)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 4916 (class 2606 OID 16518)
-- Name: cinemas cinemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinemas
    ADD CONSTRAINT cinemas_pkey PRIMARY KEY (cinema_id);


--
-- TOC entry 4914 (class 2606 OID 16507)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);


--
-- TOC entry 4920 (class 2606 OID 16545)
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 4922 (class 2606 OID 16564)
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_id);


--
-- TOC entry 4918 (class 2606 OID 16531)
-- Name: studios studios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT studios_pkey PRIMARY KEY (studio_id);


--
-- TOC entry 4926 (class 2606 OID 16607)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 4908 (class 2606 OID 16452)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4910 (class 2606 OID 16448)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4912 (class 2606 OID 16450)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4931 (class 2606 OID 24700)
-- Name: bookings bookings_cinema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_cinema_id_fkey FOREIGN KEY (cinema_id) REFERENCES public.cinemas(cinema_id);


--
-- TOC entry 4932 (class 2606 OID 16618)
-- Name: bookings bookings_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- TOC entry 4933 (class 2606 OID 16595)
-- Name: bookings bookings_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id);


--
-- TOC entry 4934 (class 2606 OID 16590)
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4928 (class 2606 OID 32892)
-- Name: schedules schedules_cinema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_cinema_id_fkey FOREIGN KEY (studio_id) REFERENCES public.cinemas(cinema_id) ON DELETE CASCADE;


--
-- TOC entry 4929 (class 2606 OID 16546)
-- Name: schedules schedules_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- TOC entry 4930 (class 2606 OID 16565)
-- Name: seats seats_studio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_studio_id_fkey FOREIGN KEY (studio_id) REFERENCES public.studios(studio_id) ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 16532)
-- Name: studios studios_cinema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT studios_cinema_id_fkey FOREIGN KEY (cinema_id) REFERENCES public.cinemas(cinema_id) ON DELETE CASCADE;


--
-- TOC entry 4935 (class 2606 OID 16608)
-- Name: tickets tickets_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id) ON DELETE CASCADE;


--
-- TOC entry 4936 (class 2606 OID 16623)
-- Name: tickets tickets_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(movie_id);


--
-- TOC entry 4937 (class 2606 OID 16613)
-- Name: tickets tickets_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_id_fkey FOREIGN KEY (seat_id) REFERENCES public.seats(seat_id);


-- Completed on 2026-01-15 23:35:44

--
-- PostgreSQL database dump complete
--

\unrestrict coM6vr92HzJeblaAugZeNDqTIVAP7sqbYc9GlExA2bn174vVRDdXahpfz0f4am3

