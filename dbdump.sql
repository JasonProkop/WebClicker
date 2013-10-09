--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: polls; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE polls (
    poll_id integer NOT NULL,
    poll_name text DEFAULT 'Created Poll'::text
);


ALTER TABLE public.polls OWNER TO postgres;

--
-- Name: TABLE polls; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE polls IS 'Stores each pool by a ID number';


--
-- Name: Polls_poll_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Polls_poll_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Polls_poll_id_seq" OWNER TO postgres;

--
-- Name: Polls_poll_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Polls_poll_id_seq" OWNED BY polls.poll_id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE questions (
    question_poll_id integer NOT NULL,
    question_id integer NOT NULL,
    question_type text,
    question_options text
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: TABLE questions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE questions IS 'Contains all the questions for each poll';


--
-- Name: COLUMN questions.question_poll_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN questions.question_poll_id IS 'refers to poll_id from polls';


--
-- Name: Questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Questions_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Questions_question_id_seq" OWNER TO postgres;

--
-- Name: Questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Questions_question_id_seq" OWNED BY questions.question_id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE responses (
    responses_poll_id integer NOT NULL,
    responses_questions_id integer NOT NULL,
    question_type text,
    question_options text
);


ALTER TABLE public.responses OWNER TO postgres;

--
-- Name: TABLE responses; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE responses IS 'contains the responses for each question';


--
-- Name: COLUMN responses.responses_poll_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN responses.responses_poll_id IS 'refers to poll_id from polls';


--
-- Name: COLUMN responses.responses_questions_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN responses.responses_questions_id IS 'refers to question_id from Questions';


--
-- Name: toy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE toy (
    q1 text,
    q2a1 text,
    q2a2 text,
    q2a3 text,
    q3 text,
    q4 text
);


ALTER TABLE public.toy OWNER TO postgres;

--
-- Name: TABLE toy; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE toy IS 'Toy prototype';


--
-- Name: poll_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY polls ALTER COLUMN poll_id SET DEFAULT nextval('"Polls_poll_id_seq"'::regclass);


--
-- Name: question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY questions ALTER COLUMN question_id SET DEFAULT nextval('"Questions_question_id_seq"'::regclass);


--
-- Name: Polls_poll_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Polls_poll_id_seq"', 1, false);


--
-- Name: Questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Questions_question_id_seq"', 1, false);


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY polls (poll_id, poll_name) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY questions (question_poll_id, question_id, question_type, question_options) FROM stdin;
\.


--
-- Data for Name: responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY responses (responses_poll_id, responses_questions_id, question_type, question_options) FROM stdin;
\.


--
-- Data for Name: toy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY toy (q1, q2a1, q2a2, q2a3, q3, q4) FROM stdin;
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
yes	nr	on	nr	3	please work
no	nr	nr	nr	5	nr
no	nr	on	nr	3	please work!
\.


--
-- Name: Polls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT "Polls_pkey" PRIMARY KEY (poll_id);


--
-- Name: Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY (question_poll_id, question_id);


--
-- Name: Responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_pkey" PRIMARY KEY (responses_poll_id, responses_questions_id);


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

