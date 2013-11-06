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
-- Name: Answers; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Answers" (
    answers_question_id integer NOT NULL,
    answers_answer text NOT NULL,
    answers_answer_id integer NOT NULL
);


ALTER TABLE public."Answers" OWNER TO ubuntu;

--
-- Name: TABLE "Answers"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Answers" IS 'Correct Answers for Questions.';


--
-- Name: Answers_answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "Answers_answers_answer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Answers_answers_answer_id_seq" OWNER TO ubuntu;

--
-- Name: Answers_answers_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "Answers_answers_answer_id_seq" OWNED BY "Answers".answers_answer_id;


--
-- Name: Answers_answers_question_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "Answers_answers_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Answers_answers_question_id_seq" OWNER TO ubuntu;

--
-- Name: Answers_answers_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "Answers_answers_question_id_seq" OWNED BY "Answers".answers_question_id;


--
-- Name: Polls; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Polls" (
    poll_id character(5) NOT NULL,
    poll_name text DEFAULT 'Unnamed Poll'::text NOT NULL
);


ALTER TABLE public."Polls" OWNER TO ubuntu;

--
-- Name: TABLE "Polls"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Polls" IS 'Polls keyed by access code.';


--
-- Name: COLUMN "Polls".poll_id; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Polls".poll_id IS 'Access Code';


--
-- Name: COLUMN "Polls".poll_name; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Polls".poll_name IS 'Qualified Poll Name';


--
-- Name: PossibleAnswers; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "PossibleAnswers" (
    panswers_question_id integer NOT NULL,
    panswers_panswer text NOT NULL,
    panswers_panswer_id integer NOT NULL
);


ALTER TABLE public."PossibleAnswers" OWNER TO ubuntu;

--
-- Name: TABLE "PossibleAnswers"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "PossibleAnswers" IS 'The possible answers for a question (radio/checkboxes)';


--
-- Name: PossibleAnswers_panswers_panswer_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "PossibleAnswers_panswers_panswer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PossibleAnswers_panswers_panswer_id_seq" OWNER TO ubuntu;

--
-- Name: PossibleAnswers_panswers_panswer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "PossibleAnswers_panswers_panswer_id_seq" OWNED BY "PossibleAnswers".panswers_panswer_id;


--
-- Name: PossibleAnswers_panswers_question_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "PossibleAnswers_panswers_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PossibleAnswers_panswers_question_id_seq" OWNER TO ubuntu;

--
-- Name: PossibleAnswers_panswers_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "PossibleAnswers_panswers_question_id_seq" OWNED BY "PossibleAnswers".panswers_question_id;


--
-- Name: Questions; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Questions" (
    question_id integer NOT NULL,
    question_type text,
    question_question text,
    question_poll_id character(5) NOT NULL,
    question_order integer NOT NULL
);


ALTER TABLE public."Questions" OWNER TO ubuntu;

--
-- Name: TABLE "Questions"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Questions" IS 'Contains all the questions for each poll';


--
-- Name: COLUMN "Questions".question_poll_id; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Questions".question_poll_id IS 'Access Code';


--
-- Name: Questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "Questions_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Questions_question_id_seq" OWNER TO ubuntu;

--
-- Name: Questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "Questions_question_id_seq" OWNED BY "Questions".question_id;


--
-- Name: Responses; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Responses" (
    responses_question_id integer NOT NULL,
    responses_poll_id character(5),
    responses_response text,
    "responses_Email" text NOT NULL
);


ALTER TABLE public."Responses" OWNER TO ubuntu;

--
-- Name: TABLE "Responses"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Responses" IS 'contains the responses for each question';


--
-- Name: Responses_responses_question_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "Responses_responses_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Responses_responses_question_id_seq" OWNER TO ubuntu;

--
-- Name: Responses_responses_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "Responses_responses_question_id_seq" OWNED BY "Responses".responses_question_id;


--
-- Name: Toy; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Toy" (
    q1 text,
    q2a1 text,
    q2a2 text,
    q2a3 text,
    q3 text,
    q4 text
);


ALTER TABLE public."Toy" OWNER TO ubuntu;

--
-- Name: TABLE "Toy"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Toy" IS 'Toy prototype';


--
-- Name: Users; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE "Users" (
    "Email" text NOT NULL,
    "Hash" text NOT NULL,
    "Alias" text,
    "Authorized" boolean,
    "Salt" integer NOT NULL
);


ALTER TABLE public."Users" OWNER TO ubuntu;

--
-- Name: TABLE "Users"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE "Users" IS 'contains the users';


--
-- Name: COLUMN "Users"."Email"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Users"."Email" IS 'unique username (using email)';


--
-- Name: COLUMN "Users"."Hash"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Users"."Hash" IS 'hash for password';


--
-- Name: COLUMN "Users"."Alias"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Users"."Alias" IS 'the alias of the user if they want it';


--
-- Name: COLUMN "Users"."Authorized"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Users"."Authorized" IS 'is this account authorized';


--
-- Name: COLUMN "Users"."Salt"; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN "Users"."Salt" IS 'the salt used for hashing the password';


--
-- Name: answers_answer_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Answers" ALTER COLUMN answers_answer_id SET DEFAULT nextval('"Answers_answers_answer_id_seq"'::regclass);


--
-- Name: panswers_panswer_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "PossibleAnswers" ALTER COLUMN panswers_panswer_id SET DEFAULT nextval('"PossibleAnswers_panswers_panswer_id_seq"'::regclass);


--
-- Name: question_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Questions" ALTER COLUMN question_id SET DEFAULT nextval('"Questions_question_id_seq"'::regclass);


--
-- Name: responses_question_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Responses" ALTER COLUMN responses_question_id SET DEFAULT nextval('"Responses_responses_question_id_seq"'::regclass);


--
-- Data for Name: Answers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "Answers" (answers_question_id, answers_answer, answers_answer_id) FROM stdin;
1	'Goku'	1
2	'Apple'	2
2	'Orange'	3
\.


--
-- Name: Answers_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Answers_answers_answer_id_seq"', 3, true);


--
-- Name: Answers_answers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Answers_answers_question_id_seq"', 1, false);


--
-- Data for Name: Polls; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "Polls" (poll_id, poll_name) FROM stdin;
12345	First Poll
aaaaa	Second Poll Here
\.


--
-- Data for Name: PossibleAnswers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "PossibleAnswers" (panswers_question_id, panswers_panswer, panswers_panswer_id) FROM stdin;
1	'Batman'	1
1	'Superman'	2
1	'Goku'	3
2	'Apple'	4
2	'Apple'	5
2	'Concrete'	6
2	'Car'	7
\.


--
-- Name: PossibleAnswers_panswers_panswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_panswer_id_seq"', 7, true);


--
-- Name: PossibleAnswers_panswers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_question_id_seq"', 1, false);


--
-- Data for Name: Questions; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "Questions" (question_id, question_type, question_question, question_poll_id, question_order) FROM stdin;
1	'Radio'	'Who would win in a fight?'	12345	1
2	'Checkbox'	'Which of these are fruits?'	12345	2
3	'Text'	'What is your favorite word?'	aaaaa	1
\.


--
-- Name: Questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Questions_question_id_seq"', 3, true);


--
-- Data for Name: Responses; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "Responses" (responses_question_id, responses_poll_id, responses_response, "responses_Email") FROM stdin;
\.


--
-- Name: Responses_responses_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Responses_responses_question_id_seq"', 1, false);


--
-- Data for Name: Toy; Type: TABLE DATA; Schema: public; Owner: ubuntu
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
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY "Users" ("Email", "Hash", "Alias", "Authorized", "Salt") FROM stdin;
'dylan@cool.com'	ee80d384cea3424d083918799de8f33abf9c68ba	'i am a new dylan'	t	97318
'test@test.com'	23463788c8ddf31b75289f49de37f8af269ee6f4	'test'	f	38251
'new@new.com'	88694758d1220acbb5bb1e3f9c04fba27376023a	'new'	f	41000
'dlyan@dylan.com'	af8e5c7a721e1d2d802491b014fa17c8f4a70549	'dylan'	f	82193
'mike@mike.com'	c4704123b35c88d8a1f5a01db74a875e8e6c4b29	'mike'	f	99967
'mike@example.com'	626303e0ce302d89e6d417094759a9fcbc7319b2	'mikee'	f	30050
fafmaster@hotmail.com	83256a8ca4732a6777c51384a641d839fc9d5ab1	Dylan	t	73224
faf@mas.ter	05b7e25ec4293a4515e7c2b87ae2346eb1ae5157		f	55441
\.


--
-- Name: Answers_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "Answers"
    ADD CONSTRAINT "Answers_pkey" PRIMARY KEY (answers_answer_id, answers_question_id, answers_answer);


--
-- Name: Polls_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "Polls"
    ADD CONSTRAINT "Polls_pkey" PRIMARY KEY (poll_id);


--
-- Name: PossibleAnswers_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "PossibleAnswers"
    ADD CONSTRAINT "PossibleAnswers_pkey" PRIMARY KEY (panswers_question_id, panswers_panswer, panswers_panswer_id);


--
-- Name: Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "Questions"
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY (question_id);


--
-- Name: Responses_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "Responses"
    ADD CONSTRAINT "Responses_pkey" PRIMARY KEY ("responses_Email", responses_question_id);


--
-- Name: Users_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("Email");


--
-- Name: Answers_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Answers"
    ADD CONSTRAINT "Answers_answers_question_id_fkey" FOREIGN KEY (answers_question_id) REFERENCES "Questions"(question_id);


--
-- Name: PossibleAnswers_panswers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "PossibleAnswers"
    ADD CONSTRAINT "PossibleAnswers_panswers_question_id_fkey" FOREIGN KEY (panswers_question_id) REFERENCES "Questions"(question_id);


--
-- Name: Questions_question_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Questions"
    ADD CONSTRAINT "Questions_question_poll_id_fkey" FOREIGN KEY (question_poll_id) REFERENCES "Polls"(poll_id);


--
-- Name: Responses_responses_Email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Responses"
    ADD CONSTRAINT "Responses_responses_Email_fkey" FOREIGN KEY ("responses_Email") REFERENCES "Users"("Email");


--
-- Name: Responses_responses_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Responses"
    ADD CONSTRAINT "Responses_responses_poll_id_fkey" FOREIGN KEY (responses_poll_id) REFERENCES "Polls"(poll_id);


--
-- Name: Responses_responses_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY "Responses"
    ADD CONSTRAINT "Responses_responses_question_id_fkey" FOREIGN KEY (responses_question_id) REFERENCES "Questions"(question_id);


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

