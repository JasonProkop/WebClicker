--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: polls; Type: TABLE; Schema: public; Owner: max; Tablespace: 
--

CREATE TABLE polls (
    poll_id integer NOT NULL,
    poll_name text DEFAULT 'Created Poll'::text
);


ALTER TABLE public.polls OWNER TO max;

--
-- Name: TABLE polls; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON TABLE polls IS 'Stores each pool by a ID number';


--
-- Name: Polls_poll_id_seq; Type: SEQUENCE; Schema: public; Owner: max
--

CREATE SEQUENCE "Polls_poll_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Polls_poll_id_seq" OWNER TO max;

--
-- Name: Polls_poll_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: max
--

ALTER SEQUENCE "Polls_poll_id_seq" OWNED BY polls.poll_id;


--
-- Name: Questions; Type: TABLE; Schema: public; Owner: max; Tablespace: 
--

CREATE TABLE "Questions" (
    question_poll_id integer NOT NULL,
    question_id integer NOT NULL,
    question_type text,
    question_options text
);


ALTER TABLE public."Questions" OWNER TO max;

--
-- Name: TABLE "Questions"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON TABLE "Questions" IS 'Contains all the questions for each poll';


--
-- Name: COLUMN "Questions".question_poll_id; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Questions".question_poll_id IS 'refers to poll_id from polls';


--
-- Name: Questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: max
--

CREATE SEQUENCE "Questions_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Questions_question_id_seq" OWNER TO max;

--
-- Name: Questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: max
--

ALTER SEQUENCE "Questions_question_id_seq" OWNED BY "Questions".question_id;


--
-- Name: Responses; Type: TABLE; Schema: public; Owner: max; Tablespace: 
--

CREATE TABLE "Responses" (
    responses_poll_id integer NOT NULL,
    responses_questions_id integer NOT NULL,
    question_type text,
    question_options text
);


ALTER TABLE public."Responses" OWNER TO max;

--
-- Name: TABLE "Responses"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON TABLE "Responses" IS 'contains the responses for each question';


--
-- Name: COLUMN "Responses".responses_poll_id; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Responses".responses_poll_id IS 'refers to poll_id from polls';


--
-- Name: COLUMN "Responses".responses_questions_id; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Responses".responses_questions_id IS 'refers to question_id from Questions';


--
-- Name: Toy; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE "Toy" (
    q1 text,
    q2a1 text,
    q2a2 text,
    q2a3 text,
    q3 text,
    q4 text
);


ALTER TABLE public."Toy" OWNER TO dylan;

--
-- Name: TABLE "Toy"; Type: COMMENT; Schema: public; Owner: dylan
--

COMMENT ON TABLE "Toy" IS 'Toy prototype';


--
-- Name: Users; Type: TABLE; Schema: public; Owner: max; Tablespace: 
--

CREATE TABLE "Users" (
    "Email" text NOT NULL,
    "Hash" text NOT NULL,
    "Salt" text NOT NULL,
    "Alias" text,
    "Authorized" boolean
);


ALTER TABLE public."Users" OWNER TO max;

--
-- Name: TABLE "Users"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON TABLE "Users" IS 'contains the users';


--
-- Name: COLUMN "Users"."Email"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Users"."Email" IS 'unique username (using email)';


--
-- Name: COLUMN "Users"."Hash"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Users"."Hash" IS 'hash for password';


--
-- Name: COLUMN "Users"."Salt"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Users"."Salt" IS 'salt for getting password';


--
-- Name: COLUMN "Users"."Alias"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Users"."Alias" IS 'the alias of the user if they want it';


--
-- Name: COLUMN "Users"."Authorized"; Type: COMMENT; Schema: public; Owner: max
--

COMMENT ON COLUMN "Users"."Authorized" IS 'is this account authorized';


--
-- Name: question_id; Type: DEFAULT; Schema: public; Owner: max
--

ALTER TABLE ONLY "Questions" ALTER COLUMN question_id SET DEFAULT nextval('"Questions_question_id_seq"'::regclass);


--
-- Name: poll_id; Type: DEFAULT; Schema: public; Owner: max
--

ALTER TABLE ONLY polls ALTER COLUMN poll_id SET DEFAULT nextval('"Polls_poll_id_seq"'::regclass);


--
-- Name: Polls_poll_id_seq; Type: SEQUENCE SET; Schema: public; Owner: max
--

SELECT pg_catalog.setval('"Polls_poll_id_seq"', 1, false);


--
-- Data for Name: Questions; Type: TABLE DATA; Schema: public; Owner: max
--

COPY "Questions" (question_poll_id, question_id, question_type, question_options) FROM stdin;
\.


--
-- Name: Questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: max
--

SELECT pg_catalog.setval('"Questions_question_id_seq"', 1, false);


--
-- Data for Name: Responses; Type: TABLE DATA; Schema: public; Owner: max
--

COPY "Responses" (responses_poll_id, responses_questions_id, question_type, question_options) FROM stdin;
\.


--
-- Data for Name: Toy; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY "Toy" (q1, q2a1, q2a2, q2a3, q3, q4) FROM stdin;
nr	nr	nr	nr	nr	nr
on	on	nr	on	4	This is a test....
nr	nr	nr	nr	nr	nr
nr	nr	nr	nr	nr	nr
on	nr	on	nr	5	nr
on	on	on	on	7	nr
on	on	nr	nr	5	nr
on	on	on	on	7	cool!
on	on	on	on	1	nr
on	on	on	nr	5	nr
on	nr	nr	nr	nr	Sup
on	on	on	on	5	After you answer a question it should advance to the next question instead of having the user advance it manually.  But maintain the ability to go back to a question to revise a previous answer.
on	nr	nr	on	6	Points for answering questions, redeem points for money/legal downloads of media/coupons
on	on	nr	nr	5	nr
nr	nr	nr	nr	nr	nr
on	nr	nr	on	6	24 hour review period to determine if submitted poll contains appropriate/age-related content.\r\nTime limit.\r\nNumber of characters in a comment limit.\r\nSurveys become (un)available based on GPS location.
on	on	on	nr	4	"; drop table results - - just making sure you're sanitising that input 
on	nr	nr	nr	6	:P
nr	nr	nr	nr	nr	nr
nr	nr	nr	nr	nr	nr
on	on	on	nr	6	SEKrjSKEr
on	on	nr	on	8	Max is a weiner 
on	nr	nr	nr	nr	Testing out
on	nr	nr	nr	nr	Testing out
on	nr	nr	nr	nr	Testing out
on	on	nr	nr	8	Cool!
on	on	on	on	3	They made the clicker worth marks. It sucked. Then I almost HAD to go to class... I still didn't go...but yea.
nr	nr	nr	nr	nr	nr
on	nr	on	on	4	Test
on	on	nr	nr	7	Interesting - this was fun
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: max
--

COPY "Users" ("Email", "Hash", "Salt", "Alias", "Authorized") FROM stdin;
test@test.com	dsaf90asdsakjdi0sdu,.sdqwd	dalskd	blah	\N
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: max
--

COPY polls (poll_id, poll_name) FROM stdin;
\.


--
-- Name: Polls_pkey; Type: CONSTRAINT; Schema: public; Owner: max; Tablespace: 
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT "Polls_pkey" PRIMARY KEY (poll_id);


--
-- Name: Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: max; Tablespace: 
--

ALTER TABLE ONLY "Questions"
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY (question_poll_id, question_id);


--
-- Name: Responses_pkey; Type: CONSTRAINT; Schema: public; Owner: max; Tablespace: 
--

ALTER TABLE ONLY "Responses"
    ADD CONSTRAINT "Responses_pkey" PRIMARY KEY (responses_poll_id, responses_questions_id);


--
-- Name: Users_pkey; Type: CONSTRAINT; Schema: public; Owner: max; Tablespace: 
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("Email");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

