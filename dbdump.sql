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
-- Name: answers; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE answers (
    answer_question_id integer NOT NULL,
    answer_answer text NOT NULL,
    answer_id integer NOT NULL
);


ALTER TABLE public.answers OWNER TO ubuntu;

--
-- Name: TABLE answers; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE answers IS 'Correct Answers for Questions.';


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

ALTER SEQUENCE "Answers_answers_answer_id_seq" OWNED BY answers.answer_id;


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

ALTER SEQUENCE "Answers_answers_question_id_seq" OWNED BY answers.answer_question_id;


--
-- Name: possibleanswers; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE possibleanswers (
    panswer_question_id integer NOT NULL,
    panswer_panswer text NOT NULL,
    panswer_id integer NOT NULL
);


ALTER TABLE public.possibleanswers OWNER TO ubuntu;

--
-- Name: TABLE possibleanswers; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE possibleanswers IS 'The possible answers for a question (radio/checkboxes)';


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

ALTER SEQUENCE "PossibleAnswers_panswers_panswer_id_seq" OWNED BY possibleanswers.panswer_id;


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

ALTER SEQUENCE "PossibleAnswers_panswers_question_id_seq" OWNED BY possibleanswers.panswer_question_id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE questions (
    question_id integer NOT NULL,
    question_type text,
    question_question text,
    question_poll_id character(5) NOT NULL,
    question_order integer NOT NULL
);


ALTER TABLE public.questions OWNER TO ubuntu;

--
-- Name: TABLE questions; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE questions IS 'Contains all the questions for each poll';


--
-- Name: COLUMN questions.question_poll_id; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN questions.question_poll_id IS 'Access Code';


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

ALTER SEQUENCE "Questions_question_id_seq" OWNED BY questions.question_id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE responses (
    response_question_id integer DEFAULT 0 NOT NULL,
    response_poll_id character(5) DEFAULT 0 NOT NULL,
    response_user_email text NOT NULL,
    response_id integer NOT NULL,
    response_response text
);


ALTER TABLE public.responses OWNER TO ubuntu;

--
-- Name: TABLE responses; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE responses IS 'contains the responses for each question';


--
-- Name: Responses_response_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE "Responses_response_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Responses_response_id_seq" OWNER TO ubuntu;

--
-- Name: Responses_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE "Responses_response_id_seq" OWNED BY responses.response_id;


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

ALTER SEQUENCE "Responses_responses_question_id_seq" OWNED BY responses.response_question_id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE groups (
    group_name text NOT NULL,
    group_key text NOT NULL,
    group_user_email text NOT NULL,
    group_date_created timestamp with time zone DEFAULT now()
);


ALTER TABLE public.groups OWNER TO ubuntu;

--
-- Name: TABLE groups; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE groups IS 'Groups owned by people';


--
-- Name: COLUMN groups.group_name; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN groups.group_name IS 'Group''s name';


--
-- Name: COLUMN groups.group_key; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN groups.group_key IS 'Key to skip verification';


--
-- Name: COLUMN groups.group_user_email; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN groups.group_user_email IS 'Group''s Owner';


--
-- Name: groupusers; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE groupusers (
    groupuser_group_name text NOT NULL,
    groupuser_user_email_user text NOT NULL,
    groupuser_verified boolean DEFAULT false NOT NULL,
    groupuser_user_email_group text NOT NULL,
    groupuser_date_joined timestamp with time zone DEFAULT now()
);


ALTER TABLE public.groupusers OWNER TO ubuntu;

--
-- Name: TABLE groupusers; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE groupusers IS 'Which users are part of which group or which group contains what users. Also are they verified?';


--
-- Name: COLUMN groupusers.groupuser_group_name; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN groupusers.groupuser_group_name IS 'Name of the Group';


--
-- Name: COLUMN groupusers.groupuser_user_email_user; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN groupusers.groupuser_user_email_user IS 'Owner of the Group';


--
-- Name: polls; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE polls (
    poll_id character(5) NOT NULL,
    poll_name text DEFAULT 'Unnamed Poll'::text NOT NULL,
    poll_date_created timestamp with time zone DEFAULT now() NOT NULL,
    poll_date_end timestamp with time zone,
    poll_active boolean DEFAULT true NOT NULL,
    poll_user_email text NOT NULL,
    poll_group_name text NOT NULL,
    poll_group_user_email text NOT NULL
);


ALTER TABLE public.polls OWNER TO ubuntu;

--
-- Name: TABLE polls; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE polls IS 'Polls keyed by access code.';


--
-- Name: COLUMN polls.poll_id; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN polls.poll_id IS 'Access Code';


--
-- Name: COLUMN polls.poll_name; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN polls.poll_name IS 'Qualified Poll Name';


--
-- Name: COLUMN polls.poll_active; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN polls.poll_active IS 'Wheter the poll is active or not';


--
-- Name: polls_poll_group_user_email_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE polls_poll_group_user_email_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_poll_group_user_email_seq OWNER TO ubuntu;

--
-- Name: polls_poll_group_user_email_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE polls_poll_group_user_email_seq OWNED BY polls.poll_group_user_email;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ubuntu; Tablespace: 
--

CREATE TABLE users (
    user_email text NOT NULL,
    user_hash text NOT NULL,
    user_alias text,
    user_authorized boolean,
    user_salt integer NOT NULL
);


ALTER TABLE public.users OWNER TO ubuntu;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON TABLE users IS 'contains the users';


--
-- Name: COLUMN users.user_email; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN users.user_email IS 'unique username (using email)';


--
-- Name: COLUMN users.user_hash; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN users.user_hash IS 'hash for password';


--
-- Name: COLUMN users.user_alias; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN users.user_alias IS 'the alias of the user if they want it';


--
-- Name: COLUMN users.user_authorized; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN users.user_authorized IS 'is this account authorized';


--
-- Name: COLUMN users.user_salt; Type: COMMENT; Schema: public; Owner: ubuntu
--

COMMENT ON COLUMN users.user_salt IS 'the salt used for hashing the password';


--
-- Name: answer_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY answers ALTER COLUMN answer_id SET DEFAULT nextval('"Answers_answers_answer_id_seq"'::regclass);


--
-- Name: panswer_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY possibleanswers ALTER COLUMN panswer_id SET DEFAULT nextval('"PossibleAnswers_panswers_panswer_id_seq"'::regclass);


--
-- Name: question_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY questions ALTER COLUMN question_id SET DEFAULT nextval('"Questions_question_id_seq"'::regclass);


--
-- Name: response_id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY responses ALTER COLUMN response_id SET DEFAULT nextval('"Responses_response_id_seq"'::regclass);


--
-- Name: Answers_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Answers_answers_answer_id_seq"', 23, true);


--
-- Name: Answers_answers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Answers_answers_question_id_seq"', 1, false);


--
-- Name: PossibleAnswers_panswers_panswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_panswer_id_seq"', 45, true);


--
-- Name: PossibleAnswers_panswers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_question_id_seq"', 1, false);


--
-- Name: Questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Questions_question_id_seq"', 65, true);


--
-- Name: Responses_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Responses_response_id_seq"', 33, true);


--
-- Name: Responses_responses_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Responses_responses_question_id_seq"', 1, false);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY answers (answer_question_id, answer_answer, answer_id) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY groups (group_name, group_key, group_user_email, group_date_created) FROM stdin;
Public	100	anonymous@anonymous.com	2013-11-15 00:15:56.482-06
test	test	dylan@cool.com	2013-11-15 00:15:56.482-06
ANOTHER GROUP	100	dylan@cool.com	2013-11-15 00:15:56.482-06
dylan2's group	500	dylan2@cool.com	2013-11-15 00:15:56.482-06
\.


--
-- Data for Name: groupusers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY groupusers (groupuser_group_name, groupuser_user_email_user, groupuser_verified, groupuser_user_email_group, groupuser_date_joined) FROM stdin;
Public	anonymous@anonymous.com	t	anonymous@anonymous.com	2013-11-15 00:15:28.994-06
ANOTHER GROUP	dylan@cool.com	t	dylan@cool.com	2013-11-15 00:15:28.994-06
Public	dylan2@cool.com	t	anonymous@anonymous.com	2013-11-15 00:15:28.994-06
Public	dylan@cool.com	t	anonymous@anonymous.com	2013-11-15 00:15:28.994-06
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY polls (poll_id, poll_name, poll_date_created, poll_date_end, poll_active, poll_user_email, poll_group_name, poll_group_user_email) FROM stdin;
fkqv4	Grave Poll #41	2013-11-14 14:46:52.134-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
agku9	Marvellous Poll #59	2013-11-14 15:31:54.267-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
bcnt9	Dynamite Poll #83	2013-11-14 19:12:37.076-06	\N	t	dylan2@cool.com	Public	anonymous@anonymous.com
ewy05	Shocking Poll #71	2013-11-14 21:00:03.126-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
afksw	Cruel  Poll #10	2013-11-14 22:36:34.054-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
fhrx7	Cowardly Poll #45	2013-11-14 22:41:13.011-06	\N	f	anonymous@anonymous.com	Public	anonymous@anonymous.com
kux49	Glowing Poll #76	2013-11-14 22:43:45.311-06	\N	f	anonymous@anonymous.com	Public	anonymous@anonymous.com
dqrtz	Easy Poll #44	2013-11-14 18:12:48.677-06	\N	f	dylan@cool.com	test	dylan@cool.com
hksz3	Rude Poll #27	2013-11-14 15:37:44.099-06	\N	f	dylan@cool.com	Public	anonymous@anonymous.com
eprw4	Difficult Poll #91	2013-11-14 18:07:23.085-06	\N	f	dylan@cool.com	Public	anonymous@anonymous.com
fhvy7	Mysterious Poll #56	2013-11-14 23:30:50.904-06	\N	f	dylan@cool.com	Public	anonymous@anonymous.com
efgk1	Gigantic Poll #77	2013-11-14 15:47:41.262-06	\N	t	dylan@cool.com	Public	anonymous@anonymous.com
\.


--
-- Name: polls_poll_group_user_email_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('polls_poll_group_user_email_seq', 1, false);


--
-- Data for Name: possibleanswers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY possibleanswers (panswer_question_id, panswer_panswer, panswer_id) FROM stdin;
61	yes	43
61	no	44
61	why	45
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY questions (question_id, question_type, question_question, question_poll_id, question_order) FROM stdin;
53	Textbox	test	fkqv4	1
54	Textbox	ghgjh	agku9	1
55	Textbox	oh yea	hksz3	1
56	Textbox	fzxzx	efgk1	1
58	Textbox	TEST	eprw4	1
59	Textbox	SHOULD BE IN TEST GROUP	dqrtz	1
60	Textbox	test	bcnt9	1
61	Checkbox	eqwewqewqeq	ewy05	1
62	Textbox	hjgh	afksw	1
63	Textbox	asfasfsa	fhrx7	1
64	Textbox	eqweqwewq	kux49	1
65	Textbox	test	fhvy7	1
\.


--
-- Data for Name: responses; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY responses (response_question_id, response_poll_id, response_user_email, response_id, response_response) FROM stdin;
53	fkqv4	anonymous@anonymous.com	32	hgjh
62	afksw	anonymous@anonymous.com	33	what is this
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY users (user_email, user_hash, user_alias, user_authorized, user_salt) FROM stdin;
anonymous@anonymous.com	casdaskdhioqwue80u12iodjklas	Anonymous	t	12345
test@test.com	033cc361cb85071ba1b09e1d63869c3afa5a1451	test	t	23498
dylan2@cool.com	d9b00fa7019ae01c7dc6bf0ebb48aa4296db3b14	Dylan2	t	32855
dylan@cool.com	dfa5e0815676ac71a85a9bc2c036b0ef814cd29d	dylan	t	38657
\.


--
-- Name: Answers_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT "Answers_pkey" PRIMARY KEY (answer_id, answer_question_id, answer_answer);


--
-- Name: Groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (group_name, group_user_email);


--
-- Name: Polls_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT "Polls_pkey" PRIMARY KEY (poll_id);


--
-- Name: PossibleAnswers_panswer_id_key; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY possibleanswers
    ADD CONSTRAINT "PossibleAnswers_panswer_id_key" UNIQUE (panswer_id);


--
-- Name: PossibleAnswers_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY possibleanswers
    ADD CONSTRAINT "PossibleAnswers_pkey" PRIMARY KEY (panswer_question_id, panswer_panswer, panswer_id);


--
-- Name: Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY (question_id);


--
-- Name: Responses_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_pkey" PRIMARY KEY (response_id);


--
-- Name: Responses_response_id_key; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_response_id_key" UNIQUE (response_id);


--
-- Name: Users_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (user_email);


--
-- Name: groupusers_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu; Tablespace: 
--

ALTER TABLE ONLY groupusers
    ADD CONSTRAINT groupusers_pkey PRIMARY KEY (groupuser_group_name, groupuser_user_email_user, groupuser_user_email_group);


--
-- Name: Answers_answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT "Answers_answer_question_id_fkey" FOREIGN KEY (answer_question_id) REFERENCES questions(question_id) ON DELETE CASCADE;


--
-- Name: PossibleAnswers_panswer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY possibleanswers
    ADD CONSTRAINT "PossibleAnswers_panswer_question_id_fkey" FOREIGN KEY (panswer_question_id) REFERENCES questions(question_id) ON DELETE CASCADE;


--
-- Name: Questions_question_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT "Questions_question_poll_id_fkey" FOREIGN KEY (question_poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE;


--
-- Name: Responses_response_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_response_poll_id_fkey" FOREIGN KEY (response_poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE;


--
-- Name: Responses_response_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_response_question_id_fkey" FOREIGN KEY (response_question_id) REFERENCES questions(question_id) ON DELETE CASCADE;


--
-- Name: Responses_responses_Email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT "Responses_responses_Email_fkey" FOREIGN KEY (response_user_email) REFERENCES users(user_email);


--
-- Name: groups_group_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_group_user_email_fkey FOREIGN KEY (group_user_email) REFERENCES users(user_email);


--
-- Name: groupusers_groupuser_user_email_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY groupusers
    ADD CONSTRAINT groupusers_groupuser_user_email_group_fkey FOREIGN KEY (groupuser_user_email_group, groupuser_group_name) REFERENCES groups(group_user_email, group_name) ON DELETE CASCADE;


--
-- Name: groupusers_groupuser_user_email_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY groupusers
    ADD CONSTRAINT groupusers_groupuser_user_email_user_fkey FOREIGN KEY (groupuser_user_email_user) REFERENCES users(user_email) ON DELETE CASCADE;


--
-- Name: polls_poll_group_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_poll_group_name_fkey FOREIGN KEY (poll_group_name, poll_group_user_email) REFERENCES groups(group_name, group_user_email) ON DELETE CASCADE;


--
-- Name: polls_poll_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_poll_user_email_fkey FOREIGN KEY (poll_user_email) REFERENCES users(user_email) ON DELETE CASCADE;


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

