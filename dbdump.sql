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
    group_key text DEFAULT 100 NOT NULL,
    group_user_email text NOT NULL,
    group_date_created timestamp without time zone DEFAULT now()
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
    groupuser_date_joined timestamp without time zone DEFAULT now()
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

SELECT pg_catalog.setval('"Answers_answers_answer_id_seq"', 43, true);


--
-- Name: Answers_answers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Answers_answers_question_id_seq"', 1, false);


--
-- Name: PossibleAnswers_panswers_panswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_panswer_id_seq"', 139, true);


--
-- Name: PossibleAnswers_panswers_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"PossibleAnswers_panswers_question_id_seq"', 1, false);


--
-- Name: Questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Questions_question_id_seq"', 121, true);


--
-- Name: Responses_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Responses_response_id_seq"', 2709, true);


--
-- Name: Responses_responses_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('"Responses_responses_question_id_seq"', 1, false);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY answers (answer_question_id, answer_answer, answer_id) FROM stdin;
104	Kali	25
105	purple	26
105	calvin klein	27
106	Charlie Sheen	28
107	His whip	29
108	dota 	30
103	She could apply lipstick with her breasts	24
112	Yar	31
113	T'Pol	32
113	Seven	33
114	Neelix	34
115	Janeway	35
115	Sisco	36
116	Crow	37
117	because they are the best..	38
118	many	39
120	Design	40
121	PHP	41
121	ASP	42
121	Javascript	43
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY groups (group_name, group_key, group_user_email, group_date_created) FROM stdin;
Public	100	anonymous@anonymous.com	\N
GROUP 04	group04	fafmaster@hotmail.com	\N
Dylan's Group	dylan	fafmaster@hotmail.com	\N
key is: 200	200	fafmaster@hotmail.com	\N
ATestGroup	what is this blank for?	zillionk1973@gmail.com	\N
Fan of DoctorWho!	DT	zillionk1973@gmail.com	\N
Max is not allowed	dylan	fafmaster@hotmail.com	2013-11-15 19:39:05.193636
Max's Coolest Group Ever Group	max	max@max.com	2013-11-15 19:49:30.929502
CMPT 370	usask	j@b.c	2013-11-16 23:32:49.323135
Test	none	nallelcm@gmail.com	2013-11-24 17:28:13.13949
TestUser	password	saeed.cs@usask.ca	2013-11-26 17:49:48.39927
\.


--
-- Data for Name: groupusers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY groupusers (groupuser_group_name, groupuser_user_email_user, groupuser_verified, groupuser_user_email_group, groupuser_date_joined) FROM stdin;
Public	fafmaster@hotmail.com	t	anonymous@anonymous.com	\N
Public	zillionk1973@gmail.com	t	anonymous@anonymous.com	\N
Public	j@b.c	t	anonymous@anonymous.com	2013-11-15 07:54:14.292449
key is: 200	j@b.c	t	fafmaster@hotmail.com	2013-11-15 07:54:54.985148
Public	max@max.com	t	anonymous@anonymous.com	2013-11-15 19:45:16.344449
Max's Coolest Group Ever Group	max@max.com	t	max@max.com	2013-11-15 19:49:30.929502
CMPT 370	j@b.c	t	j@b.c	2013-11-16 23:32:49.323135
Public	bas453@mail.usask.ca	t	anonymous@anonymous.com	2013-11-17 05:34:09.060321
Public	t@t.com	t	anonymous@anonymous.com	2013-11-20 19:34:28.618083
Public	brady_smith87@hotmail.com	t	anonymous@anonymous.com	2013-11-23 00:21:22.651761
Public	maxgooding@gmail.com	t	anonymous@anonymous.com	2013-11-23 13:19:42.692349
Public	jasonprokop@gmail.com	t	anonymous@anonymous.com	2013-11-23 13:36:15.381557
Public	nallelcm@gmail.com	t	anonymous@anonymous.com	2013-11-24 17:27:50.724509
Test	nallelcm@gmail.com	t	nallelcm@gmail.com	2013-11-24 17:28:13.13949
Public	saeed.cs@usask.ca	t	anonymous@anonymous.com	2013-11-26 17:26:16.569212
TestUser	saeed.cs@usask.ca	t	saeed.cs@usask.ca	2013-11-26 17:49:48.39927
Public	abc@def	t	anonymous@anonymous.com	2013-11-26 17:59:13.000844
Public	abc@defa	t	anonymous@anonymous.com	2013-11-29 10:26:36.266009
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY polls (poll_id, poll_name, poll_date_created, poll_date_end, poll_active, poll_user_email, poll_group_name, poll_group_user_email) FROM stdin;
drx06	Spiky Poll #17	2013-11-14 19:20:32.297956-06	\N	t	fafmaster@hotmail.com	GROUP 04	fafmaster@hotmail.com
cfho6	key is:200 group poll	2013-11-14 20:49:03.493575-06	\N	t	fafmaster@hotmail.com	key is: 200	fafmaster@hotmail.com
r0489	Public Poll #79	2013-11-14 20:51:12.971997-06	\N	t	fafmaster@hotmail.com	Public	anonymous@anonymous.com
ht368	Entertaining Poll #78	2013-11-14 23:03:40.047526-06	\N	f	anonymous@anonymous.com	Public	anonymous@anonymous.com
twx29	Let Us Know What You Think!	2013-11-15 14:24:33.574438-06	\N	t	max@max.com	Public	anonymous@anonymous.com
ltv25	Contrary Poll #64	2013-11-15 16:03:38.40295-06	\N	t	fafmaster@hotmail.com	Public	anonymous@anonymous.com
x3489	Cats	2013-11-15 17:27:41.459115-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
dhjr4	Anxious Poll #19	2013-11-15 17:58:09.532153-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
ghp15	Cold Poll #90	2013-11-15 18:12:52.897252-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
afiln	Movies from the 80s	2013-11-16 13:09:18.48331-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
kpq45	Sparkling Poll #71	2013-11-16 17:13:53.830882-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
cdr02	Cowardly Poll #81	2013-11-14 22:19:47.021095-06	\N	f	zillionk1973@gmail.com	ATestGroup	zillionk1973@gmail.com
abcoz	Massive  Poll #15	2013-11-14 23:43:27.688402-06	\N	t	zillionk1973@gmail.com	Fan of DoctorWho!	zillionk1973@gmail.com
cuvwy	Awful Poll #23	2013-11-14 22:43:10.819589-06	\N	f	zillionk1973@gmail.com	Fan of DoctorWho!	zillionk1973@gmail.com
epq49	Fetid Poll #41	2013-11-14 19:20:06.568404-06	\N	f	fafmaster@hotmail.com	Public	anonymous@anonymous.com
iotu1	Easy Poll #44	2013-11-22 15:56:33.95549-06	\N	t	fafmaster@hotmail.com	Public	anonymous@anonymous.com
abfm7	Ornery Poll #67	2013-11-22 17:22:23.127972-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
hsv78	Ridiculous Poll #47	2013-11-22 17:34:57.269962-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
efkqt	Profound Poll #51	2013-11-14 20:55:41.042489-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
drsz1	Trekky Poll	2013-11-23 13:01:42.235697-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
bdehl	Ornery Poll #47	2013-11-24 17:30:50.531847-06	\N	t	nallelcm@gmail.com	Public	anonymous@anonymous.com
ahs67	Cheerful Poll #25	2013-11-14 23:49:49.101053-06	\N	f	anonymous@anonymous.com	Public	anonymous@anonymous.com
buvw7	Petite Poll #51	2013-11-26 17:38:25.129799-06	\N	t	saeed.cs@usask.ca	Public	anonymous@anonymous.com
afgs5	Dreadful  Poll #21	2013-11-14 23:49:04.792116-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
cq017	Greedy Poll #49	2013-11-14 23:50:20.052686-06	\N	t	anonymous@anonymous.com	Public	anonymous@anonymous.com
eoqsx	Slow Poll #10	2013-11-14 23:57:21.136445-06	\N	f	anonymous@anonymous.com	Public	anonymous@anonymous.com
amq46	Trying Poll #64	2013-11-15 01:55:52.167065-06	\N	t	j@b.c	Public	anonymous@anonymous.com
for48	Rude Poll #49	2013-11-15 13:52:03.499806-06	\N	t	max@max.com	Max's Coolest Group Ever Group	max@max.com
dtz07	Gilded Poll #29	2013-11-15 14:20:24.590169-06	\N	t	fafmaster@hotmail.com	Public	anonymous@anonymous.com
\.


--
-- Name: polls_poll_group_user_email_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('polls_poll_group_user_email_seq', 1, false);


--
-- Data for Name: possibleanswers; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY possibleanswers (panswer_question_id, panswer_panswer, panswer_id) FROM stdin;
71	yes	57
71	no	58
72	yes	59
72	no	60
74	dasd	61
74	dasdasds	62
75	das	63
75	asd	64
89	True	65
89	Very True	66
91	Very Easy	67
91	Could be improved	68
91	Quite confusing	69
91	This site is garbage	70
92	The color scheme is gross	71
92	The buttons look bad	72
92	The drop menus are a bad idea	73
92	Page layout is not easy to navigate	74
92	This site is perfect. You guys are all perfect.	75
93	Yes!	76
93	Yes, if improvements were made	77
93	Never!	79
93	Maybe, if improvements were made	78
95	smelly	80
95	funny	81
95	blessed with nice hands	82
95	not going to see this	83
96	yes	84
96	no	85
96	not really	86
96	DOGS	87
97	meow	88
97	woof	89
97	quack	90
99	Xbox	91
99	Ps4	92
100	1	93
100	2	94
102	Long tap works 	95
102	Long tap worked fine	96
103	Should could tie a cherry stem into a knot with her tongue.	97
103	She could apply lipstick with her breasts.	98
103	She could sing like an angel.	99
104	Kali	100
104	Cthulu	101
104	Buddha	102
105	blue	103
105	red	104
105	purple	105
105	calvin klein	106
105	polo	107
106	Charlie Sheen	108
106	Robert Redford	109
106	Kevin Spacey	110
106	Norm MacDonald	111
107	His whip	112
107	His whit	113
107	A colt .45	114
108	dota 	115
108	path of exile	116
112	Worf	117
112	Yar	118
113	T'Pol	119
113	Seven	120
114	Flox	121
114	Neelix	122
115	Janeway	123
115	Sisco	124
116	Crow	125
116	Pidgeon	126
116	Magpie	127
117	because they are the best..	128
117	I never picked magpie (because i dont know too much about birds)	129
118	many	130
118	much	131
120	Design	132
120	Analysis	133
120	Implementation	134
120	Testing	135
120	Documentation	136
121	PHP	137
121	ASP	138
121	Javascript	139
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY questions (question_id, question_type, question_question, question_poll_id, question_order) FROM stdin;
71	Radio	Is this is group04	epq49	1
72	Radio	Is this in group04?	drx06	1
73	Textbox	Can you see this in the proper group	cfho6	1
74	Checkbox	Testing again	r0489	1
75	Checkbox	test	efkqt	1
76	Textbox	test poll.	cdr02	1
77	Textbox	test1	cuvwy	1
78	Textbox	test2	cuvwy	2
79	Textbox	test3	cuvwy	3
80	Textbox	test	ht368	1
81	Textbox	test for active poll	abcoz	1
82	Textbox	test2	abcoz	2
83	Textbox	test	afgs5	1
84	Textbox	test2	afgs5	2
85	Textbox	test	ahs67	1
86	Textbox	test question	cq017	1
87	Textbox	test for active poll	eoqsx	1
88	Textbox	e	amq46	1
89	Radio	Max has perfect hands	for48	1
90	Textbox	tes	dtz07	1
91	Radio	How easy is WebClicker.tk to use?	twx29	1
92	Checkbox	What do you think about the theme and layout?	twx29	2
93	Radio	Would you ever use WebClicker?	twx29	3
94	Textbox	We want your comments!! good, bad, or creepy please let us know.	twx29	4
95	Checkbox	Max is...	ltv25	1
96	Radio	Do you like cats?	x3489	1
97	Radio	What sound does a cat make?	x3489	2
98	Textbox	What is your favorite thing about cats?	x3489	3
99	Radio	What is better	dhjr4	1
100	Checkbox	There is bug	dhjr4	2
101	Textbox	Yesr	ghp15	1
102	Radio	Yesr	ghp15	2
103	Radio	What special talent did Molly Ringwald have in The Breakfast Club? 	afiln	1
104	Radio	What god were the Thugees worshipping in "Indiana Jones and the Temple of Doom"? 	afiln	2
105	Checkbox	What brand and color of underwear is Marty wearing in Back to the Future?	afiln	3
106	Radio	In "Ferris Beuller's Day Off," who plays the burnout at the police station that Jeanie kisses?	afiln	4
107	Radio	What is Indiana Jones main weapon?	afiln	5
108	Checkbox	path of exile or dota	kpq45	1
109	Textbox	twertdfg	iotu1	1
110	Textbox	test	abfm7	1
111	Textbox	No responses yet	hsv78	1
112	Checkbox	Worf or Yar?	drsz1	1
113	Checkbox	T'Pol or Seven?	drsz1	2
114	Checkbox	Flox or Neelix?	drsz1	3
115	Checkbox	Janeway or Sisco	drsz1	4
116	Radio	Best Bird	bdehl	1
117	Radio	Why did you pick magpie	bdehl	2
118	Radio	How much wood would a magpie chuck if a magpie could chuck wood?	bdehl	3
119	Textbox	In 1000 words or more, tell me how awesome magpies are.	bdehl	4
120	Radio	What is the difficult job in the project?	buvw7	1
121	Checkbox	What languales do you prefer for web programming?	buvw7	2
\.


--
-- Data for Name: responses; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY responses (response_question_id, response_poll_id, response_user_email, response_id, response_response) FROM stdin;
71	epq49	anonymous@anonymous.com	35	yes
73	cfho6	zillionk1973@gmail.com	36	yes it is.
76	cdr02	fafmaster@hotmail.com	37	test
73	cfho6	j@b.c	38	yeah
88	amq46	max@max.com	39	eeeeee
89	for48	max@max.com	40	Very True
88	amq46	fafmaster@hotmail.com	41	hey whats going on
91	twx29	fafmaster@hotmail.com	42	Could be improved
92	twx29	fafmaster@hotmail.com	43	The color scheme is gross
92	twx29	fafmaster@hotmail.com	44	The buttons look bad
93	twx29	fafmaster@hotmail.com	45	Yes, if improvements were made
94	twx29	fafmaster@hotmail.com	46	I want to see a picture of a wizard
91	twx29	max@max.com	47	Could be improved
92	twx29	max@max.com	48	The color scheme is gross
92	twx29	max@max.com	49	This site is perfect. You guys are all perfect.
93	twx29	max@max.com	50	Yes, if improvements were made
94	twx29	max@max.com	51	Max has perfect hands. 
91	twx29	anonymous@anonymous.com	52	Very Easy
92	twx29	anonymous@anonymous.com	53	The drop menus are a bad idea
92	twx29	anonymous@anonymous.com	54	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	55	Never!
94	twx29	anonymous@anonymous.com	56	tigers and bears. houses and chimeneys
91	twx29	anonymous@anonymous.com	57	Very Easy
92	twx29	anonymous@anonymous.com	58	The buttons look bad
92	twx29	anonymous@anonymous.com	59	Page layout is not easy to navigate
93	twx29	anonymous@anonymous.com	60	Maybe, if improvements were made
94	twx29	anonymous@anonymous.com	61	You need to fix the ordering of the possible answers on the 3rd question of this poll
91	twx29	anonymous@anonymous.com	62	Very Easy
92	twx29	anonymous@anonymous.com	63	The drop menus are a bad idea
92	twx29	anonymous@anonymous.com	64	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	65	Never!
94	twx29	anonymous@anonymous.com	66	tigers and bears. houses and chimeneys
91	twx29	anonymous@anonymous.com	67	Very Easy
93	twx29	anonymous@anonymous.com	68	Yes!
91	twx29	anonymous@anonymous.com	69	Could be improved
92	twx29	anonymous@anonymous.com	70	The buttons look bad
93	twx29	anonymous@anonymous.com	71	Never!
94	twx29	anonymous@anonymous.com	72	YEES
95	ltv25	anonymous@anonymous.com	73	funny
95	ltv25	anonymous@anonymous.com	74	blessed with nice hands
91	twx29	anonymous@anonymous.com	75	This site is garbage
92	twx29	anonymous@anonymous.com	76	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	77	Yes!
94	twx29	anonymous@anonymous.com	78	The swipe is lagging when taking a poll through twitter
91	twx29	anonymous@anonymous.com	79	Very Easy
92	twx29	anonymous@anonymous.com	80	The color scheme is gross
93	twx29	anonymous@anonymous.com	81	Yes!
94	twx29	anonymous@anonymous.com	82	Hands are very important to programmers.
95	ltv25	anonymous@anonymous.com	83	blessed with nice hands
99	dhjr4	anonymous@anonymous.com	84	Ps4
100	dhjr4	anonymous@anonymous.com	85	2
99	dhjr4	anonymous@anonymous.com	86	Xbox
100	dhjr4	anonymous@anonymous.com	87	1
100	dhjr4	anonymous@anonymous.com	88	2
102	ghp15	anonymous@anonymous.com	89	Long tap works 
91	twx29	anonymous@anonymous.com	90	Very Easy
92	twx29	anonymous@anonymous.com	91	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	92	Yes!
94	twx29	anonymous@anonymous.com	93	You guys have no life. this must have taken 600 hours.
96	x3489	max@max.com	94	DOGS
97	x3489	max@max.com	95	woof
98	x3489	max@max.com	96	Me and cats both like naps
95	ltv25	max@max.com	97	blessed with nice hands
101	ghp15	max@max.com	98	Swiping is still pretty laggy on my iPhone. I'd vote for a server upgrade if it's cheap. This is coming together nice enough that it would be fun to work in it after the term anyways.
102	ghp15	max@max.com	99	Long tap works 
91	twx29	anonymous@anonymous.com	100	Very Easy
92	twx29	anonymous@anonymous.com	101	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	102	Yes!
101	ghp15	anonymous@anonymous.com	103	why thank you
102	ghp15	anonymous@anonymous.com	104	Long tap works 
99	dhjr4	anonymous@anonymous.com	105	Xbox
100	dhjr4	anonymous@anonymous.com	106	1
96	x3489	zillionk1973@gmail.com	107	yes
97	x3489	zillionk1973@gmail.com	108	woof
74	r0489	anonymous@anonymous.com	109	dasd
103	afiln	anonymous@anonymous.com	110	She could apply lipstick with her breasts.
104	afiln	anonymous@anonymous.com	111	Kali
105	afiln	anonymous@anonymous.com	112	purple
105	afiln	anonymous@anonymous.com	113	calvin klein
106	afiln	anonymous@anonymous.com	114	Charlie Sheen
107	afiln	anonymous@anonymous.com	115	His whip
103	afiln	anonymous@anonymous.com	116	She could apply lipstick with her breasts.
104	afiln	anonymous@anonymous.com	117	Cthulu
105	afiln	anonymous@anonymous.com	118	blue
105	afiln	anonymous@anonymous.com	119	calvin klein
106	afiln	anonymous@anonymous.com	120	Norm MacDonald
107	afiln	anonymous@anonymous.com	121	A colt .45
91	twx29	anonymous@anonymous.com	122	Very Easy
92	twx29	anonymous@anonymous.com	123	Page layout is not easy to navigate
93	twx29	anonymous@anonymous.com	124	Yes, if improvements were made
103	afiln	anonymous@anonymous.com	125	She could apply lipstick with her breasts.
104	afiln	anonymous@anonymous.com	126	Kali
105	afiln	anonymous@anonymous.com	127	blue
105	afiln	anonymous@anonymous.com	128	calvin klein
106	afiln	anonymous@anonymous.com	129	Robert Redford
107	afiln	anonymous@anonymous.com	130	His whip
103	afiln	anonymous@anonymous.com	131	Should could tie a cherry stem into a knot with her tongue.
104	afiln	anonymous@anonymous.com	132	Kali
105	afiln	anonymous@anonymous.com	133	purple
105	afiln	anonymous@anonymous.com	134	calvin klein
106	afiln	anonymous@anonymous.com	135	Charlie Sheen
107	afiln	anonymous@anonymous.com	136	His whit
103	afiln	anonymous@anonymous.com	137	Should could tie a cherry stem into a knot with her tongue.
104	afiln	anonymous@anonymous.com	138	Kali
105	afiln	anonymous@anonymous.com	139	calvin klein
106	afiln	anonymous@anonymous.com	140	Charlie Sheen
107	afiln	anonymous@anonymous.com	141	His whit
108	kpq45	anonymous@anonymous.com	142	dota 
108	kpq45	anonymous@anonymous.com	143	dota 
108	kpq45	anonymous@anonymous.com	144	path of exile
108	kpq45	anonymous@anonymous.com	145	path of exile
108	kpq45	anonymous@anonymous.com	146	path of exile
108	kpq45	anonymous@anonymous.com	147	path of exile
108	kpq45	anonymous@anonymous.com	148	path of exile
108	kpq45	anonymous@anonymous.com	149	path of exile
108	kpq45	anonymous@anonymous.com	150	path of exile
108	kpq45	anonymous@anonymous.com	151	path of exile
108	kpq45	anonymous@anonymous.com	152	path of exile
108	kpq45	anonymous@anonymous.com	153	path of exile
108	kpq45	anonymous@anonymous.com	154	path of exile
108	kpq45	anonymous@anonymous.com	155	path of exile
108	kpq45	anonymous@anonymous.com	156	path of exile
108	kpq45	anonymous@anonymous.com	157	path of exile
108	kpq45	anonymous@anonymous.com	158	path of exile
108	kpq45	anonymous@anonymous.com	159	path of exile
108	kpq45	anonymous@anonymous.com	160	path of exile
108	kpq45	anonymous@anonymous.com	161	path of exile
108	kpq45	anonymous@anonymous.com	162	path of exile
108	kpq45	anonymous@anonymous.com	163	path of exile
108	kpq45	anonymous@anonymous.com	164	path of exile
108	kpq45	anonymous@anonymous.com	165	path of exile
108	kpq45	anonymous@anonymous.com	166	path of exile
108	kpq45	anonymous@anonymous.com	167	path of exile
108	kpq45	anonymous@anonymous.com	168	path of exile
108	kpq45	anonymous@anonymous.com	169	path of exile
108	kpq45	anonymous@anonymous.com	170	path of exile
108	kpq45	anonymous@anonymous.com	171	path of exile
108	kpq45	anonymous@anonymous.com	172	path of exile
108	kpq45	anonymous@anonymous.com	173	path of exile
108	kpq45	anonymous@anonymous.com	174	path of exile
108	kpq45	anonymous@anonymous.com	175	path of exile
108	kpq45	anonymous@anonymous.com	176	path of exile
108	kpq45	anonymous@anonymous.com	177	path of exile
108	kpq45	anonymous@anonymous.com	178	path of exile
108	kpq45	anonymous@anonymous.com	179	path of exile
108	kpq45	anonymous@anonymous.com	180	path of exile
108	kpq45	anonymous@anonymous.com	181	path of exile
108	kpq45	anonymous@anonymous.com	182	path of exile
108	kpq45	anonymous@anonymous.com	183	path of exile
108	kpq45	anonymous@anonymous.com	184	path of exile
108	kpq45	anonymous@anonymous.com	185	path of exile
108	kpq45	anonymous@anonymous.com	186	path of exile
108	kpq45	anonymous@anonymous.com	187	path of exile
108	kpq45	anonymous@anonymous.com	188	path of exile
108	kpq45	anonymous@anonymous.com	189	path of exile
108	kpq45	anonymous@anonymous.com	190	path of exile
108	kpq45	anonymous@anonymous.com	191	path of exile
108	kpq45	anonymous@anonymous.com	192	path of exile
108	kpq45	anonymous@anonymous.com	193	path of exile
108	kpq45	anonymous@anonymous.com	194	path of exile
108	kpq45	anonymous@anonymous.com	195	path of exile
108	kpq45	anonymous@anonymous.com	196	path of exile
108	kpq45	anonymous@anonymous.com	197	path of exile
108	kpq45	anonymous@anonymous.com	198	path of exile
108	kpq45	anonymous@anonymous.com	199	path of exile
108	kpq45	anonymous@anonymous.com	200	path of exile
108	kpq45	anonymous@anonymous.com	201	path of exile
108	kpq45	anonymous@anonymous.com	202	path of exile
108	kpq45	anonymous@anonymous.com	203	path of exile
108	kpq45	anonymous@anonymous.com	204	path of exile
108	kpq45	anonymous@anonymous.com	205	path of exile
108	kpq45	anonymous@anonymous.com	206	path of exile
108	kpq45	anonymous@anonymous.com	207	path of exile
108	kpq45	anonymous@anonymous.com	208	path of exile
108	kpq45	anonymous@anonymous.com	209	path of exile
108	kpq45	anonymous@anonymous.com	210	path of exile
108	kpq45	anonymous@anonymous.com	211	path of exile
108	kpq45	anonymous@anonymous.com	212	path of exile
108	kpq45	anonymous@anonymous.com	213	path of exile
108	kpq45	anonymous@anonymous.com	214	path of exile
108	kpq45	anonymous@anonymous.com	215	path of exile
108	kpq45	anonymous@anonymous.com	216	path of exile
108	kpq45	anonymous@anonymous.com	217	path of exile
108	kpq45	anonymous@anonymous.com	218	path of exile
108	kpq45	anonymous@anonymous.com	219	path of exile
108	kpq45	anonymous@anonymous.com	220	path of exile
108	kpq45	anonymous@anonymous.com	221	path of exile
108	kpq45	anonymous@anonymous.com	222	path of exile
108	kpq45	anonymous@anonymous.com	223	path of exile
108	kpq45	anonymous@anonymous.com	224	path of exile
108	kpq45	anonymous@anonymous.com	225	path of exile
108	kpq45	anonymous@anonymous.com	226	path of exile
108	kpq45	anonymous@anonymous.com	227	path of exile
108	kpq45	anonymous@anonymous.com	228	path of exile
108	kpq45	anonymous@anonymous.com	229	path of exile
108	kpq45	anonymous@anonymous.com	230	path of exile
108	kpq45	anonymous@anonymous.com	231	path of exile
108	kpq45	anonymous@anonymous.com	232	path of exile
108	kpq45	anonymous@anonymous.com	233	path of exile
108	kpq45	anonymous@anonymous.com	234	path of exile
108	kpq45	anonymous@anonymous.com	235	path of exile
108	kpq45	anonymous@anonymous.com	236	path of exile
108	kpq45	anonymous@anonymous.com	237	path of exile
108	kpq45	anonymous@anonymous.com	238	path of exile
108	kpq45	anonymous@anonymous.com	239	path of exile
108	kpq45	anonymous@anonymous.com	240	path of exile
108	kpq45	anonymous@anonymous.com	241	path of exile
108	kpq45	anonymous@anonymous.com	242	path of exile
108	kpq45	anonymous@anonymous.com	243	path of exile
108	kpq45	anonymous@anonymous.com	244	path of exile
108	kpq45	anonymous@anonymous.com	245	path of exile
108	kpq45	anonymous@anonymous.com	246	path of exile
108	kpq45	anonymous@anonymous.com	247	path of exile
108	kpq45	anonymous@anonymous.com	248	path of exile
108	kpq45	anonymous@anonymous.com	249	path of exile
108	kpq45	anonymous@anonymous.com	250	path of exile
108	kpq45	anonymous@anonymous.com	251	path of exile
108	kpq45	anonymous@anonymous.com	252	path of exile
108	kpq45	anonymous@anonymous.com	253	path of exile
108	kpq45	anonymous@anonymous.com	254	path of exile
108	kpq45	anonymous@anonymous.com	255	path of exile
108	kpq45	anonymous@anonymous.com	256	path of exile
108	kpq45	anonymous@anonymous.com	257	path of exile
108	kpq45	anonymous@anonymous.com	258	path of exile
108	kpq45	anonymous@anonymous.com	259	path of exile
108	kpq45	anonymous@anonymous.com	260	path of exile
108	kpq45	anonymous@anonymous.com	261	path of exile
108	kpq45	anonymous@anonymous.com	262	path of exile
108	kpq45	anonymous@anonymous.com	263	path of exile
108	kpq45	anonymous@anonymous.com	264	path of exile
108	kpq45	anonymous@anonymous.com	265	path of exile
108	kpq45	anonymous@anonymous.com	266	path of exile
108	kpq45	anonymous@anonymous.com	267	path of exile
108	kpq45	anonymous@anonymous.com	268	path of exile
108	kpq45	anonymous@anonymous.com	269	path of exile
108	kpq45	anonymous@anonymous.com	270	path of exile
108	kpq45	anonymous@anonymous.com	271	path of exile
108	kpq45	anonymous@anonymous.com	272	path of exile
108	kpq45	anonymous@anonymous.com	273	path of exile
108	kpq45	anonymous@anonymous.com	274	path of exile
108	kpq45	anonymous@anonymous.com	275	path of exile
108	kpq45	anonymous@anonymous.com	276	path of exile
108	kpq45	anonymous@anonymous.com	277	path of exile
108	kpq45	anonymous@anonymous.com	278	path of exile
108	kpq45	anonymous@anonymous.com	279	path of exile
108	kpq45	anonymous@anonymous.com	280	path of exile
108	kpq45	anonymous@anonymous.com	281	path of exile
108	kpq45	anonymous@anonymous.com	282	path of exile
108	kpq45	anonymous@anonymous.com	283	path of exile
108	kpq45	anonymous@anonymous.com	284	path of exile
108	kpq45	anonymous@anonymous.com	285	path of exile
108	kpq45	anonymous@anonymous.com	286	path of exile
108	kpq45	anonymous@anonymous.com	287	path of exile
108	kpq45	anonymous@anonymous.com	288	path of exile
108	kpq45	anonymous@anonymous.com	289	path of exile
108	kpq45	anonymous@anonymous.com	290	path of exile
108	kpq45	anonymous@anonymous.com	291	path of exile
108	kpq45	anonymous@anonymous.com	292	path of exile
108	kpq45	anonymous@anonymous.com	293	path of exile
108	kpq45	anonymous@anonymous.com	294	path of exile
108	kpq45	anonymous@anonymous.com	295	path of exile
108	kpq45	anonymous@anonymous.com	296	path of exile
108	kpq45	anonymous@anonymous.com	297	path of exile
108	kpq45	anonymous@anonymous.com	298	path of exile
108	kpq45	anonymous@anonymous.com	299	path of exile
108	kpq45	anonymous@anonymous.com	300	path of exile
108	kpq45	anonymous@anonymous.com	301	path of exile
108	kpq45	anonymous@anonymous.com	302	path of exile
108	kpq45	anonymous@anonymous.com	303	path of exile
108	kpq45	anonymous@anonymous.com	304	path of exile
108	kpq45	anonymous@anonymous.com	305	path of exile
108	kpq45	anonymous@anonymous.com	306	path of exile
108	kpq45	anonymous@anonymous.com	307	path of exile
108	kpq45	anonymous@anonymous.com	308	path of exile
108	kpq45	anonymous@anonymous.com	309	path of exile
108	kpq45	anonymous@anonymous.com	310	path of exile
108	kpq45	anonymous@anonymous.com	311	path of exile
108	kpq45	anonymous@anonymous.com	312	path of exile
108	kpq45	anonymous@anonymous.com	313	path of exile
108	kpq45	anonymous@anonymous.com	314	path of exile
108	kpq45	anonymous@anonymous.com	315	path of exile
108	kpq45	anonymous@anonymous.com	316	path of exile
108	kpq45	anonymous@anonymous.com	317	path of exile
108	kpq45	anonymous@anonymous.com	318	path of exile
108	kpq45	anonymous@anonymous.com	319	path of exile
108	kpq45	anonymous@anonymous.com	320	path of exile
108	kpq45	anonymous@anonymous.com	321	path of exile
108	kpq45	anonymous@anonymous.com	322	path of exile
108	kpq45	anonymous@anonymous.com	323	path of exile
108	kpq45	anonymous@anonymous.com	324	path of exile
108	kpq45	anonymous@anonymous.com	325	path of exile
108	kpq45	anonymous@anonymous.com	326	path of exile
108	kpq45	anonymous@anonymous.com	327	path of exile
108	kpq45	anonymous@anonymous.com	328	path of exile
108	kpq45	anonymous@anonymous.com	329	path of exile
108	kpq45	anonymous@anonymous.com	330	path of exile
108	kpq45	anonymous@anonymous.com	331	path of exile
108	kpq45	anonymous@anonymous.com	332	path of exile
108	kpq45	anonymous@anonymous.com	333	path of exile
108	kpq45	anonymous@anonymous.com	334	path of exile
108	kpq45	anonymous@anonymous.com	335	path of exile
108	kpq45	anonymous@anonymous.com	336	path of exile
108	kpq45	anonymous@anonymous.com	337	path of exile
108	kpq45	anonymous@anonymous.com	338	path of exile
108	kpq45	anonymous@anonymous.com	339	path of exile
108	kpq45	anonymous@anonymous.com	340	path of exile
108	kpq45	anonymous@anonymous.com	341	path of exile
108	kpq45	anonymous@anonymous.com	342	path of exile
108	kpq45	anonymous@anonymous.com	343	path of exile
108	kpq45	anonymous@anonymous.com	344	path of exile
108	kpq45	anonymous@anonymous.com	345	path of exile
108	kpq45	anonymous@anonymous.com	346	path of exile
108	kpq45	anonymous@anonymous.com	347	path of exile
108	kpq45	anonymous@anonymous.com	348	path of exile
108	kpq45	anonymous@anonymous.com	349	path of exile
108	kpq45	anonymous@anonymous.com	350	path of exile
108	kpq45	anonymous@anonymous.com	351	path of exile
108	kpq45	anonymous@anonymous.com	352	path of exile
108	kpq45	anonymous@anonymous.com	353	path of exile
108	kpq45	anonymous@anonymous.com	354	path of exile
108	kpq45	anonymous@anonymous.com	355	path of exile
108	kpq45	anonymous@anonymous.com	356	path of exile
108	kpq45	anonymous@anonymous.com	357	path of exile
108	kpq45	anonymous@anonymous.com	358	path of exile
108	kpq45	anonymous@anonymous.com	359	path of exile
108	kpq45	anonymous@anonymous.com	360	path of exile
108	kpq45	anonymous@anonymous.com	361	path of exile
108	kpq45	anonymous@anonymous.com	362	path of exile
108	kpq45	anonymous@anonymous.com	363	path of exile
108	kpq45	anonymous@anonymous.com	364	path of exile
108	kpq45	anonymous@anonymous.com	365	path of exile
108	kpq45	anonymous@anonymous.com	366	path of exile
108	kpq45	anonymous@anonymous.com	367	path of exile
108	kpq45	anonymous@anonymous.com	368	path of exile
108	kpq45	anonymous@anonymous.com	369	path of exile
108	kpq45	anonymous@anonymous.com	370	path of exile
108	kpq45	anonymous@anonymous.com	371	path of exile
108	kpq45	anonymous@anonymous.com	372	path of exile
108	kpq45	anonymous@anonymous.com	373	path of exile
108	kpq45	anonymous@anonymous.com	374	path of exile
108	kpq45	anonymous@anonymous.com	375	path of exile
108	kpq45	anonymous@anonymous.com	376	path of exile
108	kpq45	anonymous@anonymous.com	377	path of exile
108	kpq45	anonymous@anonymous.com	378	path of exile
108	kpq45	anonymous@anonymous.com	379	path of exile
108	kpq45	anonymous@anonymous.com	380	path of exile
108	kpq45	anonymous@anonymous.com	381	path of exile
108	kpq45	anonymous@anonymous.com	382	path of exile
108	kpq45	anonymous@anonymous.com	383	path of exile
108	kpq45	anonymous@anonymous.com	384	path of exile
108	kpq45	anonymous@anonymous.com	385	path of exile
108	kpq45	anonymous@anonymous.com	386	path of exile
108	kpq45	anonymous@anonymous.com	387	path of exile
108	kpq45	anonymous@anonymous.com	388	path of exile
108	kpq45	anonymous@anonymous.com	389	path of exile
108	kpq45	anonymous@anonymous.com	390	path of exile
108	kpq45	anonymous@anonymous.com	391	path of exile
108	kpq45	anonymous@anonymous.com	392	path of exile
108	kpq45	anonymous@anonymous.com	393	path of exile
108	kpq45	anonymous@anonymous.com	394	path of exile
108	kpq45	anonymous@anonymous.com	395	path of exile
108	kpq45	anonymous@anonymous.com	396	path of exile
108	kpq45	anonymous@anonymous.com	397	path of exile
108	kpq45	anonymous@anonymous.com	398	path of exile
108	kpq45	anonymous@anonymous.com	399	path of exile
108	kpq45	anonymous@anonymous.com	400	path of exile
108	kpq45	anonymous@anonymous.com	401	path of exile
108	kpq45	anonymous@anonymous.com	402	path of exile
108	kpq45	anonymous@anonymous.com	403	path of exile
108	kpq45	anonymous@anonymous.com	404	path of exile
108	kpq45	anonymous@anonymous.com	405	path of exile
108	kpq45	anonymous@anonymous.com	406	path of exile
108	kpq45	anonymous@anonymous.com	407	path of exile
108	kpq45	anonymous@anonymous.com	408	path of exile
108	kpq45	anonymous@anonymous.com	409	path of exile
108	kpq45	anonymous@anonymous.com	410	path of exile
108	kpq45	anonymous@anonymous.com	411	path of exile
108	kpq45	anonymous@anonymous.com	412	path of exile
108	kpq45	anonymous@anonymous.com	413	path of exile
108	kpq45	anonymous@anonymous.com	414	path of exile
108	kpq45	anonymous@anonymous.com	415	path of exile
108	kpq45	anonymous@anonymous.com	416	path of exile
108	kpq45	anonymous@anonymous.com	417	path of exile
108	kpq45	anonymous@anonymous.com	418	path of exile
108	kpq45	anonymous@anonymous.com	419	path of exile
108	kpq45	anonymous@anonymous.com	420	path of exile
108	kpq45	anonymous@anonymous.com	421	path of exile
108	kpq45	anonymous@anonymous.com	422	path of exile
108	kpq45	anonymous@anonymous.com	423	path of exile
108	kpq45	anonymous@anonymous.com	424	path of exile
108	kpq45	anonymous@anonymous.com	425	path of exile
108	kpq45	anonymous@anonymous.com	426	path of exile
108	kpq45	anonymous@anonymous.com	427	path of exile
108	kpq45	anonymous@anonymous.com	428	path of exile
108	kpq45	anonymous@anonymous.com	429	path of exile
108	kpq45	anonymous@anonymous.com	430	path of exile
108	kpq45	anonymous@anonymous.com	431	path of exile
108	kpq45	anonymous@anonymous.com	432	path of exile
108	kpq45	anonymous@anonymous.com	433	path of exile
108	kpq45	anonymous@anonymous.com	434	path of exile
108	kpq45	anonymous@anonymous.com	435	path of exile
108	kpq45	anonymous@anonymous.com	436	path of exile
108	kpq45	anonymous@anonymous.com	437	path of exile
108	kpq45	anonymous@anonymous.com	438	path of exile
108	kpq45	anonymous@anonymous.com	439	path of exile
108	kpq45	anonymous@anonymous.com	440	path of exile
108	kpq45	anonymous@anonymous.com	441	path of exile
108	kpq45	anonymous@anonymous.com	442	path of exile
108	kpq45	anonymous@anonymous.com	443	path of exile
108	kpq45	anonymous@anonymous.com	444	path of exile
108	kpq45	anonymous@anonymous.com	445	path of exile
108	kpq45	anonymous@anonymous.com	446	path of exile
108	kpq45	anonymous@anonymous.com	447	path of exile
108	kpq45	anonymous@anonymous.com	448	path of exile
108	kpq45	anonymous@anonymous.com	449	path of exile
108	kpq45	anonymous@anonymous.com	450	path of exile
108	kpq45	anonymous@anonymous.com	451	path of exile
108	kpq45	anonymous@anonymous.com	452	path of exile
108	kpq45	anonymous@anonymous.com	453	path of exile
108	kpq45	anonymous@anonymous.com	454	path of exile
108	kpq45	anonymous@anonymous.com	455	path of exile
108	kpq45	anonymous@anonymous.com	456	path of exile
108	kpq45	anonymous@anonymous.com	457	path of exile
108	kpq45	anonymous@anonymous.com	458	path of exile
108	kpq45	anonymous@anonymous.com	459	path of exile
108	kpq45	anonymous@anonymous.com	460	path of exile
108	kpq45	anonymous@anonymous.com	461	path of exile
108	kpq45	anonymous@anonymous.com	462	path of exile
108	kpq45	anonymous@anonymous.com	463	path of exile
108	kpq45	anonymous@anonymous.com	464	path of exile
108	kpq45	anonymous@anonymous.com	465	path of exile
108	kpq45	anonymous@anonymous.com	466	path of exile
108	kpq45	anonymous@anonymous.com	467	path of exile
108	kpq45	anonymous@anonymous.com	468	path of exile
108	kpq45	anonymous@anonymous.com	469	path of exile
108	kpq45	anonymous@anonymous.com	470	path of exile
108	kpq45	anonymous@anonymous.com	471	path of exile
108	kpq45	anonymous@anonymous.com	472	path of exile
108	kpq45	anonymous@anonymous.com	473	path of exile
108	kpq45	anonymous@anonymous.com	474	path of exile
108	kpq45	anonymous@anonymous.com	475	path of exile
108	kpq45	anonymous@anonymous.com	476	path of exile
108	kpq45	anonymous@anonymous.com	477	path of exile
108	kpq45	anonymous@anonymous.com	478	path of exile
108	kpq45	anonymous@anonymous.com	479	path of exile
108	kpq45	anonymous@anonymous.com	480	path of exile
108	kpq45	anonymous@anonymous.com	481	path of exile
108	kpq45	anonymous@anonymous.com	482	path of exile
108	kpq45	anonymous@anonymous.com	483	path of exile
108	kpq45	anonymous@anonymous.com	484	path of exile
108	kpq45	anonymous@anonymous.com	485	path of exile
108	kpq45	anonymous@anonymous.com	486	path of exile
108	kpq45	anonymous@anonymous.com	487	path of exile
108	kpq45	anonymous@anonymous.com	488	path of exile
108	kpq45	anonymous@anonymous.com	489	path of exile
108	kpq45	anonymous@anonymous.com	490	path of exile
108	kpq45	anonymous@anonymous.com	491	path of exile
108	kpq45	anonymous@anonymous.com	492	path of exile
108	kpq45	anonymous@anonymous.com	493	path of exile
108	kpq45	anonymous@anonymous.com	494	path of exile
108	kpq45	anonymous@anonymous.com	495	path of exile
108	kpq45	anonymous@anonymous.com	496	path of exile
108	kpq45	anonymous@anonymous.com	497	path of exile
108	kpq45	anonymous@anonymous.com	498	path of exile
108	kpq45	anonymous@anonymous.com	499	path of exile
108	kpq45	anonymous@anonymous.com	500	path of exile
108	kpq45	anonymous@anonymous.com	501	path of exile
108	kpq45	anonymous@anonymous.com	502	path of exile
108	kpq45	anonymous@anonymous.com	503	path of exile
108	kpq45	anonymous@anonymous.com	504	path of exile
108	kpq45	anonymous@anonymous.com	505	path of exile
108	kpq45	anonymous@anonymous.com	506	path of exile
108	kpq45	anonymous@anonymous.com	507	path of exile
108	kpq45	anonymous@anonymous.com	508	path of exile
108	kpq45	anonymous@anonymous.com	509	path of exile
108	kpq45	anonymous@anonymous.com	510	path of exile
108	kpq45	anonymous@anonymous.com	511	path of exile
108	kpq45	anonymous@anonymous.com	512	path of exile
108	kpq45	anonymous@anonymous.com	513	path of exile
108	kpq45	anonymous@anonymous.com	514	path of exile
108	kpq45	anonymous@anonymous.com	515	path of exile
108	kpq45	anonymous@anonymous.com	516	path of exile
108	kpq45	anonymous@anonymous.com	517	path of exile
108	kpq45	anonymous@anonymous.com	518	path of exile
108	kpq45	anonymous@anonymous.com	519	path of exile
108	kpq45	anonymous@anonymous.com	520	path of exile
108	kpq45	anonymous@anonymous.com	521	path of exile
108	kpq45	anonymous@anonymous.com	522	path of exile
108	kpq45	anonymous@anonymous.com	523	path of exile
108	kpq45	anonymous@anonymous.com	524	path of exile
108	kpq45	anonymous@anonymous.com	525	path of exile
108	kpq45	anonymous@anonymous.com	526	path of exile
108	kpq45	anonymous@anonymous.com	527	path of exile
108	kpq45	anonymous@anonymous.com	528	path of exile
108	kpq45	anonymous@anonymous.com	529	path of exile
108	kpq45	anonymous@anonymous.com	530	path of exile
108	kpq45	anonymous@anonymous.com	531	path of exile
108	kpq45	anonymous@anonymous.com	532	path of exile
108	kpq45	anonymous@anonymous.com	533	path of exile
108	kpq45	anonymous@anonymous.com	534	path of exile
108	kpq45	anonymous@anonymous.com	535	path of exile
108	kpq45	fafmaster@hotmail.com	536	path of exile
108	kpq45	anonymous@anonymous.com	537	path of exile
108	kpq45	anonymous@anonymous.com	538	path of exile
108	kpq45	anonymous@anonymous.com	539	path of exile
108	kpq45	anonymous@anonymous.com	540	path of exile
108	kpq45	anonymous@anonymous.com	541	path of exile
108	kpq45	anonymous@anonymous.com	542	path of exile
108	kpq45	anonymous@anonymous.com	543	path of exile
108	kpq45	anonymous@anonymous.com	544	path of exile
108	kpq45	anonymous@anonymous.com	545	path of exile
108	kpq45	anonymous@anonymous.com	546	path of exile
108	kpq45	anonymous@anonymous.com	547	path of exile
108	kpq45	anonymous@anonymous.com	548	path of exile
108	kpq45	anonymous@anonymous.com	549	path of exile
108	kpq45	anonymous@anonymous.com	550	path of exile
108	kpq45	anonymous@anonymous.com	551	path of exile
108	kpq45	anonymous@anonymous.com	552	path of exile
108	kpq45	anonymous@anonymous.com	553	path of exile
108	kpq45	anonymous@anonymous.com	554	path of exile
108	kpq45	anonymous@anonymous.com	555	path of exile
108	kpq45	anonymous@anonymous.com	556	path of exile
108	kpq45	anonymous@anonymous.com	557	path of exile
108	kpq45	anonymous@anonymous.com	558	path of exile
108	kpq45	anonymous@anonymous.com	559	path of exile
108	kpq45	anonymous@anonymous.com	560	path of exile
108	kpq45	anonymous@anonymous.com	561	path of exile
108	kpq45	anonymous@anonymous.com	562	path of exile
108	kpq45	anonymous@anonymous.com	563	path of exile
108	kpq45	anonymous@anonymous.com	564	path of exile
108	kpq45	anonymous@anonymous.com	565	path of exile
108	kpq45	anonymous@anonymous.com	566	path of exile
108	kpq45	anonymous@anonymous.com	567	path of exile
108	kpq45	anonymous@anonymous.com	568	path of exile
108	kpq45	anonymous@anonymous.com	569	path of exile
108	kpq45	anonymous@anonymous.com	570	path of exile
108	kpq45	anonymous@anonymous.com	571	path of exile
108	kpq45	anonymous@anonymous.com	572	path of exile
108	kpq45	anonymous@anonymous.com	573	path of exile
108	kpq45	anonymous@anonymous.com	574	path of exile
108	kpq45	anonymous@anonymous.com	575	path of exile
108	kpq45	anonymous@anonymous.com	576	path of exile
108	kpq45	anonymous@anonymous.com	577	path of exile
108	kpq45	anonymous@anonymous.com	578	path of exile
108	kpq45	anonymous@anonymous.com	579	path of exile
108	kpq45	anonymous@anonymous.com	580	path of exile
108	kpq45	anonymous@anonymous.com	581	path of exile
108	kpq45	anonymous@anonymous.com	582	path of exile
108	kpq45	anonymous@anonymous.com	583	path of exile
108	kpq45	anonymous@anonymous.com	584	path of exile
108	kpq45	anonymous@anonymous.com	585	path of exile
108	kpq45	anonymous@anonymous.com	586	path of exile
108	kpq45	anonymous@anonymous.com	587	path of exile
108	kpq45	anonymous@anonymous.com	588	path of exile
108	kpq45	anonymous@anonymous.com	589	path of exile
108	kpq45	anonymous@anonymous.com	590	path of exile
108	kpq45	anonymous@anonymous.com	591	path of exile
108	kpq45	anonymous@anonymous.com	592	path of exile
108	kpq45	anonymous@anonymous.com	593	path of exile
108	kpq45	anonymous@anonymous.com	594	path of exile
108	kpq45	anonymous@anonymous.com	595	path of exile
108	kpq45	anonymous@anonymous.com	596	path of exile
108	kpq45	anonymous@anonymous.com	597	path of exile
108	kpq45	anonymous@anonymous.com	598	path of exile
108	kpq45	anonymous@anonymous.com	599	path of exile
108	kpq45	anonymous@anonymous.com	600	path of exile
108	kpq45	anonymous@anonymous.com	601	path of exile
108	kpq45	anonymous@anonymous.com	602	path of exile
108	kpq45	anonymous@anonymous.com	603	path of exile
108	kpq45	anonymous@anonymous.com	604	path of exile
108	kpq45	anonymous@anonymous.com	605	path of exile
108	kpq45	anonymous@anonymous.com	606	path of exile
108	kpq45	anonymous@anonymous.com	607	path of exile
108	kpq45	anonymous@anonymous.com	608	path of exile
108	kpq45	anonymous@anonymous.com	609	path of exile
108	kpq45	anonymous@anonymous.com	610	path of exile
108	kpq45	anonymous@anonymous.com	611	path of exile
108	kpq45	anonymous@anonymous.com	612	path of exile
108	kpq45	anonymous@anonymous.com	613	path of exile
108	kpq45	anonymous@anonymous.com	614	path of exile
108	kpq45	anonymous@anonymous.com	615	path of exile
108	kpq45	anonymous@anonymous.com	616	path of exile
108	kpq45	anonymous@anonymous.com	617	path of exile
108	kpq45	anonymous@anonymous.com	618	path of exile
108	kpq45	anonymous@anonymous.com	619	path of exile
108	kpq45	anonymous@anonymous.com	620	path of exile
108	kpq45	anonymous@anonymous.com	621	path of exile
108	kpq45	anonymous@anonymous.com	622	path of exile
108	kpq45	anonymous@anonymous.com	623	path of exile
108	kpq45	anonymous@anonymous.com	624	path of exile
108	kpq45	anonymous@anonymous.com	625	path of exile
108	kpq45	anonymous@anonymous.com	626	path of exile
108	kpq45	anonymous@anonymous.com	627	path of exile
108	kpq45	anonymous@anonymous.com	628	path of exile
108	kpq45	anonymous@anonymous.com	629	path of exile
108	kpq45	anonymous@anonymous.com	630	path of exile
108	kpq45	anonymous@anonymous.com	631	path of exile
108	kpq45	anonymous@anonymous.com	632	path of exile
108	kpq45	anonymous@anonymous.com	633	path of exile
108	kpq45	anonymous@anonymous.com	634	path of exile
108	kpq45	anonymous@anonymous.com	635	path of exile
108	kpq45	anonymous@anonymous.com	636	path of exile
108	kpq45	anonymous@anonymous.com	637	path of exile
108	kpq45	anonymous@anonymous.com	638	path of exile
108	kpq45	anonymous@anonymous.com	639	path of exile
108	kpq45	anonymous@anonymous.com	640	path of exile
108	kpq45	anonymous@anonymous.com	641	path of exile
108	kpq45	anonymous@anonymous.com	642	path of exile
108	kpq45	anonymous@anonymous.com	643	path of exile
108	kpq45	anonymous@anonymous.com	644	path of exile
108	kpq45	anonymous@anonymous.com	645	path of exile
108	kpq45	anonymous@anonymous.com	646	path of exile
108	kpq45	anonymous@anonymous.com	647	path of exile
108	kpq45	anonymous@anonymous.com	648	path of exile
108	kpq45	anonymous@anonymous.com	649	path of exile
108	kpq45	anonymous@anonymous.com	650	path of exile
108	kpq45	anonymous@anonymous.com	651	path of exile
108	kpq45	anonymous@anonymous.com	652	path of exile
108	kpq45	anonymous@anonymous.com	653	path of exile
108	kpq45	anonymous@anonymous.com	654	path of exile
108	kpq45	anonymous@anonymous.com	655	path of exile
108	kpq45	anonymous@anonymous.com	656	path of exile
108	kpq45	anonymous@anonymous.com	657	path of exile
108	kpq45	anonymous@anonymous.com	658	path of exile
108	kpq45	anonymous@anonymous.com	659	path of exile
108	kpq45	anonymous@anonymous.com	660	path of exile
108	kpq45	anonymous@anonymous.com	661	path of exile
108	kpq45	anonymous@anonymous.com	662	path of exile
108	kpq45	anonymous@anonymous.com	663	path of exile
108	kpq45	anonymous@anonymous.com	664	path of exile
108	kpq45	anonymous@anonymous.com	665	path of exile
108	kpq45	anonymous@anonymous.com	666	path of exile
108	kpq45	anonymous@anonymous.com	667	path of exile
108	kpq45	anonymous@anonymous.com	668	path of exile
108	kpq45	anonymous@anonymous.com	669	path of exile
108	kpq45	anonymous@anonymous.com	670	path of exile
108	kpq45	anonymous@anonymous.com	671	path of exile
108	kpq45	anonymous@anonymous.com	672	path of exile
108	kpq45	anonymous@anonymous.com	673	path of exile
108	kpq45	anonymous@anonymous.com	674	path of exile
108	kpq45	anonymous@anonymous.com	675	path of exile
108	kpq45	anonymous@anonymous.com	676	path of exile
108	kpq45	anonymous@anonymous.com	677	path of exile
108	kpq45	anonymous@anonymous.com	678	path of exile
108	kpq45	anonymous@anonymous.com	679	path of exile
108	kpq45	anonymous@anonymous.com	680	path of exile
108	kpq45	anonymous@anonymous.com	681	path of exile
108	kpq45	anonymous@anonymous.com	682	path of exile
108	kpq45	anonymous@anonymous.com	683	path of exile
108	kpq45	anonymous@anonymous.com	684	path of exile
108	kpq45	anonymous@anonymous.com	685	path of exile
108	kpq45	anonymous@anonymous.com	686	path of exile
108	kpq45	anonymous@anonymous.com	687	path of exile
108	kpq45	anonymous@anonymous.com	688	path of exile
108	kpq45	anonymous@anonymous.com	689	path of exile
108	kpq45	anonymous@anonymous.com	690	path of exile
108	kpq45	anonymous@anonymous.com	691	path of exile
108	kpq45	anonymous@anonymous.com	692	path of exile
108	kpq45	anonymous@anonymous.com	693	path of exile
108	kpq45	anonymous@anonymous.com	694	path of exile
108	kpq45	anonymous@anonymous.com	695	path of exile
108	kpq45	anonymous@anonymous.com	696	path of exile
108	kpq45	anonymous@anonymous.com	697	path of exile
108	kpq45	anonymous@anonymous.com	698	path of exile
108	kpq45	anonymous@anonymous.com	699	path of exile
108	kpq45	anonymous@anonymous.com	700	path of exile
108	kpq45	anonymous@anonymous.com	701	path of exile
108	kpq45	anonymous@anonymous.com	702	path of exile
108	kpq45	anonymous@anonymous.com	703	path of exile
108	kpq45	anonymous@anonymous.com	704	path of exile
108	kpq45	anonymous@anonymous.com	705	path of exile
108	kpq45	anonymous@anonymous.com	706	path of exile
108	kpq45	anonymous@anonymous.com	707	path of exile
108	kpq45	anonymous@anonymous.com	708	path of exile
108	kpq45	anonymous@anonymous.com	709	path of exile
108	kpq45	anonymous@anonymous.com	710	path of exile
108	kpq45	anonymous@anonymous.com	711	path of exile
108	kpq45	anonymous@anonymous.com	712	path of exile
108	kpq45	anonymous@anonymous.com	713	path of exile
108	kpq45	anonymous@anonymous.com	714	path of exile
108	kpq45	anonymous@anonymous.com	715	path of exile
108	kpq45	anonymous@anonymous.com	716	path of exile
108	kpq45	anonymous@anonymous.com	717	path of exile
108	kpq45	anonymous@anonymous.com	718	path of exile
108	kpq45	anonymous@anonymous.com	719	path of exile
108	kpq45	anonymous@anonymous.com	720	path of exile
108	kpq45	anonymous@anonymous.com	721	path of exile
108	kpq45	anonymous@anonymous.com	722	path of exile
108	kpq45	anonymous@anonymous.com	723	path of exile
108	kpq45	anonymous@anonymous.com	724	path of exile
108	kpq45	anonymous@anonymous.com	725	path of exile
108	kpq45	anonymous@anonymous.com	726	path of exile
108	kpq45	anonymous@anonymous.com	727	path of exile
108	kpq45	anonymous@anonymous.com	728	path of exile
108	kpq45	anonymous@anonymous.com	729	path of exile
108	kpq45	anonymous@anonymous.com	730	path of exile
108	kpq45	anonymous@anonymous.com	731	path of exile
108	kpq45	anonymous@anonymous.com	732	path of exile
108	kpq45	anonymous@anonymous.com	733	path of exile
108	kpq45	anonymous@anonymous.com	734	path of exile
108	kpq45	anonymous@anonymous.com	735	dota 
108	kpq45	anonymous@anonymous.com	736	path of exile
108	kpq45	anonymous@anonymous.com	737	path of exile
108	kpq45	anonymous@anonymous.com	738	dota 
108	kpq45	anonymous@anonymous.com	739	path of exile
108	kpq45	anonymous@anonymous.com	740	path of exile
108	kpq45	anonymous@anonymous.com	741	dota 
108	kpq45	anonymous@anonymous.com	742	path of exile
108	kpq45	anonymous@anonymous.com	743	path of exile
108	kpq45	anonymous@anonymous.com	744	dota 
108	kpq45	anonymous@anonymous.com	745	path of exile
108	kpq45	anonymous@anonymous.com	746	path of exile
108	kpq45	anonymous@anonymous.com	747	dota 
108	kpq45	anonymous@anonymous.com	748	path of exile
108	kpq45	anonymous@anonymous.com	749	dota 
108	kpq45	anonymous@anonymous.com	750	path of exile
108	kpq45	anonymous@anonymous.com	751	path of exile
108	kpq45	anonymous@anonymous.com	752	dota 
108	kpq45	anonymous@anonymous.com	753	path of exile
108	kpq45	anonymous@anonymous.com	754	dota 
108	kpq45	anonymous@anonymous.com	755	path of exile
108	kpq45	anonymous@anonymous.com	756	path of exile
108	kpq45	anonymous@anonymous.com	757	path of exile
108	kpq45	anonymous@anonymous.com	758	dota 
108	kpq45	anonymous@anonymous.com	759	path of exile
108	kpq45	anonymous@anonymous.com	760	path of exile
108	kpq45	anonymous@anonymous.com	761	dota 
108	kpq45	anonymous@anonymous.com	762	path of exile
108	kpq45	anonymous@anonymous.com	763	dota 
108	kpq45	anonymous@anonymous.com	764	path of exile
108	kpq45	anonymous@anonymous.com	765	path of exile
108	kpq45	anonymous@anonymous.com	766	path of exile
108	kpq45	anonymous@anonymous.com	767	dota 
108	kpq45	anonymous@anonymous.com	768	path of exile
108	kpq45	anonymous@anonymous.com	769	dota 
108	kpq45	anonymous@anonymous.com	770	path of exile
108	kpq45	anonymous@anonymous.com	771	path of exile
108	kpq45	anonymous@anonymous.com	772	dota 
108	kpq45	anonymous@anonymous.com	773	path of exile
108	kpq45	anonymous@anonymous.com	774	path of exile
108	kpq45	anonymous@anonymous.com	775	dota 
108	kpq45	anonymous@anonymous.com	776	path of exile
108	kpq45	anonymous@anonymous.com	777	path of exile
108	kpq45	anonymous@anonymous.com	778	dota 
108	kpq45	anonymous@anonymous.com	779	path of exile
108	kpq45	anonymous@anonymous.com	780	dota 
108	kpq45	anonymous@anonymous.com	781	path of exile
108	kpq45	anonymous@anonymous.com	782	path of exile
108	kpq45	anonymous@anonymous.com	783	dota 
108	kpq45	anonymous@anonymous.com	784	path of exile
108	kpq45	anonymous@anonymous.com	785	path of exile
108	kpq45	anonymous@anonymous.com	786	dota 
108	kpq45	anonymous@anonymous.com	787	path of exile
108	kpq45	anonymous@anonymous.com	788	dota 
108	kpq45	anonymous@anonymous.com	789	path of exile
108	kpq45	anonymous@anonymous.com	790	path of exile
108	kpq45	anonymous@anonymous.com	791	dota 
108	kpq45	anonymous@anonymous.com	792	path of exile
108	kpq45	anonymous@anonymous.com	793	dota 
108	kpq45	anonymous@anonymous.com	794	path of exile
108	kpq45	anonymous@anonymous.com	795	dota 
108	kpq45	anonymous@anonymous.com	796	path of exile
108	kpq45	anonymous@anonymous.com	797	path of exile
108	kpq45	anonymous@anonymous.com	798	path of exile
108	kpq45	anonymous@anonymous.com	799	dota 
108	kpq45	anonymous@anonymous.com	800	path of exile
108	kpq45	anonymous@anonymous.com	801	dota 
108	kpq45	anonymous@anonymous.com	802	path of exile
108	kpq45	anonymous@anonymous.com	803	path of exile
108	kpq45	anonymous@anonymous.com	804	dota 
108	kpq45	anonymous@anonymous.com	805	path of exile
108	kpq45	anonymous@anonymous.com	806	dota 
108	kpq45	anonymous@anonymous.com	807	path of exile
108	kpq45	anonymous@anonymous.com	808	path of exile
108	kpq45	anonymous@anonymous.com	809	dota 
108	kpq45	anonymous@anonymous.com	810	path of exile
108	kpq45	anonymous@anonymous.com	811	dota 
108	kpq45	anonymous@anonymous.com	812	path of exile
108	kpq45	anonymous@anonymous.com	813	path of exile
108	kpq45	anonymous@anonymous.com	814	dota 
108	kpq45	anonymous@anonymous.com	815	path of exile
108	kpq45	anonymous@anonymous.com	816	dota 
108	kpq45	anonymous@anonymous.com	817	path of exile
108	kpq45	anonymous@anonymous.com	818	dota 
108	kpq45	anonymous@anonymous.com	819	path of exile
108	kpq45	anonymous@anonymous.com	820	path of exile
108	kpq45	anonymous@anonymous.com	821	dota 
108	kpq45	anonymous@anonymous.com	822	path of exile
108	kpq45	anonymous@anonymous.com	823	path of exile
108	kpq45	anonymous@anonymous.com	824	dota 
108	kpq45	anonymous@anonymous.com	825	path of exile
108	kpq45	anonymous@anonymous.com	826	path of exile
108	kpq45	anonymous@anonymous.com	827	dota 
108	kpq45	anonymous@anonymous.com	828	path of exile
108	kpq45	anonymous@anonymous.com	829	dota 
108	kpq45	anonymous@anonymous.com	830	path of exile
108	kpq45	anonymous@anonymous.com	831	path of exile
108	kpq45	anonymous@anonymous.com	832	dota 
108	kpq45	anonymous@anonymous.com	833	path of exile
108	kpq45	anonymous@anonymous.com	834	dota 
108	kpq45	anonymous@anonymous.com	835	path of exile
108	kpq45	anonymous@anonymous.com	836	dota 
108	kpq45	anonymous@anonymous.com	837	path of exile
108	kpq45	anonymous@anonymous.com	838	path of exile
108	kpq45	anonymous@anonymous.com	839	dota 
108	kpq45	anonymous@anonymous.com	840	path of exile
108	kpq45	anonymous@anonymous.com	841	dota 
108	kpq45	anonymous@anonymous.com	842	path of exile
108	kpq45	anonymous@anonymous.com	843	path of exile
108	kpq45	anonymous@anonymous.com	844	dota 
108	kpq45	anonymous@anonymous.com	845	path of exile
108	kpq45	anonymous@anonymous.com	846	dota 
108	kpq45	anonymous@anonymous.com	847	path of exile
108	kpq45	anonymous@anonymous.com	848	path of exile
108	kpq45	anonymous@anonymous.com	849	path of exile
108	kpq45	anonymous@anonymous.com	850	path of exile
108	kpq45	anonymous@anonymous.com	851	dota 
108	kpq45	anonymous@anonymous.com	852	path of exile
108	kpq45	anonymous@anonymous.com	853	path of exile
108	kpq45	anonymous@anonymous.com	854	dota 
108	kpq45	anonymous@anonymous.com	855	path of exile
108	kpq45	anonymous@anonymous.com	856	dota 
108	kpq45	anonymous@anonymous.com	857	path of exile
108	kpq45	anonymous@anonymous.com	858	dota 
108	kpq45	anonymous@anonymous.com	859	path of exile
108	kpq45	anonymous@anonymous.com	860	path of exile
108	kpq45	anonymous@anonymous.com	861	dota 
108	kpq45	anonymous@anonymous.com	862	path of exile
108	kpq45	anonymous@anonymous.com	863	dota 
108	kpq45	anonymous@anonymous.com	864	path of exile
108	kpq45	anonymous@anonymous.com	865	dota 
108	kpq45	anonymous@anonymous.com	866	path of exile
108	kpq45	anonymous@anonymous.com	867	path of exile
108	kpq45	anonymous@anonymous.com	868	path of exile
108	kpq45	anonymous@anonymous.com	869	dota 
108	kpq45	anonymous@anonymous.com	870	path of exile
108	kpq45	anonymous@anonymous.com	871	path of exile
108	kpq45	anonymous@anonymous.com	872	dota 
108	kpq45	anonymous@anonymous.com	873	path of exile
108	kpq45	anonymous@anonymous.com	874	path of exile
108	kpq45	anonymous@anonymous.com	875	dota 
108	kpq45	anonymous@anonymous.com	876	path of exile
108	kpq45	anonymous@anonymous.com	877	path of exile
108	kpq45	anonymous@anonymous.com	878	dota 
108	kpq45	anonymous@anonymous.com	879	path of exile
108	kpq45	anonymous@anonymous.com	880	path of exile
108	kpq45	anonymous@anonymous.com	881	dota 
108	kpq45	anonymous@anonymous.com	882	path of exile
108	kpq45	anonymous@anonymous.com	883	path of exile
108	kpq45	anonymous@anonymous.com	884	dota 
108	kpq45	anonymous@anonymous.com	885	path of exile
108	kpq45	anonymous@anonymous.com	886	dota 
108	kpq45	anonymous@anonymous.com	887	path of exile
108	kpq45	anonymous@anonymous.com	888	path of exile
108	kpq45	anonymous@anonymous.com	889	dota 
108	kpq45	anonymous@anonymous.com	890	path of exile
108	kpq45	anonymous@anonymous.com	891	dota 
108	kpq45	anonymous@anonymous.com	892	path of exile
108	kpq45	anonymous@anonymous.com	893	path of exile
108	kpq45	anonymous@anonymous.com	894	dota 
108	kpq45	anonymous@anonymous.com	895	path of exile
108	kpq45	anonymous@anonymous.com	896	path of exile
108	kpq45	anonymous@anonymous.com	897	dota 
108	kpq45	anonymous@anonymous.com	898	path of exile
108	kpq45	anonymous@anonymous.com	899	dota 
108	kpq45	anonymous@anonymous.com	900	path of exile
108	kpq45	anonymous@anonymous.com	901	dota 
108	kpq45	anonymous@anonymous.com	902	path of exile
108	kpq45	anonymous@anonymous.com	903	dota 
108	kpq45	anonymous@anonymous.com	904	path of exile
108	kpq45	anonymous@anonymous.com	905	path of exile
108	kpq45	anonymous@anonymous.com	906	dota 
108	kpq45	anonymous@anonymous.com	907	path of exile
108	kpq45	anonymous@anonymous.com	908	path of exile
108	kpq45	anonymous@anonymous.com	909	dota 
108	kpq45	anonymous@anonymous.com	910	path of exile
108	kpq45	anonymous@anonymous.com	911	path of exile
108	kpq45	anonymous@anonymous.com	912	dota 
108	kpq45	anonymous@anonymous.com	913	path of exile
108	kpq45	anonymous@anonymous.com	914	path of exile
108	kpq45	anonymous@anonymous.com	915	dota 
108	kpq45	anonymous@anonymous.com	916	path of exile
108	kpq45	anonymous@anonymous.com	917	path of exile
108	kpq45	anonymous@anonymous.com	918	dota 
108	kpq45	anonymous@anonymous.com	919	path of exile
108	kpq45	anonymous@anonymous.com	920	dota 
108	kpq45	anonymous@anonymous.com	921	path of exile
108	kpq45	anonymous@anonymous.com	922	path of exile
108	kpq45	anonymous@anonymous.com	923	dota 
108	kpq45	anonymous@anonymous.com	924	path of exile
108	kpq45	anonymous@anonymous.com	925	dota 
108	kpq45	anonymous@anonymous.com	926	path of exile
108	kpq45	anonymous@anonymous.com	927	path of exile
108	kpq45	anonymous@anonymous.com	928	dota 
108	kpq45	anonymous@anonymous.com	929	path of exile
108	kpq45	anonymous@anonymous.com	930	path of exile
108	kpq45	anonymous@anonymous.com	931	dota 
108	kpq45	anonymous@anonymous.com	932	path of exile
108	kpq45	anonymous@anonymous.com	933	path of exile
108	kpq45	anonymous@anonymous.com	934	dota 
108	kpq45	anonymous@anonymous.com	935	path of exile
108	kpq45	anonymous@anonymous.com	936	path of exile
108	kpq45	anonymous@anonymous.com	937	dota 
108	kpq45	anonymous@anonymous.com	938	path of exile
108	kpq45	anonymous@anonymous.com	939	dota 
108	kpq45	anonymous@anonymous.com	940	path of exile
108	kpq45	anonymous@anonymous.com	941	path of exile
108	kpq45	anonymous@anonymous.com	942	dota 
108	kpq45	anonymous@anonymous.com	943	path of exile
108	kpq45	anonymous@anonymous.com	944	dota 
108	kpq45	anonymous@anonymous.com	945	path of exile
108	kpq45	anonymous@anonymous.com	946	path of exile
108	kpq45	anonymous@anonymous.com	947	dota 
108	kpq45	anonymous@anonymous.com	948	path of exile
108	kpq45	anonymous@anonymous.com	949	path of exile
108	kpq45	anonymous@anonymous.com	950	dota 
108	kpq45	anonymous@anonymous.com	951	path of exile
108	kpq45	anonymous@anonymous.com	952	dota 
108	kpq45	anonymous@anonymous.com	953	path of exile
108	kpq45	anonymous@anonymous.com	954	dota 
108	kpq45	anonymous@anonymous.com	955	path of exile
108	kpq45	anonymous@anonymous.com	956	path of exile
108	kpq45	anonymous@anonymous.com	957	dota 
108	kpq45	anonymous@anonymous.com	958	path of exile
108	kpq45	anonymous@anonymous.com	959	dota 
108	kpq45	anonymous@anonymous.com	960	path of exile
108	kpq45	anonymous@anonymous.com	961	path of exile
108	kpq45	anonymous@anonymous.com	962	dota 
108	kpq45	anonymous@anonymous.com	963	path of exile
108	kpq45	anonymous@anonymous.com	964	path of exile
108	kpq45	anonymous@anonymous.com	965	dota 
108	kpq45	anonymous@anonymous.com	966	path of exile
108	kpq45	anonymous@anonymous.com	967	dota 
108	kpq45	anonymous@anonymous.com	968	path of exile
108	kpq45	anonymous@anonymous.com	969	dota 
108	kpq45	anonymous@anonymous.com	970	path of exile
108	kpq45	anonymous@anonymous.com	971	dota 
108	kpq45	anonymous@anonymous.com	972	path of exile
108	kpq45	anonymous@anonymous.com	973	dota 
108	kpq45	anonymous@anonymous.com	974	path of exile
108	kpq45	anonymous@anonymous.com	975	dota 
108	kpq45	anonymous@anonymous.com	976	path of exile
108	kpq45	anonymous@anonymous.com	977	dota 
108	kpq45	anonymous@anonymous.com	978	path of exile
108	kpq45	anonymous@anonymous.com	979	dota 
108	kpq45	anonymous@anonymous.com	980	path of exile
108	kpq45	anonymous@anonymous.com	981	dota 
108	kpq45	anonymous@anonymous.com	982	path of exile
108	kpq45	anonymous@anonymous.com	983	dota 
108	kpq45	anonymous@anonymous.com	984	path of exile
108	kpq45	anonymous@anonymous.com	985	dota 
108	kpq45	anonymous@anonymous.com	986	path of exile
108	kpq45	anonymous@anonymous.com	987	dota 
108	kpq45	anonymous@anonymous.com	988	path of exile
108	kpq45	anonymous@anonymous.com	989	dota 
108	kpq45	anonymous@anonymous.com	990	path of exile
108	kpq45	anonymous@anonymous.com	991	dota 
108	kpq45	anonymous@anonymous.com	992	path of exile
108	kpq45	anonymous@anonymous.com	993	dota 
108	kpq45	anonymous@anonymous.com	994	path of exile
108	kpq45	anonymous@anonymous.com	995	dota 
108	kpq45	anonymous@anonymous.com	996	path of exile
108	kpq45	anonymous@anonymous.com	997	dota 
108	kpq45	anonymous@anonymous.com	998	path of exile
108	kpq45	anonymous@anonymous.com	999	dota 
108	kpq45	anonymous@anonymous.com	1000	path of exile
108	kpq45	anonymous@anonymous.com	1001	dota 
108	kpq45	anonymous@anonymous.com	1002	path of exile
108	kpq45	anonymous@anonymous.com	1003	dota 
108	kpq45	anonymous@anonymous.com	1004	path of exile
108	kpq45	anonymous@anonymous.com	1005	dota 
108	kpq45	anonymous@anonymous.com	1006	path of exile
108	kpq45	anonymous@anonymous.com	1007	dota 
108	kpq45	anonymous@anonymous.com	1008	path of exile
108	kpq45	anonymous@anonymous.com	1009	dota 
108	kpq45	anonymous@anonymous.com	1010	path of exile
108	kpq45	anonymous@anonymous.com	1011	path of exile
108	kpq45	anonymous@anonymous.com	1012	path of exile
108	kpq45	anonymous@anonymous.com	1013	path of exile
108	kpq45	anonymous@anonymous.com	1014	path of exile
108	kpq45	anonymous@anonymous.com	1015	path of exile
108	kpq45	anonymous@anonymous.com	1016	path of exile
108	kpq45	anonymous@anonymous.com	1017	path of exile
108	kpq45	anonymous@anonymous.com	1018	path of exile
108	kpq45	anonymous@anonymous.com	1019	path of exile
108	kpq45	anonymous@anonymous.com	1020	path of exile
108	kpq45	anonymous@anonymous.com	1021	path of exile
108	kpq45	anonymous@anonymous.com	1022	path of exile
108	kpq45	anonymous@anonymous.com	1023	path of exile
108	kpq45	anonymous@anonymous.com	1024	path of exile
108	kpq45	anonymous@anonymous.com	1025	path of exile
108	kpq45	anonymous@anonymous.com	1026	path of exile
108	kpq45	anonymous@anonymous.com	1027	dota 
108	kpq45	anonymous@anonymous.com	1028	path of exile
108	kpq45	anonymous@anonymous.com	1029	dota 
108	kpq45	anonymous@anonymous.com	1030	path of exile
108	kpq45	anonymous@anonymous.com	1031	dota 
108	kpq45	anonymous@anonymous.com	1032	path of exile
108	kpq45	anonymous@anonymous.com	1033	dota 
108	kpq45	anonymous@anonymous.com	1034	path of exile
108	kpq45	anonymous@anonymous.com	1035	dota 
108	kpq45	anonymous@anonymous.com	1036	path of exile
108	kpq45	anonymous@anonymous.com	1037	dota 
108	kpq45	anonymous@anonymous.com	1038	path of exile
108	kpq45	anonymous@anonymous.com	1039	dota 
108	kpq45	anonymous@anonymous.com	1040	path of exile
108	kpq45	anonymous@anonymous.com	1041	dota 
108	kpq45	anonymous@anonymous.com	1042	path of exile
108	kpq45	anonymous@anonymous.com	1043	dota 
108	kpq45	anonymous@anonymous.com	1044	path of exile
108	kpq45	anonymous@anonymous.com	1045	dota 
108	kpq45	anonymous@anonymous.com	1046	path of exile
108	kpq45	anonymous@anonymous.com	1047	dota 
108	kpq45	anonymous@anonymous.com	1048	path of exile
108	kpq45	anonymous@anonymous.com	1049	dota 
108	kpq45	anonymous@anonymous.com	1050	path of exile
108	kpq45	anonymous@anonymous.com	1051	dota 
108	kpq45	anonymous@anonymous.com	1052	path of exile
108	kpq45	anonymous@anonymous.com	1053	dota 
108	kpq45	anonymous@anonymous.com	1054	path of exile
108	kpq45	anonymous@anonymous.com	1055	dota 
108	kpq45	anonymous@anonymous.com	1056	path of exile
108	kpq45	anonymous@anonymous.com	1057	dota 
108	kpq45	anonymous@anonymous.com	1058	path of exile
108	kpq45	anonymous@anonymous.com	1059	dota 
108	kpq45	anonymous@anonymous.com	1060	path of exile
108	kpq45	anonymous@anonymous.com	1061	dota 
108	kpq45	anonymous@anonymous.com	1062	path of exile
108	kpq45	anonymous@anonymous.com	1063	dota 
108	kpq45	anonymous@anonymous.com	1064	path of exile
108	kpq45	anonymous@anonymous.com	1065	dota 
108	kpq45	anonymous@anonymous.com	1066	path of exile
108	kpq45	anonymous@anonymous.com	1067	dota 
108	kpq45	anonymous@anonymous.com	1068	path of exile
108	kpq45	anonymous@anonymous.com	1069	dota 
108	kpq45	anonymous@anonymous.com	1070	path of exile
108	kpq45	anonymous@anonymous.com	1071	dota 
108	kpq45	anonymous@anonymous.com	1072	path of exile
108	kpq45	anonymous@anonymous.com	1073	dota 
108	kpq45	anonymous@anonymous.com	1074	path of exile
108	kpq45	anonymous@anonymous.com	1075	dota 
108	kpq45	anonymous@anonymous.com	1076	path of exile
108	kpq45	anonymous@anonymous.com	1077	dota 
108	kpq45	anonymous@anonymous.com	1078	path of exile
108	kpq45	anonymous@anonymous.com	1079	dota 
108	kpq45	anonymous@anonymous.com	1080	path of exile
108	kpq45	anonymous@anonymous.com	1081	dota 
108	kpq45	anonymous@anonymous.com	1082	path of exile
108	kpq45	anonymous@anonymous.com	1083	dota 
108	kpq45	anonymous@anonymous.com	1084	path of exile
108	kpq45	anonymous@anonymous.com	1085	dota 
108	kpq45	anonymous@anonymous.com	1086	path of exile
108	kpq45	anonymous@anonymous.com	1087	dota 
108	kpq45	anonymous@anonymous.com	1088	path of exile
108	kpq45	anonymous@anonymous.com	1089	dota 
108	kpq45	anonymous@anonymous.com	1090	path of exile
108	kpq45	anonymous@anonymous.com	1091	dota 
108	kpq45	anonymous@anonymous.com	1092	path of exile
108	kpq45	anonymous@anonymous.com	1093	dota 
108	kpq45	anonymous@anonymous.com	1094	path of exile
108	kpq45	anonymous@anonymous.com	1095	dota 
108	kpq45	anonymous@anonymous.com	1096	path of exile
108	kpq45	anonymous@anonymous.com	1097	path of exile
108	kpq45	anonymous@anonymous.com	1098	dota 
108	kpq45	anonymous@anonymous.com	1099	path of exile
108	kpq45	anonymous@anonymous.com	1100	dota 
108	kpq45	anonymous@anonymous.com	1101	path of exile
108	kpq45	anonymous@anonymous.com	1102	dota 
108	kpq45	anonymous@anonymous.com	1103	path of exile
108	kpq45	anonymous@anonymous.com	1104	dota 
108	kpq45	anonymous@anonymous.com	1105	path of exile
108	kpq45	anonymous@anonymous.com	1106	dota 
108	kpq45	anonymous@anonymous.com	1107	path of exile
108	kpq45	anonymous@anonymous.com	1108	dota 
108	kpq45	anonymous@anonymous.com	1109	path of exile
108	kpq45	anonymous@anonymous.com	1110	dota 
108	kpq45	anonymous@anonymous.com	1111	path of exile
108	kpq45	anonymous@anonymous.com	1112	dota 
108	kpq45	anonymous@anonymous.com	1113	path of exile
108	kpq45	anonymous@anonymous.com	1114	dota 
108	kpq45	anonymous@anonymous.com	1115	path of exile
108	kpq45	anonymous@anonymous.com	1116	dota 
108	kpq45	anonymous@anonymous.com	1117	path of exile
108	kpq45	anonymous@anonymous.com	1118	dota 
108	kpq45	anonymous@anonymous.com	1119	path of exile
108	kpq45	anonymous@anonymous.com	1120	dota 
108	kpq45	anonymous@anonymous.com	1121	path of exile
108	kpq45	anonymous@anonymous.com	1122	dota 
108	kpq45	anonymous@anonymous.com	1123	path of exile
108	kpq45	anonymous@anonymous.com	1124	dota 
108	kpq45	anonymous@anonymous.com	1125	path of exile
108	kpq45	anonymous@anonymous.com	1126	dota 
108	kpq45	anonymous@anonymous.com	1127	path of exile
108	kpq45	anonymous@anonymous.com	1128	dota 
108	kpq45	anonymous@anonymous.com	1129	path of exile
108	kpq45	anonymous@anonymous.com	1130	dota 
108	kpq45	anonymous@anonymous.com	1131	path of exile
108	kpq45	anonymous@anonymous.com	1132	dota 
108	kpq45	anonymous@anonymous.com	1133	path of exile
108	kpq45	anonymous@anonymous.com	1134	path of exile
108	kpq45	anonymous@anonymous.com	1135	dota 
108	kpq45	anonymous@anonymous.com	1136	path of exile
108	kpq45	anonymous@anonymous.com	1137	dota 
108	kpq45	anonymous@anonymous.com	1138	path of exile
108	kpq45	anonymous@anonymous.com	1139	path of exile
108	kpq45	anonymous@anonymous.com	1140	dota 
108	kpq45	anonymous@anonymous.com	1141	path of exile
108	kpq45	anonymous@anonymous.com	1142	dota 
108	kpq45	anonymous@anonymous.com	1143	path of exile
108	kpq45	anonymous@anonymous.com	1144	path of exile
108	kpq45	anonymous@anonymous.com	1145	dota 
108	kpq45	anonymous@anonymous.com	1146	path of exile
108	kpq45	anonymous@anonymous.com	1147	dota 
108	kpq45	anonymous@anonymous.com	1148	path of exile
108	kpq45	anonymous@anonymous.com	1149	path of exile
108	kpq45	anonymous@anonymous.com	1150	dota 
108	kpq45	anonymous@anonymous.com	1151	path of exile
108	kpq45	anonymous@anonymous.com	1152	path of exile
108	kpq45	anonymous@anonymous.com	1153	dota 
108	kpq45	anonymous@anonymous.com	1154	path of exile
108	kpq45	anonymous@anonymous.com	1155	dota 
108	kpq45	anonymous@anonymous.com	1156	path of exile
108	kpq45	anonymous@anonymous.com	1157	path of exile
108	kpq45	anonymous@anonymous.com	1158	dota 
108	kpq45	anonymous@anonymous.com	1159	path of exile
108	kpq45	anonymous@anonymous.com	1160	path of exile
108	kpq45	anonymous@anonymous.com	1161	dota 
108	kpq45	anonymous@anonymous.com	1162	path of exile
108	kpq45	anonymous@anonymous.com	1163	dota 
108	kpq45	anonymous@anonymous.com	1164	path of exile
108	kpq45	anonymous@anonymous.com	1165	path of exile
108	kpq45	anonymous@anonymous.com	1166	dota 
108	kpq45	anonymous@anonymous.com	1167	path of exile
108	kpq45	anonymous@anonymous.com	1168	dota 
108	kpq45	anonymous@anonymous.com	1169	path of exile
108	kpq45	anonymous@anonymous.com	1170	path of exile
108	kpq45	anonymous@anonymous.com	1171	dota 
108	kpq45	anonymous@anonymous.com	1172	path of exile
108	kpq45	anonymous@anonymous.com	1173	path of exile
108	kpq45	anonymous@anonymous.com	1174	dota 
108	kpq45	anonymous@anonymous.com	1175	path of exile
108	kpq45	anonymous@anonymous.com	1176	dota 
108	kpq45	anonymous@anonymous.com	1177	path of exile
108	kpq45	anonymous@anonymous.com	1178	path of exile
108	kpq45	anonymous@anonymous.com	1179	dota 
108	kpq45	anonymous@anonymous.com	1180	path of exile
108	kpq45	anonymous@anonymous.com	1181	path of exile
108	kpq45	anonymous@anonymous.com	1182	dota 
108	kpq45	anonymous@anonymous.com	1183	path of exile
108	kpq45	anonymous@anonymous.com	1184	dota 
108	kpq45	anonymous@anonymous.com	1185	path of exile
108	kpq45	anonymous@anonymous.com	1186	path of exile
108	kpq45	anonymous@anonymous.com	1187	dota 
108	kpq45	anonymous@anonymous.com	1188	path of exile
108	kpq45	anonymous@anonymous.com	1189	dota 
108	kpq45	anonymous@anonymous.com	1190	path of exile
108	kpq45	anonymous@anonymous.com	1191	path of exile
108	kpq45	anonymous@anonymous.com	1192	dota 
108	kpq45	anonymous@anonymous.com	1193	path of exile
108	kpq45	anonymous@anonymous.com	1194	dota 
108	kpq45	anonymous@anonymous.com	1195	path of exile
108	kpq45	anonymous@anonymous.com	1196	path of exile
108	kpq45	anonymous@anonymous.com	1197	dota 
108	kpq45	anonymous@anonymous.com	1198	path of exile
108	kpq45	anonymous@anonymous.com	1199	dota 
108	kpq45	anonymous@anonymous.com	1200	path of exile
108	kpq45	anonymous@anonymous.com	1201	path of exile
108	kpq45	anonymous@anonymous.com	1202	dota 
108	kpq45	anonymous@anonymous.com	1203	path of exile
108	kpq45	anonymous@anonymous.com	1204	path of exile
108	kpq45	anonymous@anonymous.com	1205	dota 
108	kpq45	anonymous@anonymous.com	1206	path of exile
108	kpq45	anonymous@anonymous.com	1207	dota 
108	kpq45	anonymous@anonymous.com	1208	path of exile
108	kpq45	anonymous@anonymous.com	1209	path of exile
108	kpq45	anonymous@anonymous.com	1210	dota 
108	kpq45	anonymous@anonymous.com	1211	path of exile
108	kpq45	anonymous@anonymous.com	1212	path of exile
108	kpq45	anonymous@anonymous.com	1213	dota 
108	kpq45	anonymous@anonymous.com	1214	path of exile
108	kpq45	anonymous@anonymous.com	1215	dota 
108	kpq45	anonymous@anonymous.com	1216	path of exile
108	kpq45	anonymous@anonymous.com	1217	path of exile
108	kpq45	anonymous@anonymous.com	1218	dota 
108	kpq45	anonymous@anonymous.com	1219	path of exile
108	kpq45	anonymous@anonymous.com	1220	dota 
108	kpq45	anonymous@anonymous.com	1221	path of exile
108	kpq45	anonymous@anonymous.com	1222	path of exile
108	kpq45	anonymous@anonymous.com	1223	dota 
108	kpq45	anonymous@anonymous.com	1224	path of exile
108	kpq45	anonymous@anonymous.com	1225	dota 
108	kpq45	anonymous@anonymous.com	1226	path of exile
108	kpq45	anonymous@anonymous.com	1227	path of exile
108	kpq45	anonymous@anonymous.com	1228	dota 
108	kpq45	anonymous@anonymous.com	1229	path of exile
108	kpq45	anonymous@anonymous.com	1230	path of exile
108	kpq45	anonymous@anonymous.com	1231	dota 
108	kpq45	anonymous@anonymous.com	1232	path of exile
108	kpq45	anonymous@anonymous.com	1233	dota 
108	kpq45	anonymous@anonymous.com	1234	path of exile
108	kpq45	anonymous@anonymous.com	1235	path of exile
108	kpq45	anonymous@anonymous.com	1236	dota 
108	kpq45	anonymous@anonymous.com	1237	path of exile
108	kpq45	anonymous@anonymous.com	1238	dota 
108	kpq45	anonymous@anonymous.com	1239	path of exile
108	kpq45	anonymous@anonymous.com	1240	path of exile
108	kpq45	anonymous@anonymous.com	1241	dota 
108	kpq45	anonymous@anonymous.com	1242	path of exile
108	kpq45	anonymous@anonymous.com	1243	path of exile
108	kpq45	anonymous@anonymous.com	1244	dota 
108	kpq45	anonymous@anonymous.com	1245	path of exile
108	kpq45	anonymous@anonymous.com	1246	path of exile
108	kpq45	anonymous@anonymous.com	1247	dota 
108	kpq45	anonymous@anonymous.com	1248	path of exile
108	kpq45	anonymous@anonymous.com	1249	dota 
108	kpq45	anonymous@anonymous.com	1250	path of exile
108	kpq45	anonymous@anonymous.com	1251	dota 
108	kpq45	anonymous@anonymous.com	1252	path of exile
108	kpq45	anonymous@anonymous.com	1253	path of exile
108	kpq45	anonymous@anonymous.com	1254	dota 
108	kpq45	anonymous@anonymous.com	1255	path of exile
108	kpq45	anonymous@anonymous.com	1256	path of exile
108	kpq45	anonymous@anonymous.com	1257	dota 
108	kpq45	anonymous@anonymous.com	1258	path of exile
108	kpq45	anonymous@anonymous.com	1259	dota 
108	kpq45	anonymous@anonymous.com	1260	path of exile
108	kpq45	anonymous@anonymous.com	1261	path of exile
108	kpq45	anonymous@anonymous.com	1262	dota 
108	kpq45	anonymous@anonymous.com	1263	path of exile
108	kpq45	anonymous@anonymous.com	1264	dota 
108	kpq45	anonymous@anonymous.com	1265	path of exile
108	kpq45	anonymous@anonymous.com	1266	path of exile
108	kpq45	anonymous@anonymous.com	1267	dota 
108	kpq45	anonymous@anonymous.com	1268	path of exile
108	kpq45	anonymous@anonymous.com	1269	path of exile
108	kpq45	anonymous@anonymous.com	1270	dota 
108	kpq45	anonymous@anonymous.com	1271	path of exile
108	kpq45	anonymous@anonymous.com	1272	dota 
108	kpq45	anonymous@anonymous.com	1273	path of exile
108	kpq45	anonymous@anonymous.com	1274	path of exile
108	kpq45	anonymous@anonymous.com	1275	dota 
108	kpq45	anonymous@anonymous.com	1276	path of exile
108	kpq45	anonymous@anonymous.com	1277	dota 
108	kpq45	anonymous@anonymous.com	1278	path of exile
108	kpq45	anonymous@anonymous.com	1279	path of exile
108	kpq45	anonymous@anonymous.com	1280	dota 
108	kpq45	anonymous@anonymous.com	1281	path of exile
108	kpq45	anonymous@anonymous.com	1282	path of exile
108	kpq45	anonymous@anonymous.com	1283	dota 
108	kpq45	anonymous@anonymous.com	1284	path of exile
108	kpq45	anonymous@anonymous.com	1285	dota 
108	kpq45	anonymous@anonymous.com	1286	path of exile
108	kpq45	anonymous@anonymous.com	1287	path of exile
108	kpq45	anonymous@anonymous.com	1288	dota 
108	kpq45	anonymous@anonymous.com	1289	path of exile
108	kpq45	anonymous@anonymous.com	1290	path of exile
108	kpq45	anonymous@anonymous.com	1291	dota 
108	kpq45	anonymous@anonymous.com	1292	path of exile
108	kpq45	anonymous@anonymous.com	1293	dota 
108	kpq45	anonymous@anonymous.com	1294	path of exile
108	kpq45	anonymous@anonymous.com	1295	dota 
108	kpq45	anonymous@anonymous.com	1296	path of exile
108	kpq45	anonymous@anonymous.com	1297	path of exile
108	kpq45	anonymous@anonymous.com	1298	dota 
108	kpq45	anonymous@anonymous.com	1299	path of exile
108	kpq45	anonymous@anonymous.com	1300	path of exile
108	kpq45	anonymous@anonymous.com	1301	dota 
108	kpq45	anonymous@anonymous.com	1302	path of exile
108	kpq45	anonymous@anonymous.com	1303	dota 
108	kpq45	anonymous@anonymous.com	1304	path of exile
108	kpq45	anonymous@anonymous.com	1305	path of exile
108	kpq45	anonymous@anonymous.com	1306	dota 
108	kpq45	anonymous@anonymous.com	1307	path of exile
108	kpq45	anonymous@anonymous.com	1308	path of exile
108	kpq45	anonymous@anonymous.com	1309	dota 
108	kpq45	anonymous@anonymous.com	1310	path of exile
108	kpq45	anonymous@anonymous.com	1311	dota 
108	kpq45	anonymous@anonymous.com	1312	path of exile
108	kpq45	anonymous@anonymous.com	1313	path of exile
108	kpq45	anonymous@anonymous.com	1314	dota 
108	kpq45	anonymous@anonymous.com	1315	path of exile
108	kpq45	anonymous@anonymous.com	1316	path of exile
108	kpq45	anonymous@anonymous.com	1317	dota 
108	kpq45	anonymous@anonymous.com	1318	path of exile
108	kpq45	anonymous@anonymous.com	1319	dota 
108	kpq45	anonymous@anonymous.com	1320	path of exile
108	kpq45	anonymous@anonymous.com	1321	path of exile
108	kpq45	anonymous@anonymous.com	1322	dota 
108	kpq45	anonymous@anonymous.com	1323	path of exile
108	kpq45	anonymous@anonymous.com	1324	dota 
108	kpq45	anonymous@anonymous.com	1325	path of exile
108	kpq45	anonymous@anonymous.com	1326	path of exile
108	kpq45	anonymous@anonymous.com	1327	dota 
108	kpq45	anonymous@anonymous.com	1328	path of exile
108	kpq45	anonymous@anonymous.com	1329	dota 
108	kpq45	anonymous@anonymous.com	1330	path of exile
108	kpq45	anonymous@anonymous.com	1331	path of exile
108	kpq45	anonymous@anonymous.com	1332	dota 
108	kpq45	anonymous@anonymous.com	1333	path of exile
108	kpq45	anonymous@anonymous.com	1334	path of exile
108	kpq45	anonymous@anonymous.com	1335	dota 
108	kpq45	anonymous@anonymous.com	1336	path of exile
108	kpq45	anonymous@anonymous.com	1337	dota 
108	kpq45	anonymous@anonymous.com	1338	path of exile
108	kpq45	anonymous@anonymous.com	1339	path of exile
108	kpq45	anonymous@anonymous.com	1340	dota 
108	kpq45	anonymous@anonymous.com	1341	path of exile
108	kpq45	anonymous@anonymous.com	1342	dota 
108	kpq45	anonymous@anonymous.com	1343	path of exile
108	kpq45	anonymous@anonymous.com	1344	path of exile
108	kpq45	anonymous@anonymous.com	1345	dota 
108	kpq45	anonymous@anonymous.com	1346	path of exile
108	kpq45	anonymous@anonymous.com	1348	path of exile
108	kpq45	anonymous@anonymous.com	1347	dota 
108	kpq45	anonymous@anonymous.com	1349	path of exile
108	kpq45	anonymous@anonymous.com	1350	dota 
108	kpq45	anonymous@anonymous.com	1351	path of exile
108	kpq45	anonymous@anonymous.com	1352	path of exile
108	kpq45	anonymous@anonymous.com	1353	dota 
108	kpq45	anonymous@anonymous.com	1354	path of exile
108	kpq45	anonymous@anonymous.com	1355	dota 
108	kpq45	anonymous@anonymous.com	1356	path of exile
108	kpq45	anonymous@anonymous.com	1357	path of exile
108	kpq45	anonymous@anonymous.com	1358	dota 
108	kpq45	anonymous@anonymous.com	1359	path of exile
108	kpq45	anonymous@anonymous.com	1360	dota 
108	kpq45	anonymous@anonymous.com	1361	path of exile
108	kpq45	anonymous@anonymous.com	1362	path of exile
108	kpq45	anonymous@anonymous.com	1363	dota 
108	kpq45	anonymous@anonymous.com	1364	path of exile
108	kpq45	anonymous@anonymous.com	1365	dota 
108	kpq45	anonymous@anonymous.com	1366	path of exile
108	kpq45	anonymous@anonymous.com	1367	path of exile
108	kpq45	anonymous@anonymous.com	1368	dota 
108	kpq45	anonymous@anonymous.com	1369	path of exile
108	kpq45	anonymous@anonymous.com	1370	path of exile
108	kpq45	anonymous@anonymous.com	1371	dota 
108	kpq45	anonymous@anonymous.com	1372	path of exile
108	kpq45	anonymous@anonymous.com	1373	dota 
108	kpq45	anonymous@anonymous.com	1374	path of exile
108	kpq45	anonymous@anonymous.com	1375	path of exile
108	kpq45	anonymous@anonymous.com	1376	dota 
108	kpq45	anonymous@anonymous.com	1377	path of exile
108	kpq45	anonymous@anonymous.com	1378	path of exile
108	kpq45	anonymous@anonymous.com	1379	dota 
108	kpq45	anonymous@anonymous.com	1380	path of exile
108	kpq45	anonymous@anonymous.com	1381	dota 
108	kpq45	anonymous@anonymous.com	1382	path of exile
108	kpq45	anonymous@anonymous.com	1383	path of exile
108	kpq45	anonymous@anonymous.com	1384	dota 
108	kpq45	anonymous@anonymous.com	1385	path of exile
108	kpq45	anonymous@anonymous.com	1386	dota 
108	kpq45	anonymous@anonymous.com	1387	path of exile
108	kpq45	anonymous@anonymous.com	1388	path of exile
108	kpq45	anonymous@anonymous.com	1389	dota 
108	kpq45	anonymous@anonymous.com	1390	path of exile
108	kpq45	anonymous@anonymous.com	1391	dota 
108	kpq45	anonymous@anonymous.com	1392	path of exile
108	kpq45	anonymous@anonymous.com	1393	path of exile
108	kpq45	anonymous@anonymous.com	1394	dota 
108	kpq45	anonymous@anonymous.com	1395	path of exile
108	kpq45	anonymous@anonymous.com	1396	dota 
108	kpq45	anonymous@anonymous.com	1397	path of exile
108	kpq45	anonymous@anonymous.com	1398	path of exile
108	kpq45	anonymous@anonymous.com	1399	dota 
108	kpq45	anonymous@anonymous.com	1400	path of exile
108	kpq45	anonymous@anonymous.com	1401	path of exile
108	kpq45	anonymous@anonymous.com	1402	dota 
108	kpq45	anonymous@anonymous.com	1403	path of exile
108	kpq45	anonymous@anonymous.com	1404	path of exile
108	kpq45	anonymous@anonymous.com	1405	dota 
108	kpq45	anonymous@anonymous.com	1406	path of exile
108	kpq45	anonymous@anonymous.com	1407	dota 
108	kpq45	anonymous@anonymous.com	1408	path of exile
108	kpq45	anonymous@anonymous.com	1409	dota 
108	kpq45	anonymous@anonymous.com	1410	path of exile
108	kpq45	anonymous@anonymous.com	1411	path of exile
108	kpq45	anonymous@anonymous.com	1412	dota 
108	kpq45	anonymous@anonymous.com	1413	path of exile
108	kpq45	anonymous@anonymous.com	1414	path of exile
108	kpq45	anonymous@anonymous.com	1415	dota 
108	kpq45	anonymous@anonymous.com	1416	path of exile
108	kpq45	anonymous@anonymous.com	1417	dota 
108	kpq45	anonymous@anonymous.com	1418	path of exile
108	kpq45	anonymous@anonymous.com	1420	path of exile
108	kpq45	anonymous@anonymous.com	1419	dota 
108	kpq45	anonymous@anonymous.com	1421	path of exile
108	kpq45	anonymous@anonymous.com	1422	dota 
108	kpq45	anonymous@anonymous.com	1423	path of exile
108	kpq45	anonymous@anonymous.com	1424	dota 
108	kpq45	anonymous@anonymous.com	1425	path of exile
108	kpq45	anonymous@anonymous.com	1426	path of exile
108	kpq45	anonymous@anonymous.com	1427	dota 
108	kpq45	anonymous@anonymous.com	1428	path of exile
108	kpq45	anonymous@anonymous.com	1429	path of exile
108	kpq45	anonymous@anonymous.com	1430	dota 
108	kpq45	anonymous@anonymous.com	1431	path of exile
108	kpq45	anonymous@anonymous.com	1432	dota 
108	kpq45	anonymous@anonymous.com	1433	path of exile
108	kpq45	anonymous@anonymous.com	1434	path of exile
108	kpq45	anonymous@anonymous.com	1435	dota 
108	kpq45	anonymous@anonymous.com	1436	path of exile
108	kpq45	anonymous@anonymous.com	1437	dota 
108	kpq45	anonymous@anonymous.com	1438	path of exile
108	kpq45	anonymous@anonymous.com	1439	path of exile
108	kpq45	anonymous@anonymous.com	1440	dota 
108	kpq45	anonymous@anonymous.com	1441	path of exile
108	kpq45	anonymous@anonymous.com	1442	path of exile
108	kpq45	anonymous@anonymous.com	1443	dota 
108	kpq45	anonymous@anonymous.com	1444	path of exile
108	kpq45	anonymous@anonymous.com	1445	dota 
108	kpq45	anonymous@anonymous.com	1446	path of exile
108	kpq45	anonymous@anonymous.com	1447	dota 
108	kpq45	anonymous@anonymous.com	1448	path of exile
108	kpq45	anonymous@anonymous.com	1449	path of exile
108	kpq45	anonymous@anonymous.com	1450	dota 
108	kpq45	anonymous@anonymous.com	1451	path of exile
108	kpq45	anonymous@anonymous.com	1452	dota 
108	kpq45	anonymous@anonymous.com	1453	path of exile
108	kpq45	anonymous@anonymous.com	1454	path of exile
108	kpq45	anonymous@anonymous.com	1455	dota 
108	kpq45	anonymous@anonymous.com	1456	path of exile
108	kpq45	anonymous@anonymous.com	1457	dota 
108	kpq45	anonymous@anonymous.com	1458	path of exile
108	kpq45	anonymous@anonymous.com	1459	path of exile
108	kpq45	anonymous@anonymous.com	1460	dota 
108	kpq45	anonymous@anonymous.com	1461	path of exile
108	kpq45	anonymous@anonymous.com	1462	dota 
108	kpq45	anonymous@anonymous.com	1463	path of exile
108	kpq45	anonymous@anonymous.com	1464	path of exile
108	kpq45	anonymous@anonymous.com	1465	dota 
108	kpq45	anonymous@anonymous.com	1466	path of exile
108	kpq45	anonymous@anonymous.com	1467	path of exile
108	kpq45	anonymous@anonymous.com	1468	dota 
108	kpq45	anonymous@anonymous.com	1469	path of exile
108	kpq45	anonymous@anonymous.com	1470	dota 
108	kpq45	anonymous@anonymous.com	1471	path of exile
108	kpq45	anonymous@anonymous.com	1472	path of exile
108	kpq45	anonymous@anonymous.com	1473	dota 
108	kpq45	anonymous@anonymous.com	1474	path of exile
108	kpq45	anonymous@anonymous.com	1475	dota 
108	kpq45	anonymous@anonymous.com	1476	path of exile
108	kpq45	anonymous@anonymous.com	1477	path of exile
108	kpq45	anonymous@anonymous.com	1478	dota 
108	kpq45	anonymous@anonymous.com	1479	path of exile
108	kpq45	anonymous@anonymous.com	1480	dota 
108	kpq45	anonymous@anonymous.com	1481	path of exile
108	kpq45	anonymous@anonymous.com	1482	path of exile
108	kpq45	anonymous@anonymous.com	1483	dota 
108	kpq45	anonymous@anonymous.com	1484	path of exile
108	kpq45	anonymous@anonymous.com	1485	dota 
108	kpq45	anonymous@anonymous.com	1486	path of exile
108	kpq45	anonymous@anonymous.com	1487	path of exile
108	kpq45	anonymous@anonymous.com	1488	dota 
108	kpq45	anonymous@anonymous.com	1489	path of exile
108	kpq45	anonymous@anonymous.com	1490	dota 
108	kpq45	anonymous@anonymous.com	1491	path of exile
108	kpq45	anonymous@anonymous.com	1492	path of exile
108	kpq45	anonymous@anonymous.com	1493	dota 
108	kpq45	anonymous@anonymous.com	1494	path of exile
108	kpq45	anonymous@anonymous.com	1495	dota 
108	kpq45	anonymous@anonymous.com	1496	path of exile
108	kpq45	anonymous@anonymous.com	1497	path of exile
108	kpq45	anonymous@anonymous.com	1498	dota 
108	kpq45	anonymous@anonymous.com	1499	path of exile
108	kpq45	anonymous@anonymous.com	1500	dota 
108	kpq45	anonymous@anonymous.com	1501	path of exile
108	kpq45	anonymous@anonymous.com	1502	path of exile
108	kpq45	anonymous@anonymous.com	1503	dota 
108	kpq45	anonymous@anonymous.com	1504	path of exile
108	kpq45	anonymous@anonymous.com	1505	dota 
108	kpq45	anonymous@anonymous.com	1506	path of exile
108	kpq45	anonymous@anonymous.com	1507	path of exile
108	kpq45	anonymous@anonymous.com	1508	dota 
108	kpq45	anonymous@anonymous.com	1509	path of exile
108	kpq45	anonymous@anonymous.com	1510	dota 
108	kpq45	anonymous@anonymous.com	1511	path of exile
108	kpq45	anonymous@anonymous.com	1512	dota 
108	kpq45	anonymous@anonymous.com	1513	path of exile
108	kpq45	anonymous@anonymous.com	1514	path of exile
108	kpq45	anonymous@anonymous.com	1515	dota 
108	kpq45	anonymous@anonymous.com	1516	path of exile
108	kpq45	anonymous@anonymous.com	1517	path of exile
108	kpq45	anonymous@anonymous.com	1518	dota 
108	kpq45	anonymous@anonymous.com	1519	path of exile
108	kpq45	anonymous@anonymous.com	1520	dota 
108	kpq45	anonymous@anonymous.com	1521	path of exile
108	kpq45	anonymous@anonymous.com	1522	dota 
108	kpq45	anonymous@anonymous.com	1523	path of exile
108	kpq45	anonymous@anonymous.com	1524	path of exile
108	kpq45	anonymous@anonymous.com	1525	dota 
108	kpq45	anonymous@anonymous.com	1526	path of exile
108	kpq45	anonymous@anonymous.com	1527	dota 
108	kpq45	anonymous@anonymous.com	1528	path of exile
108	kpq45	anonymous@anonymous.com	1529	path of exile
108	kpq45	anonymous@anonymous.com	1530	dota 
108	kpq45	anonymous@anonymous.com	1531	path of exile
108	kpq45	anonymous@anonymous.com	1532	dota 
108	kpq45	anonymous@anonymous.com	1533	path of exile
108	kpq45	anonymous@anonymous.com	1534	path of exile
108	kpq45	anonymous@anonymous.com	1535	dota 
108	kpq45	anonymous@anonymous.com	1536	path of exile
108	kpq45	anonymous@anonymous.com	1537	dota 
108	kpq45	anonymous@anonymous.com	1538	path of exile
108	kpq45	anonymous@anonymous.com	1539	path of exile
108	kpq45	anonymous@anonymous.com	1540	dota 
108	kpq45	anonymous@anonymous.com	1541	path of exile
108	kpq45	anonymous@anonymous.com	1542	dota 
108	kpq45	anonymous@anonymous.com	1543	path of exile
108	kpq45	anonymous@anonymous.com	1544	path of exile
108	kpq45	anonymous@anonymous.com	1545	dota 
108	kpq45	anonymous@anonymous.com	1546	path of exile
108	kpq45	anonymous@anonymous.com	1547	dota 
108	kpq45	anonymous@anonymous.com	1548	path of exile
108	kpq45	anonymous@anonymous.com	1549	path of exile
108	kpq45	anonymous@anonymous.com	1550	dota 
108	kpq45	anonymous@anonymous.com	1551	path of exile
108	kpq45	anonymous@anonymous.com	1552	dota 
108	kpq45	anonymous@anonymous.com	1553	path of exile
108	kpq45	anonymous@anonymous.com	1554	path of exile
108	kpq45	anonymous@anonymous.com	1555	dota 
108	kpq45	anonymous@anonymous.com	1556	path of exile
108	kpq45	anonymous@anonymous.com	1557	dota 
108	kpq45	anonymous@anonymous.com	1558	path of exile
108	kpq45	anonymous@anonymous.com	1559	path of exile
108	kpq45	anonymous@anonymous.com	1560	dota 
108	kpq45	anonymous@anonymous.com	1561	path of exile
108	kpq45	anonymous@anonymous.com	1562	dota 
108	kpq45	anonymous@anonymous.com	1563	path of exile
108	kpq45	anonymous@anonymous.com	1564	dota 
108	kpq45	anonymous@anonymous.com	1565	path of exile
108	kpq45	anonymous@anonymous.com	1566	path of exile
108	kpq45	anonymous@anonymous.com	1567	dota 
108	kpq45	anonymous@anonymous.com	1568	path of exile
108	kpq45	anonymous@anonymous.com	1569	dota 
108	kpq45	anonymous@anonymous.com	1570	path of exile
108	kpq45	anonymous@anonymous.com	1571	path of exile
108	kpq45	anonymous@anonymous.com	1572	dota 
108	kpq45	anonymous@anonymous.com	1573	path of exile
108	kpq45	anonymous@anonymous.com	1574	dota 
108	kpq45	anonymous@anonymous.com	1575	path of exile
108	kpq45	anonymous@anonymous.com	1576	path of exile
108	kpq45	anonymous@anonymous.com	1577	dota 
108	kpq45	anonymous@anonymous.com	1578	path of exile
108	kpq45	anonymous@anonymous.com	1579	dota 
108	kpq45	anonymous@anonymous.com	1580	path of exile
108	kpq45	anonymous@anonymous.com	1581	path of exile
108	kpq45	anonymous@anonymous.com	1582	dota 
108	kpq45	anonymous@anonymous.com	1583	path of exile
108	kpq45	anonymous@anonymous.com	1584	dota 
108	kpq45	anonymous@anonymous.com	1585	path of exile
108	kpq45	anonymous@anonymous.com	1586	path of exile
108	kpq45	anonymous@anonymous.com	1587	dota 
108	kpq45	anonymous@anonymous.com	1588	path of exile
108	kpq45	anonymous@anonymous.com	1589	dota 
108	kpq45	anonymous@anonymous.com	1590	path of exile
108	kpq45	anonymous@anonymous.com	1591	dota 
108	kpq45	anonymous@anonymous.com	1592	path of exile
108	kpq45	anonymous@anonymous.com	1593	path of exile
108	kpq45	anonymous@anonymous.com	1594	dota 
108	kpq45	anonymous@anonymous.com	1595	path of exile
108	kpq45	anonymous@anonymous.com	1596	dota 
108	kpq45	anonymous@anonymous.com	1597	path of exile
108	kpq45	anonymous@anonymous.com	1598	path of exile
108	kpq45	anonymous@anonymous.com	1599	dota 
108	kpq45	anonymous@anonymous.com	1600	path of exile
108	kpq45	anonymous@anonymous.com	1601	dota 
108	kpq45	anonymous@anonymous.com	1602	path of exile
108	kpq45	anonymous@anonymous.com	1603	path of exile
108	kpq45	anonymous@anonymous.com	1604	dota 
108	kpq45	anonymous@anonymous.com	1605	path of exile
108	kpq45	anonymous@anonymous.com	1606	dota 
108	kpq45	anonymous@anonymous.com	1607	path of exile
108	kpq45	anonymous@anonymous.com	1608	path of exile
108	kpq45	anonymous@anonymous.com	1609	dota 
108	kpq45	anonymous@anonymous.com	1610	path of exile
108	kpq45	anonymous@anonymous.com	1611	path of exile
108	kpq45	anonymous@anonymous.com	1612	path of exile
108	kpq45	anonymous@anonymous.com	1613	path of exile
108	kpq45	anonymous@anonymous.com	1614	path of exile
108	kpq45	anonymous@anonymous.com	1615	path of exile
108	kpq45	anonymous@anonymous.com	1616	path of exile
108	kpq45	anonymous@anonymous.com	1617	path of exile
108	kpq45	anonymous@anonymous.com	1618	path of exile
108	kpq45	anonymous@anonymous.com	1619	path of exile
108	kpq45	anonymous@anonymous.com	1620	path of exile
108	kpq45	anonymous@anonymous.com	1621	path of exile
108	kpq45	anonymous@anonymous.com	1622	path of exile
108	kpq45	anonymous@anonymous.com	1623	path of exile
108	kpq45	anonymous@anonymous.com	1624	path of exile
108	kpq45	anonymous@anonymous.com	1625	path of exile
108	kpq45	anonymous@anonymous.com	1626	path of exile
108	kpq45	anonymous@anonymous.com	1627	path of exile
108	kpq45	anonymous@anonymous.com	1628	path of exile
108	kpq45	anonymous@anonymous.com	1629	path of exile
108	kpq45	anonymous@anonymous.com	1630	path of exile
108	kpq45	anonymous@anonymous.com	1631	dota 
108	kpq45	anonymous@anonymous.com	1632	path of exile
108	kpq45	anonymous@anonymous.com	1633	dota 
108	kpq45	anonymous@anonymous.com	1634	path of exile
108	kpq45	anonymous@anonymous.com	1635	dota 
108	kpq45	anonymous@anonymous.com	1636	path of exile
108	kpq45	anonymous@anonymous.com	1637	dota 
108	kpq45	anonymous@anonymous.com	1638	path of exile
108	kpq45	anonymous@anonymous.com	1639	dota 
108	kpq45	anonymous@anonymous.com	1640	path of exile
108	kpq45	anonymous@anonymous.com	1641	dota 
108	kpq45	anonymous@anonymous.com	1642	path of exile
108	kpq45	anonymous@anonymous.com	1643	dota 
108	kpq45	anonymous@anonymous.com	1644	path of exile
108	kpq45	anonymous@anonymous.com	1645	dota 
108	kpq45	anonymous@anonymous.com	1646	path of exile
108	kpq45	anonymous@anonymous.com	1647	dota 
108	kpq45	anonymous@anonymous.com	1648	path of exile
108	kpq45	anonymous@anonymous.com	1649	dota 
108	kpq45	anonymous@anonymous.com	1650	path of exile
108	kpq45	anonymous@anonymous.com	1651	dota 
108	kpq45	anonymous@anonymous.com	1652	path of exile
108	kpq45	anonymous@anonymous.com	1653	dota 
108	kpq45	anonymous@anonymous.com	1654	path of exile
108	kpq45	anonymous@anonymous.com	1655	dota 
108	kpq45	anonymous@anonymous.com	1656	path of exile
108	kpq45	anonymous@anonymous.com	1657	dota 
108	kpq45	anonymous@anonymous.com	1658	path of exile
108	kpq45	anonymous@anonymous.com	1659	dota 
108	kpq45	anonymous@anonymous.com	1660	path of exile
108	kpq45	anonymous@anonymous.com	1661	dota 
108	kpq45	anonymous@anonymous.com	1662	path of exile
108	kpq45	anonymous@anonymous.com	1663	dota 
108	kpq45	anonymous@anonymous.com	1664	path of exile
108	kpq45	anonymous@anonymous.com	1665	dota 
108	kpq45	anonymous@anonymous.com	1666	path of exile
108	kpq45	anonymous@anonymous.com	1667	dota 
108	kpq45	anonymous@anonymous.com	1668	path of exile
108	kpq45	anonymous@anonymous.com	1669	dota 
108	kpq45	anonymous@anonymous.com	1670	path of exile
108	kpq45	anonymous@anonymous.com	1671	dota 
108	kpq45	anonymous@anonymous.com	1672	path of exile
108	kpq45	anonymous@anonymous.com	1673	dota 
108	kpq45	anonymous@anonymous.com	1674	path of exile
108	kpq45	anonymous@anonymous.com	1675	dota 
108	kpq45	anonymous@anonymous.com	1676	path of exile
108	kpq45	anonymous@anonymous.com	1677	dota 
108	kpq45	anonymous@anonymous.com	1678	path of exile
108	kpq45	anonymous@anonymous.com	1679	dota 
108	kpq45	anonymous@anonymous.com	1680	path of exile
108	kpq45	anonymous@anonymous.com	1681	dota 
108	kpq45	anonymous@anonymous.com	1682	path of exile
108	kpq45	anonymous@anonymous.com	1683	dota 
108	kpq45	anonymous@anonymous.com	1684	path of exile
108	kpq45	anonymous@anonymous.com	1685	dota 
108	kpq45	anonymous@anonymous.com	1686	path of exile
108	kpq45	anonymous@anonymous.com	1687	dota 
108	kpq45	anonymous@anonymous.com	1688	path of exile
108	kpq45	anonymous@anonymous.com	1689	dota 
108	kpq45	anonymous@anonymous.com	1690	path of exile
108	kpq45	anonymous@anonymous.com	1691	dota 
108	kpq45	anonymous@anonymous.com	1692	path of exile
108	kpq45	anonymous@anonymous.com	1693	dota 
108	kpq45	anonymous@anonymous.com	1694	path of exile
108	kpq45	anonymous@anonymous.com	1695	dota 
108	kpq45	anonymous@anonymous.com	1696	path of exile
108	kpq45	anonymous@anonymous.com	1697	dota 
108	kpq45	anonymous@anonymous.com	1698	path of exile
108	kpq45	anonymous@anonymous.com	1699	dota 
108	kpq45	anonymous@anonymous.com	1700	path of exile
108	kpq45	anonymous@anonymous.com	1701	dota 
108	kpq45	anonymous@anonymous.com	1702	path of exile
108	kpq45	anonymous@anonymous.com	1703	dota 
108	kpq45	anonymous@anonymous.com	1704	path of exile
108	kpq45	anonymous@anonymous.com	1705	dota 
108	kpq45	anonymous@anonymous.com	1706	path of exile
108	kpq45	anonymous@anonymous.com	1707	dota 
108	kpq45	anonymous@anonymous.com	1708	path of exile
108	kpq45	anonymous@anonymous.com	1709	dota 
108	kpq45	anonymous@anonymous.com	1710	path of exile
108	kpq45	anonymous@anonymous.com	1711	dota 
108	kpq45	anonymous@anonymous.com	1712	path of exile
108	kpq45	anonymous@anonymous.com	1713	dota 
108	kpq45	anonymous@anonymous.com	1714	path of exile
108	kpq45	anonymous@anonymous.com	1715	dota 
108	kpq45	anonymous@anonymous.com	1716	path of exile
108	kpq45	anonymous@anonymous.com	1717	dota 
108	kpq45	anonymous@anonymous.com	1718	path of exile
108	kpq45	anonymous@anonymous.com	1719	dota 
108	kpq45	anonymous@anonymous.com	1720	path of exile
108	kpq45	anonymous@anonymous.com	1721	dota 
108	kpq45	anonymous@anonymous.com	1722	path of exile
108	kpq45	anonymous@anonymous.com	1723	dota 
108	kpq45	anonymous@anonymous.com	1724	path of exile
108	kpq45	anonymous@anonymous.com	1725	dota 
108	kpq45	anonymous@anonymous.com	1726	path of exile
108	kpq45	anonymous@anonymous.com	1727	dota 
108	kpq45	anonymous@anonymous.com	1728	path of exile
108	kpq45	anonymous@anonymous.com	1729	dota 
108	kpq45	anonymous@anonymous.com	1730	path of exile
108	kpq45	anonymous@anonymous.com	1731	dota 
108	kpq45	anonymous@anonymous.com	1732	path of exile
108	kpq45	anonymous@anonymous.com	1733	dota 
108	kpq45	anonymous@anonymous.com	1734	path of exile
108	kpq45	anonymous@anonymous.com	1735	dota 
108	kpq45	anonymous@anonymous.com	1736	path of exile
108	kpq45	anonymous@anonymous.com	1737	dota 
108	kpq45	anonymous@anonymous.com	1738	path of exile
108	kpq45	anonymous@anonymous.com	1739	dota 
108	kpq45	anonymous@anonymous.com	1740	path of exile
108	kpq45	anonymous@anonymous.com	1741	dota 
108	kpq45	anonymous@anonymous.com	1742	path of exile
108	kpq45	anonymous@anonymous.com	1743	dota 
108	kpq45	anonymous@anonymous.com	1744	path of exile
108	kpq45	anonymous@anonymous.com	1745	dota 
108	kpq45	anonymous@anonymous.com	1746	path of exile
108	kpq45	anonymous@anonymous.com	1747	dota 
108	kpq45	anonymous@anonymous.com	1748	path of exile
108	kpq45	anonymous@anonymous.com	1749	dota 
108	kpq45	anonymous@anonymous.com	1750	path of exile
108	kpq45	anonymous@anonymous.com	1751	dota 
108	kpq45	anonymous@anonymous.com	1752	path of exile
108	kpq45	anonymous@anonymous.com	1753	dota 
108	kpq45	anonymous@anonymous.com	1754	path of exile
108	kpq45	anonymous@anonymous.com	1755	dota 
108	kpq45	anonymous@anonymous.com	1756	path of exile
108	kpq45	anonymous@anonymous.com	1757	dota 
108	kpq45	anonymous@anonymous.com	1758	path of exile
108	kpq45	anonymous@anonymous.com	1759	dota 
108	kpq45	anonymous@anonymous.com	1760	path of exile
108	kpq45	anonymous@anonymous.com	1761	dota 
108	kpq45	anonymous@anonymous.com	1762	path of exile
108	kpq45	anonymous@anonymous.com	1763	dota 
108	kpq45	anonymous@anonymous.com	1764	path of exile
108	kpq45	anonymous@anonymous.com	1765	dota 
108	kpq45	anonymous@anonymous.com	1766	path of exile
108	kpq45	anonymous@anonymous.com	1767	dota 
108	kpq45	anonymous@anonymous.com	1768	path of exile
108	kpq45	anonymous@anonymous.com	1769	dota 
108	kpq45	anonymous@anonymous.com	1770	path of exile
108	kpq45	anonymous@anonymous.com	1771	dota 
108	kpq45	anonymous@anonymous.com	1772	path of exile
108	kpq45	anonymous@anonymous.com	1773	dota 
108	kpq45	anonymous@anonymous.com	1774	path of exile
108	kpq45	anonymous@anonymous.com	1775	dota 
108	kpq45	anonymous@anonymous.com	1776	path of exile
108	kpq45	anonymous@anonymous.com	1777	dota 
108	kpq45	anonymous@anonymous.com	1778	path of exile
108	kpq45	anonymous@anonymous.com	1779	dota 
108	kpq45	anonymous@anonymous.com	1780	path of exile
108	kpq45	anonymous@anonymous.com	1781	dota 
108	kpq45	anonymous@anonymous.com	1782	path of exile
108	kpq45	anonymous@anonymous.com	1783	dota 
108	kpq45	anonymous@anonymous.com	1784	path of exile
108	kpq45	anonymous@anonymous.com	1785	dota 
108	kpq45	anonymous@anonymous.com	1786	path of exile
108	kpq45	anonymous@anonymous.com	1787	dota 
108	kpq45	anonymous@anonymous.com	1788	path of exile
108	kpq45	anonymous@anonymous.com	1789	dota 
108	kpq45	anonymous@anonymous.com	1790	path of exile
108	kpq45	anonymous@anonymous.com	1791	dota 
108	kpq45	anonymous@anonymous.com	1792	path of exile
108	kpq45	anonymous@anonymous.com	1793	dota 
108	kpq45	anonymous@anonymous.com	1794	path of exile
108	kpq45	anonymous@anonymous.com	1795	dota 
108	kpq45	anonymous@anonymous.com	1796	path of exile
108	kpq45	anonymous@anonymous.com	1797	dota 
108	kpq45	anonymous@anonymous.com	1798	path of exile
108	kpq45	anonymous@anonymous.com	1799	dota 
108	kpq45	anonymous@anonymous.com	1800	path of exile
108	kpq45	anonymous@anonymous.com	1801	dota 
108	kpq45	anonymous@anonymous.com	1802	path of exile
108	kpq45	anonymous@anonymous.com	1803	dota 
108	kpq45	anonymous@anonymous.com	1804	path of exile
108	kpq45	anonymous@anonymous.com	1805	dota 
108	kpq45	anonymous@anonymous.com	1806	path of exile
108	kpq45	anonymous@anonymous.com	1807	dota 
108	kpq45	anonymous@anonymous.com	1808	path of exile
108	kpq45	anonymous@anonymous.com	1809	dota 
108	kpq45	anonymous@anonymous.com	1810	path of exile
108	kpq45	anonymous@anonymous.com	1811	dota 
108	kpq45	anonymous@anonymous.com	1812	path of exile
108	kpq45	anonymous@anonymous.com	1813	dota 
108	kpq45	anonymous@anonymous.com	1814	path of exile
108	kpq45	anonymous@anonymous.com	1815	dota 
108	kpq45	anonymous@anonymous.com	1816	path of exile
108	kpq45	anonymous@anonymous.com	1817	dota 
108	kpq45	anonymous@anonymous.com	1818	path of exile
108	kpq45	anonymous@anonymous.com	1819	dota 
108	kpq45	anonymous@anonymous.com	1820	path of exile
108	kpq45	anonymous@anonymous.com	1821	dota 
108	kpq45	anonymous@anonymous.com	1822	path of exile
108	kpq45	anonymous@anonymous.com	1823	dota 
108	kpq45	anonymous@anonymous.com	1824	path of exile
108	kpq45	anonymous@anonymous.com	1825	dota 
108	kpq45	anonymous@anonymous.com	1826	path of exile
108	kpq45	anonymous@anonymous.com	1827	dota 
108	kpq45	anonymous@anonymous.com	1828	path of exile
108	kpq45	anonymous@anonymous.com	1829	dota 
108	kpq45	anonymous@anonymous.com	1830	path of exile
108	kpq45	anonymous@anonymous.com	1831	dota 
108	kpq45	anonymous@anonymous.com	1832	path of exile
108	kpq45	anonymous@anonymous.com	1833	dota 
108	kpq45	anonymous@anonymous.com	1834	path of exile
108	kpq45	anonymous@anonymous.com	1835	dota 
108	kpq45	anonymous@anonymous.com	1836	path of exile
108	kpq45	anonymous@anonymous.com	1837	dota 
108	kpq45	anonymous@anonymous.com	1838	path of exile
108	kpq45	anonymous@anonymous.com	1839	dota 
108	kpq45	anonymous@anonymous.com	1840	path of exile
108	kpq45	anonymous@anonymous.com	1841	dota 
108	kpq45	anonymous@anonymous.com	1842	path of exile
108	kpq45	anonymous@anonymous.com	1843	dota 
108	kpq45	anonymous@anonymous.com	1844	path of exile
108	kpq45	anonymous@anonymous.com	1845	dota 
108	kpq45	anonymous@anonymous.com	1846	path of exile
108	kpq45	anonymous@anonymous.com	1847	dota 
108	kpq45	anonymous@anonymous.com	1848	path of exile
108	kpq45	anonymous@anonymous.com	1849	dota 
108	kpq45	anonymous@anonymous.com	1850	path of exile
108	kpq45	anonymous@anonymous.com	1851	dota 
108	kpq45	anonymous@anonymous.com	1852	path of exile
108	kpq45	anonymous@anonymous.com	1853	dota 
108	kpq45	anonymous@anonymous.com	1854	path of exile
108	kpq45	anonymous@anonymous.com	1855	dota 
108	kpq45	anonymous@anonymous.com	1856	path of exile
108	kpq45	anonymous@anonymous.com	1857	dota 
108	kpq45	anonymous@anonymous.com	1858	path of exile
108	kpq45	anonymous@anonymous.com	1859	dota 
108	kpq45	anonymous@anonymous.com	1860	path of exile
108	kpq45	anonymous@anonymous.com	1861	dota 
108	kpq45	anonymous@anonymous.com	1862	path of exile
108	kpq45	anonymous@anonymous.com	1863	dota 
108	kpq45	anonymous@anonymous.com	1864	path of exile
108	kpq45	anonymous@anonymous.com	1865	dota 
108	kpq45	anonymous@anonymous.com	1866	path of exile
108	kpq45	anonymous@anonymous.com	1867	dota 
108	kpq45	anonymous@anonymous.com	1868	path of exile
108	kpq45	anonymous@anonymous.com	1869	dota 
108	kpq45	anonymous@anonymous.com	1870	path of exile
108	kpq45	anonymous@anonymous.com	1871	dota 
108	kpq45	anonymous@anonymous.com	1872	path of exile
108	kpq45	anonymous@anonymous.com	1873	dota 
108	kpq45	anonymous@anonymous.com	1874	path of exile
108	kpq45	anonymous@anonymous.com	1875	dota 
108	kpq45	anonymous@anonymous.com	1876	path of exile
108	kpq45	anonymous@anonymous.com	1877	dota 
108	kpq45	anonymous@anonymous.com	1878	path of exile
108	kpq45	anonymous@anonymous.com	1879	dota 
108	kpq45	anonymous@anonymous.com	1880	path of exile
108	kpq45	anonymous@anonymous.com	1881	dota 
108	kpq45	anonymous@anonymous.com	1882	path of exile
108	kpq45	anonymous@anonymous.com	1883	dota 
108	kpq45	anonymous@anonymous.com	1884	path of exile
108	kpq45	anonymous@anonymous.com	1885	dota 
108	kpq45	anonymous@anonymous.com	1886	path of exile
108	kpq45	anonymous@anonymous.com	1887	dota 
108	kpq45	anonymous@anonymous.com	1888	path of exile
108	kpq45	anonymous@anonymous.com	1889	dota 
108	kpq45	anonymous@anonymous.com	1890	path of exile
108	kpq45	anonymous@anonymous.com	1891	dota 
108	kpq45	anonymous@anonymous.com	1892	path of exile
108	kpq45	anonymous@anonymous.com	1893	dota 
108	kpq45	anonymous@anonymous.com	1894	path of exile
108	kpq45	anonymous@anonymous.com	1895	dota 
108	kpq45	anonymous@anonymous.com	1896	path of exile
108	kpq45	anonymous@anonymous.com	1897	dota 
108	kpq45	anonymous@anonymous.com	1898	path of exile
108	kpq45	anonymous@anonymous.com	1899	dota 
108	kpq45	anonymous@anonymous.com	1900	path of exile
108	kpq45	anonymous@anonymous.com	1901	dota 
108	kpq45	anonymous@anonymous.com	1902	path of exile
108	kpq45	anonymous@anonymous.com	1903	dota 
108	kpq45	anonymous@anonymous.com	1904	path of exile
108	kpq45	anonymous@anonymous.com	1905	dota 
108	kpq45	anonymous@anonymous.com	1906	path of exile
108	kpq45	anonymous@anonymous.com	1907	dota 
108	kpq45	anonymous@anonymous.com	1908	path of exile
108	kpq45	anonymous@anonymous.com	1909	dota 
108	kpq45	anonymous@anonymous.com	1910	path of exile
108	kpq45	anonymous@anonymous.com	1911	dota 
108	kpq45	anonymous@anonymous.com	1912	path of exile
108	kpq45	anonymous@anonymous.com	1913	dota 
108	kpq45	anonymous@anonymous.com	1914	path of exile
108	kpq45	anonymous@anonymous.com	1915	dota 
108	kpq45	anonymous@anonymous.com	1916	path of exile
108	kpq45	anonymous@anonymous.com	1917	dota 
108	kpq45	anonymous@anonymous.com	1918	path of exile
108	kpq45	anonymous@anonymous.com	1919	dota 
108	kpq45	anonymous@anonymous.com	1920	path of exile
108	kpq45	anonymous@anonymous.com	1921	dota 
108	kpq45	anonymous@anonymous.com	1922	path of exile
108	kpq45	anonymous@anonymous.com	1923	dota 
108	kpq45	anonymous@anonymous.com	1924	path of exile
108	kpq45	anonymous@anonymous.com	1925	dota 
108	kpq45	anonymous@anonymous.com	1926	path of exile
108	kpq45	anonymous@anonymous.com	1927	dota 
108	kpq45	anonymous@anonymous.com	1928	path of exile
108	kpq45	anonymous@anonymous.com	1929	dota 
108	kpq45	anonymous@anonymous.com	1930	path of exile
108	kpq45	anonymous@anonymous.com	1931	dota 
108	kpq45	anonymous@anonymous.com	1932	path of exile
108	kpq45	anonymous@anonymous.com	1933	dota 
108	kpq45	anonymous@anonymous.com	1934	path of exile
108	kpq45	anonymous@anonymous.com	1935	dota 
108	kpq45	anonymous@anonymous.com	1936	path of exile
108	kpq45	anonymous@anonymous.com	1937	dota 
108	kpq45	anonymous@anonymous.com	1938	path of exile
108	kpq45	anonymous@anonymous.com	1939	dota 
108	kpq45	anonymous@anonymous.com	1940	path of exile
108	kpq45	anonymous@anonymous.com	1941	dota 
108	kpq45	anonymous@anonymous.com	1942	path of exile
108	kpq45	anonymous@anonymous.com	1943	dota 
108	kpq45	anonymous@anonymous.com	1944	path of exile
108	kpq45	anonymous@anonymous.com	1945	dota 
108	kpq45	anonymous@anonymous.com	1946	path of exile
108	kpq45	anonymous@anonymous.com	1947	dota 
108	kpq45	anonymous@anonymous.com	1948	path of exile
108	kpq45	anonymous@anonymous.com	1949	dota 
108	kpq45	anonymous@anonymous.com	1950	path of exile
108	kpq45	anonymous@anonymous.com	1951	dota 
108	kpq45	anonymous@anonymous.com	1952	path of exile
108	kpq45	anonymous@anonymous.com	1953	dota 
108	kpq45	anonymous@anonymous.com	1954	path of exile
108	kpq45	anonymous@anonymous.com	1955	dota 
108	kpq45	anonymous@anonymous.com	1956	path of exile
108	kpq45	anonymous@anonymous.com	1957	dota 
108	kpq45	anonymous@anonymous.com	1958	path of exile
108	kpq45	anonymous@anonymous.com	1959	dota 
108	kpq45	anonymous@anonymous.com	1960	path of exile
108	kpq45	anonymous@anonymous.com	1961	dota 
108	kpq45	anonymous@anonymous.com	1962	path of exile
108	kpq45	anonymous@anonymous.com	1963	dota 
108	kpq45	anonymous@anonymous.com	1964	path of exile
108	kpq45	anonymous@anonymous.com	1965	dota 
108	kpq45	anonymous@anonymous.com	1966	path of exile
108	kpq45	anonymous@anonymous.com	1967	dota 
108	kpq45	anonymous@anonymous.com	1968	path of exile
108	kpq45	anonymous@anonymous.com	1969	dota 
108	kpq45	anonymous@anonymous.com	1970	path of exile
108	kpq45	anonymous@anonymous.com	1971	dota 
108	kpq45	anonymous@anonymous.com	1972	path of exile
108	kpq45	anonymous@anonymous.com	1973	dota 
108	kpq45	anonymous@anonymous.com	1974	path of exile
108	kpq45	anonymous@anonymous.com	1975	dota 
108	kpq45	anonymous@anonymous.com	1976	path of exile
108	kpq45	anonymous@anonymous.com	1977	dota 
108	kpq45	anonymous@anonymous.com	1978	path of exile
108	kpq45	anonymous@anonymous.com	1979	dota 
108	kpq45	anonymous@anonymous.com	1980	path of exile
108	kpq45	anonymous@anonymous.com	1981	dota 
108	kpq45	anonymous@anonymous.com	1982	path of exile
108	kpq45	anonymous@anonymous.com	1983	dota 
108	kpq45	anonymous@anonymous.com	1984	path of exile
108	kpq45	anonymous@anonymous.com	1985	dota 
108	kpq45	anonymous@anonymous.com	1986	path of exile
108	kpq45	anonymous@anonymous.com	1987	dota 
108	kpq45	anonymous@anonymous.com	1988	path of exile
108	kpq45	anonymous@anonymous.com	1989	dota 
108	kpq45	anonymous@anonymous.com	1990	path of exile
108	kpq45	anonymous@anonymous.com	1991	dota 
108	kpq45	anonymous@anonymous.com	1992	path of exile
108	kpq45	anonymous@anonymous.com	1993	dota 
108	kpq45	anonymous@anonymous.com	1994	path of exile
108	kpq45	anonymous@anonymous.com	1995	dota 
108	kpq45	anonymous@anonymous.com	1996	path of exile
108	kpq45	anonymous@anonymous.com	1997	dota 
108	kpq45	anonymous@anonymous.com	1998	path of exile
108	kpq45	anonymous@anonymous.com	1999	dota 
108	kpq45	anonymous@anonymous.com	2000	path of exile
108	kpq45	anonymous@anonymous.com	2001	dota 
108	kpq45	anonymous@anonymous.com	2002	path of exile
108	kpq45	anonymous@anonymous.com	2003	dota 
108	kpq45	anonymous@anonymous.com	2004	path of exile
108	kpq45	anonymous@anonymous.com	2005	dota 
108	kpq45	anonymous@anonymous.com	2006	path of exile
108	kpq45	anonymous@anonymous.com	2007	dota 
108	kpq45	anonymous@anonymous.com	2008	path of exile
108	kpq45	anonymous@anonymous.com	2009	dota 
108	kpq45	anonymous@anonymous.com	2010	path of exile
108	kpq45	anonymous@anonymous.com	2011	dota 
108	kpq45	anonymous@anonymous.com	2012	path of exile
108	kpq45	anonymous@anonymous.com	2013	dota 
108	kpq45	anonymous@anonymous.com	2014	path of exile
108	kpq45	anonymous@anonymous.com	2015	dota 
108	kpq45	anonymous@anonymous.com	2016	path of exile
108	kpq45	anonymous@anonymous.com	2017	dota 
108	kpq45	anonymous@anonymous.com	2018	path of exile
108	kpq45	anonymous@anonymous.com	2019	dota 
108	kpq45	anonymous@anonymous.com	2020	path of exile
108	kpq45	anonymous@anonymous.com	2021	dota 
108	kpq45	anonymous@anonymous.com	2022	path of exile
108	kpq45	anonymous@anonymous.com	2023	dota 
108	kpq45	anonymous@anonymous.com	2024	path of exile
108	kpq45	anonymous@anonymous.com	2025	dota 
108	kpq45	anonymous@anonymous.com	2026	path of exile
108	kpq45	anonymous@anonymous.com	2027	dota 
108	kpq45	anonymous@anonymous.com	2028	path of exile
108	kpq45	anonymous@anonymous.com	2029	dota 
108	kpq45	anonymous@anonymous.com	2030	path of exile
108	kpq45	anonymous@anonymous.com	2031	dota 
108	kpq45	anonymous@anonymous.com	2032	path of exile
108	kpq45	anonymous@anonymous.com	2033	dota 
108	kpq45	anonymous@anonymous.com	2034	path of exile
108	kpq45	anonymous@anonymous.com	2035	dota 
108	kpq45	anonymous@anonymous.com	2036	path of exile
108	kpq45	anonymous@anonymous.com	2037	dota 
108	kpq45	anonymous@anonymous.com	2038	path of exile
108	kpq45	anonymous@anonymous.com	2039	dota 
108	kpq45	anonymous@anonymous.com	2040	path of exile
108	kpq45	anonymous@anonymous.com	2041	dota 
108	kpq45	anonymous@anonymous.com	2042	path of exile
108	kpq45	anonymous@anonymous.com	2043	dota 
108	kpq45	anonymous@anonymous.com	2044	path of exile
108	kpq45	anonymous@anonymous.com	2045	dota 
108	kpq45	anonymous@anonymous.com	2046	path of exile
108	kpq45	anonymous@anonymous.com	2047	dota 
108	kpq45	anonymous@anonymous.com	2048	path of exile
108	kpq45	anonymous@anonymous.com	2049	dota 
108	kpq45	anonymous@anonymous.com	2050	path of exile
108	kpq45	anonymous@anonymous.com	2051	dota 
108	kpq45	anonymous@anonymous.com	2052	path of exile
108	kpq45	anonymous@anonymous.com	2053	dota 
108	kpq45	anonymous@anonymous.com	2054	path of exile
108	kpq45	anonymous@anonymous.com	2055	dota 
108	kpq45	anonymous@anonymous.com	2056	path of exile
108	kpq45	anonymous@anonymous.com	2057	dota 
108	kpq45	anonymous@anonymous.com	2058	path of exile
108	kpq45	anonymous@anonymous.com	2059	dota 
108	kpq45	anonymous@anonymous.com	2060	path of exile
108	kpq45	anonymous@anonymous.com	2061	dota 
108	kpq45	anonymous@anonymous.com	2062	path of exile
108	kpq45	anonymous@anonymous.com	2063	dota 
108	kpq45	anonymous@anonymous.com	2064	path of exile
108	kpq45	anonymous@anonymous.com	2065	dota 
108	kpq45	anonymous@anonymous.com	2066	path of exile
108	kpq45	anonymous@anonymous.com	2067	dota 
108	kpq45	anonymous@anonymous.com	2068	path of exile
108	kpq45	anonymous@anonymous.com	2069	dota 
108	kpq45	anonymous@anonymous.com	2070	path of exile
108	kpq45	anonymous@anonymous.com	2071	dota 
108	kpq45	anonymous@anonymous.com	2072	path of exile
108	kpq45	anonymous@anonymous.com	2073	dota 
108	kpq45	anonymous@anonymous.com	2074	path of exile
108	kpq45	anonymous@anonymous.com	2075	dota 
108	kpq45	anonymous@anonymous.com	2076	path of exile
108	kpq45	anonymous@anonymous.com	2077	dota 
108	kpq45	anonymous@anonymous.com	2078	path of exile
108	kpq45	anonymous@anonymous.com	2079	dota 
108	kpq45	anonymous@anonymous.com	2080	path of exile
108	kpq45	anonymous@anonymous.com	2081	dota 
108	kpq45	anonymous@anonymous.com	2082	path of exile
108	kpq45	anonymous@anonymous.com	2083	dota 
108	kpq45	anonymous@anonymous.com	2084	path of exile
108	kpq45	anonymous@anonymous.com	2085	dota 
108	kpq45	anonymous@anonymous.com	2086	path of exile
108	kpq45	anonymous@anonymous.com	2087	dota 
108	kpq45	anonymous@anonymous.com	2088	path of exile
108	kpq45	anonymous@anonymous.com	2089	dota 
108	kpq45	anonymous@anonymous.com	2090	path of exile
108	kpq45	anonymous@anonymous.com	2091	dota 
108	kpq45	anonymous@anonymous.com	2092	path of exile
108	kpq45	anonymous@anonymous.com	2093	dota 
108	kpq45	anonymous@anonymous.com	2094	path of exile
108	kpq45	anonymous@anonymous.com	2095	dota 
108	kpq45	anonymous@anonymous.com	2096	path of exile
108	kpq45	anonymous@anonymous.com	2097	dota 
108	kpq45	anonymous@anonymous.com	2098	path of exile
108	kpq45	anonymous@anonymous.com	2099	dota 
108	kpq45	anonymous@anonymous.com	2100	path of exile
108	kpq45	anonymous@anonymous.com	2101	dota 
108	kpq45	anonymous@anonymous.com	2102	path of exile
108	kpq45	anonymous@anonymous.com	2103	dota 
108	kpq45	anonymous@anonymous.com	2104	path of exile
108	kpq45	anonymous@anonymous.com	2105	dota 
108	kpq45	anonymous@anonymous.com	2106	path of exile
108	kpq45	anonymous@anonymous.com	2107	dota 
108	kpq45	anonymous@anonymous.com	2108	path of exile
108	kpq45	anonymous@anonymous.com	2109	dota 
108	kpq45	anonymous@anonymous.com	2110	path of exile
108	kpq45	anonymous@anonymous.com	2111	dota 
108	kpq45	anonymous@anonymous.com	2112	path of exile
108	kpq45	anonymous@anonymous.com	2113	dota 
108	kpq45	anonymous@anonymous.com	2114	path of exile
108	kpq45	anonymous@anonymous.com	2115	dota 
108	kpq45	anonymous@anonymous.com	2116	path of exile
108	kpq45	anonymous@anonymous.com	2117	dota 
108	kpq45	anonymous@anonymous.com	2118	path of exile
108	kpq45	anonymous@anonymous.com	2119	dota 
108	kpq45	anonymous@anonymous.com	2120	path of exile
108	kpq45	anonymous@anonymous.com	2121	dota 
108	kpq45	anonymous@anonymous.com	2122	path of exile
108	kpq45	anonymous@anonymous.com	2123	dota 
108	kpq45	anonymous@anonymous.com	2124	path of exile
108	kpq45	anonymous@anonymous.com	2125	dota 
108	kpq45	anonymous@anonymous.com	2126	path of exile
108	kpq45	anonymous@anonymous.com	2127	dota 
108	kpq45	anonymous@anonymous.com	2128	path of exile
108	kpq45	anonymous@anonymous.com	2129	dota 
108	kpq45	anonymous@anonymous.com	2130	path of exile
108	kpq45	anonymous@anonymous.com	2131	dota 
108	kpq45	anonymous@anonymous.com	2132	path of exile
108	kpq45	anonymous@anonymous.com	2133	dota 
108	kpq45	anonymous@anonymous.com	2134	path of exile
108	kpq45	anonymous@anonymous.com	2135	dota 
108	kpq45	anonymous@anonymous.com	2136	path of exile
108	kpq45	anonymous@anonymous.com	2137	dota 
108	kpq45	anonymous@anonymous.com	2138	path of exile
108	kpq45	anonymous@anonymous.com	2139	dota 
108	kpq45	anonymous@anonymous.com	2140	path of exile
108	kpq45	anonymous@anonymous.com	2141	dota 
108	kpq45	anonymous@anonymous.com	2142	path of exile
108	kpq45	anonymous@anonymous.com	2143	dota 
108	kpq45	anonymous@anonymous.com	2144	path of exile
108	kpq45	anonymous@anonymous.com	2145	dota 
108	kpq45	anonymous@anonymous.com	2146	path of exile
108	kpq45	anonymous@anonymous.com	2147	dota 
108	kpq45	anonymous@anonymous.com	2148	path of exile
108	kpq45	anonymous@anonymous.com	2149	dota 
108	kpq45	anonymous@anonymous.com	2150	path of exile
108	kpq45	anonymous@anonymous.com	2151	dota 
108	kpq45	anonymous@anonymous.com	2152	path of exile
108	kpq45	anonymous@anonymous.com	2153	dota 
108	kpq45	anonymous@anonymous.com	2154	path of exile
108	kpq45	anonymous@anonymous.com	2155	dota 
108	kpq45	anonymous@anonymous.com	2156	path of exile
108	kpq45	anonymous@anonymous.com	2157	dota 
108	kpq45	anonymous@anonymous.com	2158	path of exile
108	kpq45	anonymous@anonymous.com	2159	dota 
108	kpq45	anonymous@anonymous.com	2160	path of exile
108	kpq45	anonymous@anonymous.com	2161	dota 
108	kpq45	anonymous@anonymous.com	2162	path of exile
108	kpq45	anonymous@anonymous.com	2163	dota 
108	kpq45	anonymous@anonymous.com	2164	path of exile
108	kpq45	anonymous@anonymous.com	2165	dota 
108	kpq45	anonymous@anonymous.com	2166	path of exile
108	kpq45	anonymous@anonymous.com	2167	dota 
108	kpq45	anonymous@anonymous.com	2168	path of exile
108	kpq45	anonymous@anonymous.com	2169	dota 
108	kpq45	anonymous@anonymous.com	2170	path of exile
108	kpq45	anonymous@anonymous.com	2171	dota 
108	kpq45	anonymous@anonymous.com	2172	path of exile
108	kpq45	anonymous@anonymous.com	2173	dota 
108	kpq45	anonymous@anonymous.com	2174	path of exile
108	kpq45	anonymous@anonymous.com	2175	dota 
108	kpq45	anonymous@anonymous.com	2176	path of exile
108	kpq45	anonymous@anonymous.com	2177	dota 
108	kpq45	anonymous@anonymous.com	2178	path of exile
108	kpq45	anonymous@anonymous.com	2179	dota 
108	kpq45	anonymous@anonymous.com	2180	path of exile
108	kpq45	anonymous@anonymous.com	2181	dota 
108	kpq45	anonymous@anonymous.com	2182	path of exile
108	kpq45	anonymous@anonymous.com	2183	dota 
108	kpq45	anonymous@anonymous.com	2184	path of exile
108	kpq45	anonymous@anonymous.com	2185	dota 
108	kpq45	anonymous@anonymous.com	2186	path of exile
108	kpq45	anonymous@anonymous.com	2187	dota 
108	kpq45	anonymous@anonymous.com	2188	path of exile
108	kpq45	anonymous@anonymous.com	2189	path of exile
108	kpq45	anonymous@anonymous.com	2190	path of exile
108	kpq45	anonymous@anonymous.com	2191	path of exile
108	kpq45	anonymous@anonymous.com	2192	path of exile
108	kpq45	anonymous@anonymous.com	2193	path of exile
108	kpq45	anonymous@anonymous.com	2194	path of exile
108	kpq45	anonymous@anonymous.com	2195	path of exile
108	kpq45	anonymous@anonymous.com	2196	path of exile
108	kpq45	anonymous@anonymous.com	2197	path of exile
108	kpq45	anonymous@anonymous.com	2198	path of exile
108	kpq45	anonymous@anonymous.com	2199	path of exile
108	kpq45	anonymous@anonymous.com	2200	path of exile
108	kpq45	anonymous@anonymous.com	2201	path of exile
108	kpq45	anonymous@anonymous.com	2202	path of exile
108	kpq45	anonymous@anonymous.com	2203	path of exile
108	kpq45	anonymous@anonymous.com	2204	path of exile
108	kpq45	anonymous@anonymous.com	2205	path of exile
108	kpq45	anonymous@anonymous.com	2206	path of exile
108	kpq45	anonymous@anonymous.com	2207	path of exile
108	kpq45	anonymous@anonymous.com	2208	path of exile
108	kpq45	anonymous@anonymous.com	2209	path of exile
108	kpq45	anonymous@anonymous.com	2210	path of exile
108	kpq45	anonymous@anonymous.com	2211	path of exile
108	kpq45	anonymous@anonymous.com	2212	path of exile
108	kpq45	anonymous@anonymous.com	2213	path of exile
108	kpq45	anonymous@anonymous.com	2214	path of exile
108	kpq45	anonymous@anonymous.com	2215	path of exile
108	kpq45	anonymous@anonymous.com	2216	path of exile
108	kpq45	anonymous@anonymous.com	2217	path of exile
108	kpq45	anonymous@anonymous.com	2218	path of exile
108	kpq45	anonymous@anonymous.com	2219	path of exile
108	kpq45	anonymous@anonymous.com	2220	path of exile
108	kpq45	anonymous@anonymous.com	2221	path of exile
108	kpq45	anonymous@anonymous.com	2222	path of exile
108	kpq45	anonymous@anonymous.com	2223	path of exile
108	kpq45	anonymous@anonymous.com	2224	path of exile
108	kpq45	anonymous@anonymous.com	2225	path of exile
108	kpq45	anonymous@anonymous.com	2226	path of exile
108	kpq45	anonymous@anonymous.com	2227	path of exile
108	kpq45	anonymous@anonymous.com	2228	path of exile
108	kpq45	anonymous@anonymous.com	2229	path of exile
108	kpq45	anonymous@anonymous.com	2230	path of exile
108	kpq45	anonymous@anonymous.com	2231	path of exile
108	kpq45	anonymous@anonymous.com	2232	path of exile
108	kpq45	anonymous@anonymous.com	2233	path of exile
108	kpq45	anonymous@anonymous.com	2234	path of exile
108	kpq45	anonymous@anonymous.com	2235	path of exile
108	kpq45	anonymous@anonymous.com	2236	path of exile
108	kpq45	anonymous@anonymous.com	2237	path of exile
108	kpq45	anonymous@anonymous.com	2238	path of exile
108	kpq45	anonymous@anonymous.com	2239	path of exile
108	kpq45	anonymous@anonymous.com	2240	path of exile
108	kpq45	anonymous@anonymous.com	2241	path of exile
108	kpq45	anonymous@anonymous.com	2242	path of exile
108	kpq45	anonymous@anonymous.com	2243	path of exile
108	kpq45	anonymous@anonymous.com	2244	path of exile
108	kpq45	anonymous@anonymous.com	2245	path of exile
108	kpq45	anonymous@anonymous.com	2246	path of exile
108	kpq45	anonymous@anonymous.com	2247	path of exile
108	kpq45	anonymous@anonymous.com	2248	path of exile
108	kpq45	anonymous@anonymous.com	2249	path of exile
108	kpq45	anonymous@anonymous.com	2250	path of exile
108	kpq45	anonymous@anonymous.com	2251	path of exile
108	kpq45	anonymous@anonymous.com	2252	path of exile
108	kpq45	anonymous@anonymous.com	2253	path of exile
108	kpq45	anonymous@anonymous.com	2254	path of exile
108	kpq45	anonymous@anonymous.com	2255	path of exile
108	kpq45	anonymous@anonymous.com	2256	path of exile
108	kpq45	anonymous@anonymous.com	2257	path of exile
108	kpq45	anonymous@anonymous.com	2258	path of exile
108	kpq45	anonymous@anonymous.com	2259	path of exile
108	kpq45	anonymous@anonymous.com	2260	path of exile
108	kpq45	anonymous@anonymous.com	2261	path of exile
108	kpq45	anonymous@anonymous.com	2262	path of exile
108	kpq45	anonymous@anonymous.com	2263	path of exile
108	kpq45	anonymous@anonymous.com	2264	path of exile
108	kpq45	anonymous@anonymous.com	2265	path of exile
108	kpq45	anonymous@anonymous.com	2266	path of exile
108	kpq45	anonymous@anonymous.com	2267	path of exile
108	kpq45	anonymous@anonymous.com	2268	path of exile
108	kpq45	anonymous@anonymous.com	2269	path of exile
108	kpq45	anonymous@anonymous.com	2270	path of exile
108	kpq45	anonymous@anonymous.com	2271	path of exile
108	kpq45	anonymous@anonymous.com	2272	path of exile
108	kpq45	anonymous@anonymous.com	2273	path of exile
108	kpq45	anonymous@anonymous.com	2274	path of exile
108	kpq45	anonymous@anonymous.com	2275	path of exile
108	kpq45	anonymous@anonymous.com	2276	path of exile
108	kpq45	anonymous@anonymous.com	2277	path of exile
108	kpq45	anonymous@anonymous.com	2278	path of exile
108	kpq45	anonymous@anonymous.com	2279	path of exile
108	kpq45	anonymous@anonymous.com	2280	path of exile
108	kpq45	anonymous@anonymous.com	2281	path of exile
108	kpq45	anonymous@anonymous.com	2282	path of exile
108	kpq45	anonymous@anonymous.com	2283	path of exile
108	kpq45	anonymous@anonymous.com	2284	path of exile
108	kpq45	anonymous@anonymous.com	2285	path of exile
108	kpq45	anonymous@anonymous.com	2286	path of exile
108	kpq45	anonymous@anonymous.com	2287	path of exile
108	kpq45	anonymous@anonymous.com	2288	path of exile
108	kpq45	anonymous@anonymous.com	2289	path of exile
108	kpq45	anonymous@anonymous.com	2290	path of exile
108	kpq45	anonymous@anonymous.com	2291	path of exile
108	kpq45	anonymous@anonymous.com	2292	path of exile
108	kpq45	anonymous@anonymous.com	2293	path of exile
108	kpq45	anonymous@anonymous.com	2294	path of exile
108	kpq45	anonymous@anonymous.com	2295	path of exile
108	kpq45	anonymous@anonymous.com	2296	path of exile
108	kpq45	anonymous@anonymous.com	2297	path of exile
108	kpq45	anonymous@anonymous.com	2298	path of exile
108	kpq45	anonymous@anonymous.com	2299	path of exile
108	kpq45	anonymous@anonymous.com	2300	path of exile
108	kpq45	anonymous@anonymous.com	2301	path of exile
108	kpq45	anonymous@anonymous.com	2302	path of exile
108	kpq45	anonymous@anonymous.com	2303	path of exile
108	kpq45	anonymous@anonymous.com	2304	path of exile
108	kpq45	anonymous@anonymous.com	2305	path of exile
108	kpq45	anonymous@anonymous.com	2306	path of exile
108	kpq45	anonymous@anonymous.com	2307	path of exile
108	kpq45	anonymous@anonymous.com	2308	path of exile
108	kpq45	anonymous@anonymous.com	2309	path of exile
108	kpq45	anonymous@anonymous.com	2310	path of exile
108	kpq45	anonymous@anonymous.com	2311	path of exile
108	kpq45	anonymous@anonymous.com	2312	path of exile
108	kpq45	anonymous@anonymous.com	2313	path of exile
108	kpq45	anonymous@anonymous.com	2314	path of exile
108	kpq45	anonymous@anonymous.com	2315	path of exile
108	kpq45	anonymous@anonymous.com	2316	path of exile
108	kpq45	anonymous@anonymous.com	2317	path of exile
108	kpq45	anonymous@anonymous.com	2318	path of exile
108	kpq45	anonymous@anonymous.com	2319	path of exile
108	kpq45	anonymous@anonymous.com	2320	path of exile
108	kpq45	anonymous@anonymous.com	2321	path of exile
108	kpq45	anonymous@anonymous.com	2322	path of exile
108	kpq45	anonymous@anonymous.com	2323	path of exile
108	kpq45	anonymous@anonymous.com	2324	path of exile
108	kpq45	anonymous@anonymous.com	2325	path of exile
108	kpq45	anonymous@anonymous.com	2326	path of exile
108	kpq45	anonymous@anonymous.com	2327	path of exile
108	kpq45	anonymous@anonymous.com	2328	path of exile
108	kpq45	anonymous@anonymous.com	2329	path of exile
108	kpq45	anonymous@anonymous.com	2330	path of exile
108	kpq45	anonymous@anonymous.com	2331	path of exile
108	kpq45	anonymous@anonymous.com	2332	path of exile
108	kpq45	anonymous@anonymous.com	2333	path of exile
108	kpq45	anonymous@anonymous.com	2334	path of exile
108	kpq45	anonymous@anonymous.com	2335	path of exile
108	kpq45	anonymous@anonymous.com	2336	path of exile
108	kpq45	anonymous@anonymous.com	2337	path of exile
108	kpq45	anonymous@anonymous.com	2338	path of exile
108	kpq45	anonymous@anonymous.com	2339	path of exile
108	kpq45	anonymous@anonymous.com	2340	path of exile
108	kpq45	anonymous@anonymous.com	2341	path of exile
108	kpq45	anonymous@anonymous.com	2342	path of exile
108	kpq45	anonymous@anonymous.com	2343	path of exile
108	kpq45	anonymous@anonymous.com	2344	path of exile
108	kpq45	anonymous@anonymous.com	2345	path of exile
108	kpq45	anonymous@anonymous.com	2346	path of exile
108	kpq45	anonymous@anonymous.com	2347	path of exile
108	kpq45	anonymous@anonymous.com	2348	path of exile
108	kpq45	anonymous@anonymous.com	2349	path of exile
108	kpq45	anonymous@anonymous.com	2350	path of exile
108	kpq45	anonymous@anonymous.com	2351	path of exile
108	kpq45	anonymous@anonymous.com	2352	path of exile
108	kpq45	anonymous@anonymous.com	2353	path of exile
108	kpq45	anonymous@anonymous.com	2354	path of exile
108	kpq45	anonymous@anonymous.com	2355	path of exile
108	kpq45	anonymous@anonymous.com	2356	path of exile
108	kpq45	anonymous@anonymous.com	2357	path of exile
108	kpq45	anonymous@anonymous.com	2358	path of exile
108	kpq45	anonymous@anonymous.com	2359	path of exile
108	kpq45	anonymous@anonymous.com	2360	path of exile
108	kpq45	anonymous@anonymous.com	2361	path of exile
108	kpq45	anonymous@anonymous.com	2362	path of exile
108	kpq45	anonymous@anonymous.com	2363	path of exile
108	kpq45	anonymous@anonymous.com	2364	path of exile
108	kpq45	anonymous@anonymous.com	2365	path of exile
108	kpq45	anonymous@anonymous.com	2366	path of exile
108	kpq45	anonymous@anonymous.com	2367	path of exile
108	kpq45	anonymous@anonymous.com	2368	path of exile
108	kpq45	anonymous@anonymous.com	2369	path of exile
108	kpq45	anonymous@anonymous.com	2370	path of exile
108	kpq45	anonymous@anonymous.com	2371	path of exile
108	kpq45	anonymous@anonymous.com	2372	path of exile
108	kpq45	anonymous@anonymous.com	2373	path of exile
108	kpq45	anonymous@anonymous.com	2374	path of exile
108	kpq45	anonymous@anonymous.com	2375	path of exile
108	kpq45	anonymous@anonymous.com	2376	path of exile
108	kpq45	anonymous@anonymous.com	2377	path of exile
108	kpq45	anonymous@anonymous.com	2378	path of exile
108	kpq45	anonymous@anonymous.com	2379	path of exile
108	kpq45	anonymous@anonymous.com	2380	path of exile
108	kpq45	anonymous@anonymous.com	2381	path of exile
108	kpq45	anonymous@anonymous.com	2382	path of exile
108	kpq45	anonymous@anonymous.com	2383	path of exile
108	kpq45	anonymous@anonymous.com	2384	path of exile
108	kpq45	anonymous@anonymous.com	2385	path of exile
108	kpq45	anonymous@anonymous.com	2386	path of exile
108	kpq45	anonymous@anonymous.com	2387	path of exile
108	kpq45	anonymous@anonymous.com	2388	path of exile
108	kpq45	anonymous@anonymous.com	2389	path of exile
108	kpq45	anonymous@anonymous.com	2390	path of exile
108	kpq45	anonymous@anonymous.com	2391	path of exile
108	kpq45	anonymous@anonymous.com	2392	path of exile
108	kpq45	anonymous@anonymous.com	2393	path of exile
108	kpq45	anonymous@anonymous.com	2394	path of exile
108	kpq45	anonymous@anonymous.com	2395	path of exile
108	kpq45	anonymous@anonymous.com	2396	path of exile
108	kpq45	anonymous@anonymous.com	2397	path of exile
108	kpq45	anonymous@anonymous.com	2398	path of exile
108	kpq45	anonymous@anonymous.com	2399	path of exile
108	kpq45	anonymous@anonymous.com	2400	path of exile
108	kpq45	anonymous@anonymous.com	2401	path of exile
108	kpq45	anonymous@anonymous.com	2402	path of exile
108	kpq45	anonymous@anonymous.com	2403	path of exile
108	kpq45	anonymous@anonymous.com	2404	path of exile
108	kpq45	anonymous@anonymous.com	2405	path of exile
108	kpq45	anonymous@anonymous.com	2406	path of exile
108	kpq45	anonymous@anonymous.com	2407	path of exile
108	kpq45	anonymous@anonymous.com	2408	path of exile
108	kpq45	anonymous@anonymous.com	2409	path of exile
108	kpq45	anonymous@anonymous.com	2410	path of exile
108	kpq45	anonymous@anonymous.com	2411	path of exile
108	kpq45	anonymous@anonymous.com	2412	path of exile
108	kpq45	anonymous@anonymous.com	2413	path of exile
108	kpq45	anonymous@anonymous.com	2414	path of exile
108	kpq45	anonymous@anonymous.com	2415	path of exile
108	kpq45	anonymous@anonymous.com	2416	path of exile
108	kpq45	anonymous@anonymous.com	2417	path of exile
108	kpq45	anonymous@anonymous.com	2418	path of exile
108	kpq45	anonymous@anonymous.com	2419	path of exile
108	kpq45	anonymous@anonymous.com	2420	path of exile
108	kpq45	anonymous@anonymous.com	2421	path of exile
108	kpq45	anonymous@anonymous.com	2422	path of exile
108	kpq45	anonymous@anonymous.com	2423	path of exile
108	kpq45	anonymous@anonymous.com	2424	path of exile
108	kpq45	anonymous@anonymous.com	2425	path of exile
108	kpq45	anonymous@anonymous.com	2426	path of exile
108	kpq45	anonymous@anonymous.com	2427	path of exile
108	kpq45	anonymous@anonymous.com	2428	path of exile
108	kpq45	anonymous@anonymous.com	2429	path of exile
108	kpq45	anonymous@anonymous.com	2430	path of exile
108	kpq45	anonymous@anonymous.com	2431	path of exile
108	kpq45	anonymous@anonymous.com	2432	path of exile
108	kpq45	anonymous@anonymous.com	2433	path of exile
108	kpq45	anonymous@anonymous.com	2434	path of exile
108	kpq45	anonymous@anonymous.com	2435	path of exile
108	kpq45	anonymous@anonymous.com	2436	path of exile
108	kpq45	anonymous@anonymous.com	2437	path of exile
108	kpq45	anonymous@anonymous.com	2438	path of exile
108	kpq45	anonymous@anonymous.com	2439	path of exile
108	kpq45	anonymous@anonymous.com	2440	path of exile
108	kpq45	anonymous@anonymous.com	2441	path of exile
108	kpq45	anonymous@anonymous.com	2442	path of exile
108	kpq45	anonymous@anonymous.com	2443	path of exile
108	kpq45	anonymous@anonymous.com	2444	path of exile
108	kpq45	anonymous@anonymous.com	2445	path of exile
108	kpq45	anonymous@anonymous.com	2446	path of exile
108	kpq45	anonymous@anonymous.com	2447	path of exile
108	kpq45	anonymous@anonymous.com	2448	path of exile
108	kpq45	anonymous@anonymous.com	2449	path of exile
108	kpq45	anonymous@anonymous.com	2450	path of exile
108	kpq45	anonymous@anonymous.com	2451	path of exile
108	kpq45	anonymous@anonymous.com	2452	path of exile
108	kpq45	anonymous@anonymous.com	2453	path of exile
108	kpq45	anonymous@anonymous.com	2454	path of exile
108	kpq45	anonymous@anonymous.com	2455	path of exile
108	kpq45	anonymous@anonymous.com	2456	path of exile
108	kpq45	anonymous@anonymous.com	2457	path of exile
108	kpq45	anonymous@anonymous.com	2458	path of exile
108	kpq45	anonymous@anonymous.com	2459	path of exile
108	kpq45	anonymous@anonymous.com	2460	path of exile
108	kpq45	anonymous@anonymous.com	2461	path of exile
108	kpq45	anonymous@anonymous.com	2462	path of exile
108	kpq45	anonymous@anonymous.com	2463	path of exile
108	kpq45	anonymous@anonymous.com	2464	path of exile
108	kpq45	anonymous@anonymous.com	2465	path of exile
103	afiln	anonymous@anonymous.com	2466	Should could tie a cherry stem into a knot with her tongue.
104	afiln	anonymous@anonymous.com	2467	Kali
105	afiln	anonymous@anonymous.com	2468	purple
106	afiln	anonymous@anonymous.com	2469	Robert Redford
107	afiln	anonymous@anonymous.com	2470	His whip
103	afiln	anonymous@anonymous.com	2471	She could sing like an angel.
104	afiln	anonymous@anonymous.com	2472	Kali
105	afiln	anonymous@anonymous.com	2473	red
105	afiln	anonymous@anonymous.com	2474	polo
106	afiln	anonymous@anonymous.com	2475	Norm MacDonald
107	afiln	anonymous@anonymous.com	2476	His whip
108	kpq45	zillionk1973@gmail.com	2477	dota 
103	afiln	anonymous@anonymous.com	2478	She could apply lipstick with her breasts.
104	afiln	anonymous@anonymous.com	2479	Buddha
105	afiln	anonymous@anonymous.com	2480	calvin klein
106	afiln	anonymous@anonymous.com	2481	Charlie Sheen
107	afiln	anonymous@anonymous.com	2482	A colt .45
108	kpq45	anonymous@anonymous.com	2483	path of exile
99	dhjr4	anonymous@anonymous.com	2484	Ps4
100	dhjr4	anonymous@anonymous.com	2485	2
108	kpq45	anonymous@anonymous.com	2486	path of exile
108	kpq45	anonymous@anonymous.com	2487	dota 
108	kpq45	anonymous@anonymous.com	2488	path of exile
96	x3489	anonymous@anonymous.com	2489	yes
97	x3489	anonymous@anonymous.com	2490	meow
98	x3489	anonymous@anonymous.com	2491	The paws.
96	x3489	anonymous@anonymous.com	2492	DOGS
97	x3489	anonymous@anonymous.com	2493	quack
98	x3489	anonymous@anonymous.com	2494	That I don't have one
109	iotu1	fafmaster@hotmail.com	2495	fsadfsd
91	twx29	anonymous@anonymous.com	2496	Very Easy
92	twx29	anonymous@anonymous.com	2497	Page layout is not easy to navigate
92	twx29	anonymous@anonymous.com	2498	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	2499	Yes!
103	afiln	anonymous@anonymous.com	2500	She could apply lipstick with her breasts.
104	afiln	anonymous@anonymous.com	2501	Kali
105	afiln	anonymous@anonymous.com	2502	blue
105	afiln	anonymous@anonymous.com	2503	calvin klein
106	afiln	anonymous@anonymous.com	2504	Charlie Sheen
107	afiln	anonymous@anonymous.com	2505	His whip
111	hsv78	anonymous@anonymous.com	2506	hey you
111	hsv78	anonymous@anonymous.com	2507	kali
111	hsv78	anonymous@anonymous.com	2508	he
108	kpq45	anonymous@anonymous.com	2509	dota 
105	afiln	anonymous@anonymous.com	2510	blue
105	afiln	anonymous@anonymous.com	2511	red
105	afiln	anonymous@anonymous.com	2512	purple
105	afiln	anonymous@anonymous.com	2513	calvin klein
105	afiln	anonymous@anonymous.com	2514	polo
106	afiln	anonymous@anonymous.com	2515	Kevin Spacey
107	afiln	anonymous@anonymous.com	2516	His whip
91	twx29	anonymous@anonymous.com	2517	This site is garbage
92	twx29	anonymous@anonymous.com	2518	The color scheme is gross
92	twx29	anonymous@anonymous.com	2519	The buttons look bad
92	twx29	anonymous@anonymous.com	2520	The drop menus are a bad idea
92	twx29	anonymous@anonymous.com	2521	Page layout is not easy to navigate
93	twx29	anonymous@anonymous.com	2522	Never!
94	twx29	anonymous@anonymous.com	2523	my momma.. my momma... my my my.. my momma said. my momma said jquery mobile is the devil.
72	drx06	fafmaster@hotmail.com	2524	yes
96	x3489	fafmaster@hotmail.com	2525	yes
97	x3489	fafmaster@hotmail.com	2526	meow
98	x3489	fafmaster@hotmail.com	2527	They jump really high
110	abfm7	anonymous@anonymous.com	2528	youre a wizard harry. youre a hairy wizard
91	twx29	anonymous@anonymous.com	2529	Very Easy
92	twx29	anonymous@anonymous.com	2530	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	2531	Yes!
94	twx29	anonymous@anonymous.com	2532	the Wizard background is the dealmaker. Whoever drew that must have incredible hands.
103	afiln	anonymous@anonymous.com	2533	She could sing like an angel.
104	afiln	anonymous@anonymous.com	2534	Kali
105	afiln	anonymous@anonymous.com	2535	blue
105	afiln	anonymous@anonymous.com	2536	red
105	afiln	anonymous@anonymous.com	2537	purple
106	afiln	anonymous@anonymous.com	2538	Robert Redford
107	afiln	anonymous@anonymous.com	2539	His whit
112	drsz1	anonymous@anonymous.com	2540	Worf
113	drsz1	anonymous@anonymous.com	2541	Seven
114	drsz1	anonymous@anonymous.com	2542	Flox
115	drsz1	anonymous@anonymous.com	2543	Janeway
103	afiln	fafmaster@hotmail.com	2544	Should could tie a cherry stem into a knot with her tongue.
107	afiln	fafmaster@hotmail.com	2545	His whit
112	drsz1	anonymous@anonymous.com	2546	Worf
113	drsz1	anonymous@anonymous.com	2547	Seven
114	drsz1	anonymous@anonymous.com	2548	Flox
115	drsz1	anonymous@anonymous.com	2549	Sisco
112	drsz1	fafmaster@hotmail.com	2550	Worf
113	drsz1	fafmaster@hotmail.com	2551	Seven
114	drsz1	fafmaster@hotmail.com	2552	Neelix
115	drsz1	fafmaster@hotmail.com	2553	Sisco
91	twx29	anonymous@anonymous.com	2554	Very Easy
92	twx29	anonymous@anonymous.com	2555	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	2556	Yes!
94	twx29	anonymous@anonymous.com	2557	This is magnificent
112	drsz1	anonymous@anonymous.com	2558	Worf
113	drsz1	anonymous@anonymous.com	2559	Seven
114	drsz1	anonymous@anonymous.com	2560	Neelix
115	drsz1	anonymous@anonymous.com	2561	Sisco
112	drsz1	anonymous@anonymous.com	2562	Worf
113	drsz1	anonymous@anonymous.com	2563	Seven
114	drsz1	anonymous@anonymous.com	2564	Neelix
115	drsz1	anonymous@anonymous.com	2565	Sisco
112	drsz1	anonymous@anonymous.com	2566	Worf
113	drsz1	anonymous@anonymous.com	2567	Seven
114	drsz1	anonymous@anonymous.com	2568	Neelix
115	drsz1	anonymous@anonymous.com	2569	Sisco
112	drsz1	anonymous@anonymous.com	2570	Worf
113	drsz1	anonymous@anonymous.com	2571	Seven
114	drsz1	anonymous@anonymous.com	2572	Neelix
115	drsz1	anonymous@anonymous.com	2573	Sisco
112	drsz1	anonymous@anonymous.com	2574	Worf
113	drsz1	anonymous@anonymous.com	2575	Seven
114	drsz1	anonymous@anonymous.com	2576	Neelix
115	drsz1	anonymous@anonymous.com	2577	Sisco
112	drsz1	anonymous@anonymous.com	2578	Worf
113	drsz1	anonymous@anonymous.com	2579	Seven
114	drsz1	anonymous@anonymous.com	2580	Neelix
115	drsz1	anonymous@anonymous.com	2581	Sisco
112	drsz1	anonymous@anonymous.com	2582	Worf
113	drsz1	anonymous@anonymous.com	2583	Seven
114	drsz1	anonymous@anonymous.com	2584	Neelix
115	drsz1	anonymous@anonymous.com	2585	Sisco
112	drsz1	anonymous@anonymous.com	2586	Worf
113	drsz1	anonymous@anonymous.com	2587	Seven
114	drsz1	anonymous@anonymous.com	2588	Neelix
115	drsz1	anonymous@anonymous.com	2589	Sisco
112	drsz1	anonymous@anonymous.com	2590	Worf
113	drsz1	anonymous@anonymous.com	2591	Seven
114	drsz1	anonymous@anonymous.com	2592	Neelix
115	drsz1	anonymous@anonymous.com	2593	Sisco
112	drsz1	anonymous@anonymous.com	2594	Worf
113	drsz1	anonymous@anonymous.com	2595	Seven
114	drsz1	anonymous@anonymous.com	2596	Neelix
115	drsz1	anonymous@anonymous.com	2597	Sisco
112	drsz1	anonymous@anonymous.com	2598	Worf
113	drsz1	anonymous@anonymous.com	2599	Seven
114	drsz1	anonymous@anonymous.com	2600	Neelix
115	drsz1	anonymous@anonymous.com	2601	Sisco
112	drsz1	anonymous@anonymous.com	2602	Worf
113	drsz1	anonymous@anonymous.com	2603	Seven
114	drsz1	anonymous@anonymous.com	2604	Neelix
115	drsz1	anonymous@anonymous.com	2605	Sisco
112	drsz1	anonymous@anonymous.com	2606	Worf
113	drsz1	anonymous@anonymous.com	2607	Seven
114	drsz1	anonymous@anonymous.com	2608	Neelix
115	drsz1	anonymous@anonymous.com	2609	Sisco
112	drsz1	anonymous@anonymous.com	2610	Worf
113	drsz1	anonymous@anonymous.com	2611	Seven
114	drsz1	anonymous@anonymous.com	2612	Neelix
115	drsz1	anonymous@anonymous.com	2613	Sisco
112	drsz1	anonymous@anonymous.com	2614	Worf
113	drsz1	anonymous@anonymous.com	2615	Seven
114	drsz1	anonymous@anonymous.com	2616	Neelix
115	drsz1	anonymous@anonymous.com	2617	Sisco
112	drsz1	anonymous@anonymous.com	2618	Worf
113	drsz1	anonymous@anonymous.com	2619	Seven
114	drsz1	anonymous@anonymous.com	2620	Neelix
115	drsz1	anonymous@anonymous.com	2621	Sisco
112	drsz1	anonymous@anonymous.com	2622	Worf
113	drsz1	anonymous@anonymous.com	2623	Seven
114	drsz1	anonymous@anonymous.com	2624	Neelix
115	drsz1	anonymous@anonymous.com	2625	Sisco
112	drsz1	anonymous@anonymous.com	2626	Worf
113	drsz1	anonymous@anonymous.com	2627	Seven
114	drsz1	anonymous@anonymous.com	2628	Neelix
115	drsz1	anonymous@anonymous.com	2629	Sisco
112	drsz1	anonymous@anonymous.com	2630	Worf
113	drsz1	anonymous@anonymous.com	2631	Seven
114	drsz1	anonymous@anonymous.com	2632	Neelix
115	drsz1	anonymous@anonymous.com	2633	Sisco
112	drsz1	anonymous@anonymous.com	2634	Worf
113	drsz1	anonymous@anonymous.com	2635	Seven
114	drsz1	anonymous@anonymous.com	2636	Neelix
115	drsz1	anonymous@anonymous.com	2637	Sisco
112	drsz1	anonymous@anonymous.com	2638	Worf
113	drsz1	anonymous@anonymous.com	2639	Seven
114	drsz1	anonymous@anonymous.com	2640	Neelix
115	drsz1	anonymous@anonymous.com	2641	Sisco
112	drsz1	anonymous@anonymous.com	2642	Worf
113	drsz1	anonymous@anonymous.com	2643	Seven
114	drsz1	anonymous@anonymous.com	2644	Neelix
115	drsz1	anonymous@anonymous.com	2645	Sisco
112	drsz1	anonymous@anonymous.com	2646	Worf
113	drsz1	anonymous@anonymous.com	2647	Seven
114	drsz1	anonymous@anonymous.com	2648	Neelix
115	drsz1	anonymous@anonymous.com	2649	Sisco
112	drsz1	anonymous@anonymous.com	2650	Worf
113	drsz1	anonymous@anonymous.com	2651	Seven
114	drsz1	anonymous@anonymous.com	2652	Neelix
115	drsz1	anonymous@anonymous.com	2653	Sisco
112	drsz1	anonymous@anonymous.com	2654	Worf
113	drsz1	anonymous@anonymous.com	2655	Seven
114	drsz1	anonymous@anonymous.com	2656	Neelix
115	drsz1	anonymous@anonymous.com	2657	Janeway
91	twx29	anonymous@anonymous.com	2658	Very Easy
92	twx29	anonymous@anonymous.com	2659	The drop menus are a bad idea
92	twx29	anonymous@anonymous.com	2660	This site is perfect. You guys are all perfect.
93	twx29	anonymous@anonymous.com	2661	Yes!
94	twx29	anonymous@anonymous.com	2662	watch out for bobby tables
83	afgs5	anonymous@anonymous.com	2663	test indeed
84	afgs5	anonymous@anonymous.com	2664	so many tests... so little thyme
96	x3489	anonymous@anonymous.com	2665	yes
97	x3489	anonymous@anonymous.com	2666	meow
98	x3489	anonymous@anonymous.com	2667	.
96	x3489	anonymous@anonymous.com	2668	yes
97	x3489	anonymous@anonymous.com	2669	meow
98	x3489	anonymous@anonymous.com	2670	.
116	bdehl	nallelcm@gmail.com	2671	Magpie
117	bdehl	nallelcm@gmail.com	2672	because they are the best..
118	bdehl	nallelcm@gmail.com	2673	much
119	bdehl	nallelcm@gmail.com	2674	There are numerous subspecies. The northwest African race differs in having a patch of blue bare skin around the eye, no white patch on the rump and an unglossed tail. The southwest Arabian race differs in being smaller, with dull black plumage lacking iridescent tones, and minimal white in the wings. The Siberian races have more extensive white in the wings, and brilliant green iridescence; Korean birds have a purple gloss instead and relatively longer wings and a shorter tail. Analysis of mtDNA sequences[4] has indicated that the Korean race, P. pica sericea, is very distinct from the other Eurasian forms, and may be a separate species. The North American Black-billed Magpie which looks almost identical to the Eurasian form and was previously considered conspecific is genetically closer to the Yellow-billed Magpie. The main Eurasian lineages of this astoundingly variable species have not been sufficiently sampled to clarify the status of such forms as the northwest African race P. p. mauretanica and the southwest Arabian race P. p. asirensis, which could also be distinct species. A larger palaeosubspecies of the European Magpie was described as Pica pica major. Etymology[edit] The common name comes from magot pie (pied Margot), first found[5] in Shakespeare's Macbeth.[6] The scientific name Pica is just the Latin word for Magpie.[7] When Linnaeus first described this species in 1758, he named it Corvus pica.[8] Description[edit]    In flight The Eurasian Magpie is 44–46 centimetres (17–18 in) in length - in the adult over 50% of this is tail - and a wingspan of 52–62 centimetres (20–24 in).[9] Its head, neck and breast are glossy black with a metallic green and violet sheen; the belly and scapulars (shoulder feathers) are pure white; the wings are black glossed with green or purple, and the primaries have white inner webs, conspicuous when the wing is open. The graduated tail is black, shot with bronze-green and other iridescent colours. The legs and bill are black. The young resemble the adults, but are at first without much of the gloss on the sooty plumage. The male is slightly larger than the female.[9] Behaviour and ecology[edit]   This section needs additional citations for verification. Please help improve this article by adding citations to reliable sources. Unsourced material may be challenged and removed. (January 2011)   Perching in a mountain ash tree in Manchester, England The Eurasian Magpie is a distinctive species with pied plumage, long 20–30 centimetres (8–12 in) graduated tail, and loud chatter. When passing in open country they rapidly move their wings and chatter. Upon landing the long tail is elevated and carefully carried clear of the ground. Like other corvids such as crows, the Magpie usually walks, but can also hop quickly sideways with wings slightly opened. They are fond of bright objects.[citation needed]   In West Drayton, London The Magpie is omnivorous, eating young birds and eggs, insects, scraps and carrion, acorns, grain, and other vegetable substances. Magpies are common in suburban areas[10] but tend toward shyness and caution in the country. They only avoid humans when harassed. Sometimes two or more birds appear to "tease" other animals, such as cats, a behaviour thought to scare away potential predators and egg thieves.[citation needed]   A young European Magpie, not yet fledge. In winter Magpies often form groups, feeding and roosting at night. Early in the year large numbers gather for mating in groups Charles Darwin described as "marriage meetings".[citation needed] Magpies have been observed taking small songbirds in flight, a behaviour once thought unique to birds of prey.[citation needed] Reproduction[edit] Magpies are territorial and stay in theirs all year, even in the north of the species range. The pairs are monogamous and remain together for life, finding new partners from the stock of yearlings if one is lost. Mating takes place in spring. In the courtship display males rapidly raise and depress their head feathers, uplift, open and close their tails like fans, and call in soft tones quite distinct from their usual chatter. The loose feathers of the flanks are brought over the primaries, and the shoulder patch is spread so the white is conspicuous, presumably to attract females. Short buoyant flights and chases follow.   Egg of Eurasian Magpie Magpies prefer tall trees for their bulky nest, firmly attaching them to a central fork in the upper branches. A framework of the sticks is cemented with earth and clay, and a lining of the same is covered with fine roots. Above is a stout though loosely built dome of prickly branches with a single well-concealed entrance. These huge nests are conspicuous when the leaves fall. Where trees are scarce, though even in well-wooded country, nests are at times built in bushes and hedgerows. Eggs are typically laid in April, five to eight is normal though as many as ten have been recorded. Small for the size of the bird, they are typically blue-green with close specks and spots of brown and grey, but show much variation in ground and marking. Only one brood is reared unless disaster overtakes the first clutch. Intelligence[edit] The Eurasian Magpie is believed not only to be among the brightest of birds but among the most intelligent of all animals. Magpies have been observed engaging in elaborate social rituals, possibly including the expression of grief.[11] Mirror self-recognition has been demonstrated in European magpies,[12] making them one but a few species and the only non-mammal known to possess this capability.[13] The cognitive abilities of the Eurasian Magpie are regarded as evidence that intelligence evolved independently in both corvids and primates. This is indicated by tool use, an ability to hide and store food across seasons, episodic memory, using their own experience to predict the behavior of conspecifics.[2] Another behavior exhibiting intelligence is cutting their food in correctly sized proportions for the size of their young. In captivity magpies have been observed counting up to get food, imitating human voices, and regularly using tools to clean their own cages.[citation needed] In the wild, they organise themselves into gangs and use complex strategies hunting other birds and when confronted by predators.[14] Along with the Jackdaw, the Eurasian Magpie's nidopallium is approximately the same relative size as those in chimpanzees and humans, significantly larger than the gibbon's.[3] Like other corvids, such as Ravens and Crows, their total Brain-to-body mass ratio is equal to most great apes' and cetaceans.'[15] Relationship with humans[edit]  Traditions[edit] In European folklore the magpie is associated with a number of superstitions[16] surrounding its reputation as an omen of ill fortune. This reputation may derive from the bird's widely believed tendency to "steal" shiny objects or its aggressive behaviour toward favoured songbirds. In the 19th century book, A Guide to the Scientific Knowledge of Things Familiar, a proverb concerning magpies is recited: "A single magpie in spring, foul weather will bring". The book further explains that this superstition arises from the habits of pairs of magpies to forage together only when the weather is fine. In Scotland, a magpie near the window of the house foretells death.[17]   A hopscotch game with the Magpie rhyme In both Italian and French folklore, magpies' penchant for picking up shiny items is thought to be particularly directed towards precious stones. Rossini's opera La gazza ladra and The Adventures of Tintin comic The Castafiore Emerald are based on this theme. In Bulgarian, Czech, German, Hungarian, Polish and Swedish folklore the magpie is also seen as a thief. In Sweden it is further associated with witchcraft.[18] In Norway, a magpie is considered cunning and thievish, but also the bird of huldra, the underground people.[19] In the British Isles a widespread traditional rhyme, One for Sorrow records the myth (it is not clear whether it has been seriously believed) that seeing magpies predicts the future, depending on how many are seen. There are many regional variations on the rhyme, which means that it is impossible to give a definitive version.[20][21] In culture[edit] La gazza ladra (The Thieving Magpie) is an opera in two acts by Gioachino Rossini. The very distinctive overture is well known.[citation needed] A British children's TV show called Magpie featured a theme song based on the "one for sorrow" rhyme, and featured a large cartoon Magpie as its mascot or logo.[citation needed] Magpie (Margaret Pye) is the name of a villain in DC Comics known for her grating voice and penchant for stealing shiny objects.[citation needed] In Marvel's Journey into Mystery, Loki's former soul turns into a magpie to follow his reborn self.[22][citation needed] American rock group Counting Crows released the single "A Murder of One" in 1995 from the album August and Everything After. The song contains version A (per this article) of the Magpie rhyme.[citation needed] Three English football clubs, Notts County, Maidenhead United and Newcastle United are nicknamed "The Magpies" due to their black and white striped playing kits. Notts County's club crest depicts a football on which perch two magpies. Thieving Magpie, named after the Thieving Magpie Overture, is a popular card in the trading card game Magic: the Gathering. In target shooting the score for a shot striking the outermost division but one is called a "magpie" because it was signalled by a black and white flag. Bishops were formerly called "magpies" in humour or derision because of their black and white vestments. Lawyers as vultures, had soared up and down; / Prelates, like Magpies, in the Air had flown.--Howell's Letters: Lines to the knowing reader.[17]
116	bdehl	anonymous@anonymous.com	2675	Crow
117	bdehl	anonymous@anonymous.com	2676	I never picked magpie (because i dont know too much about birds)
118	bdehl	anonymous@anonymous.com	2677	much
119	bdehl	anonymous@anonymous.com	2678	gsfsjssitsjtstjsjtstjsfjsfjgdhcjfifurysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃
116	bdehl	anonymous@anonymous.com	2679	Crow
117	bdehl	anonymous@anonymous.com	2680	I never picked magpie (because i dont know too much about birds)
118	bdehl	anonymous@anonymous.com	2681	much
119	bdehl	anonymous@anonymous.com	2682	gsfsjssitsjtstjsjtstjsfjsf  gravatar Web Clicker  Ornery Poll #47   Question 1 click to collapse contents  Question: Best Bird  Answer: Crow  50%50% Possible Answers: Crow Pidgeon Magpie Question 2 click to collapse contents  Question: Why did you pick magpie  Answer: because they are the best..  50%50% Possible Answers: because they are the best.. I never picked magpie (because i dont know too much about birds) Question 3 click to collapse contents  Question: How much wood would a magpie chuck if a magpie could chuck wood?  Answer: many  100% Possible Answers: many much Question 4 click to collapse contents  Question: In 1000 words or more, tell me how awesome magpies are.  There are numerous subspecies. The northwest African race differs in having a patch of blue bare skin around the eye, no white patch on the rump and an unglossed tail. The southwest Arabian race differs in being smaller, with dull black plumage lacking iridescent tones, and minimal white in the wings. The Siberian races have more extensive white in the wings, and brilliant green iridescence; Korean birds have a purple gloss instead and relatively longer wings and a shorter tail. Analysis of mtDNA sequences[4] has indicated that the Korean race, P. pica sericea, is very distinct from the other Eurasian forms, and may be a separate species. The North American Black-billed Magpie which looks almost identical to the Eurasian form and was previously considered conspecific is genetically closer to the Yellow-billed Magpie. The main Eurasian lineages of this astoundingly variable species have not been sufficiently sampled to clarify the status of such forms as the northwest African race P. p. mauretanica and the southwest Arabian race P. p. asirensis, which could also be distinct species. A larger palaeosubspecies of the European Magpie was described as Pica pica major. Etymology[edit] The common name comes from magot pie (pied Margot), first found[5] in Shakespeare's Macbeth.[6] The scientific name Pica is just the Latin word for Magpie.[7] When Linnaeus first described this species in 1758, he named it Corvus pica.[8] Description[edit] In flight The Eurasian Magpie is 44–46 centimetres (17–18 in) in length - in the adult over 50% of this is tail - and a wingspan of 52–62 centimetres (20–24 in).[9] Its head, neck and breast are glossy black with a metallic green and violet sheen; the belly and scapulars (shoulder feathers) are pure white; the wings are black glossed with green or purple, and the primaries have white inner webs, conspicuous when the wing is open. The graduated tail is black, shot with bronze-green and other iridescent colours. The legs and bill are black. The young resemble the adults, but are at first without much of the gloss on the sooty plumage. The male is slightly larger than the female.[9] Behaviour and ecology[edit] This section needs additional citations for verification. Please help improve this article by adding citations to reliable sources. Unsourced material may be challenged and removed. (January 2011) Perching in a mountain ash tree in Manchester, England The Eurasian Magpie is a distinctive species with pied plumage, long 20–30 centimetres (8–12 in) graduated tail, and loud chatter. When passing in open country they rapidly move their wings and chatter. Upon landing the long tail is elevated and carefully carried clear of the ground. Like other corvids such as crows, the Magpie usually walks, but can also hop quickly sideways with wings slightly opened. They are fond of bright objects.[citation needed] In West Drayton, London The Magpie is omnivorous, eating young birds and eggs, insects, scraps and carrion, acorns, grain, and other vegetable substances. Magpies are common in suburban areas[10] but tend toward shyness and caution in the country. They only avoid humans when harassed. Sometimes two or more birds appear to "tease" other animals, such as cats, a behaviour thought to scare away potential predators and egg thieves.[citation needed] A young European Magpie, not yet fledge. In winter Magpies often form groups, feeding and roosting at night. Early in the year large numbers gather for mating in groups Charles Darwin described as "marriage meetings".[citation needed] Magpies have been observed taking small songbirds in flight, a behaviour once thought unique to birds of prey.[citation needed] Reproduction[edit] Magpies are territorial and stay in theirs all year, even in the north of the species range. The pairs are monogamous and remain together for life, finding new partners from the stock of yearlings if one is lost. Mating takes place in spring. In the courtship display males rapidly raise and depress their head feathers, uplift, open and close their tails like fans, and call in soft tones quite distinct from their usual chatter. The loose feathers of the flanks are brought over the primaries, and the shoulder patch is spread so the white is conspicuous, presumably to attract females. Short buoyant flights and chases follow. Egg of Eurasian Magpie Magpies prefer tall trees for their bulky nest, firmly attaching them to a central fork in the upper branches. A framework of the sticks is cemented with earth and clay, and a lining of the same is covered with fine roots. Above is a stout though loosely built dome of prickly branches with a single well-concealed entrance. These huge nests are conspicuous when the leaves fall. Where trees are scarce, though even in well-wooded country, nests are at times built in bushes and hedgerows. Eggs are typically laid in April, five to eight is normal though as many as ten have been recorded. Small for the size of the bird, they are typically blue-green with close specks and spots of brown and grey, but show much variation in ground and marking. Only one brood is reared unless disaster overtakes the first clutch. Intelligence[edit] The Eurasian Magpie is believed not only to be among the brightest of birds but among the most intelligent of all animals. Magpies have been observed engaging in elaborate social rituals, possibly including the expression of grief.[11] Mirror self-recognition has been demonstrated in European magpies,[12] making them one but a few species and the only non-mammal known to possess this capability.[13] The cognitive abilities of the Eurasian Magpie are regarded as evidence that intelligence evolved independently in both corvids and primates. This is indicated by tool use, an ability to hide and store food across seasons, episodic memory, using their own experience to predict the behavior of conspecifics.[2] Another behavior exhibiting intelligence is cutting their food in correctly sized proportions for the size of their young. In captivity magpies have been observed counting up to get food, imitating human voices, and regularly using tools to clean their own cages.[citation needed] In the wild, they organise themselves into gangs and use complex strategies hunting other birds and when confronted by predators.[14] Along with the Jackdaw, the Eurasian Magpie's nidopallium is approximately the same relative size as those in chimpanzees and humans, significantly larger than the gibbon's.[3] Like other corvids, such as Ravens and Crows, their total Brain-to-body mass ratio is equal to most great apes' and cetaceans.'[15] Relationship with humans[edit] Traditions[edit] In European folklore the magpie is associated with a number of superstitions[16] surrounding its reputation as an omen of ill fortune. This reputation may derive from the bird's widely believed tendency to "steal" shiny objects or its aggressive behaviour toward favoured songbirds. In the 19th century book, A Guide to the Scientific Knowledge of Things Familiar, a proverb concerning magpies is recited: "A single magpie in spring, foul weather will bring". The book further explains that this superstition arises from the habits of pairs of magpies to forage together only when the weather is fine. In Scotland, a magpie near the window of the house foretells death.[17] A hopscotch game with the Magpie rhyme In both Italian and French folklore, magpies' penchant for picking up shiny items is thought to be particularly directed towards precious stones. Rossini's opera La gazza ladra and The Adventures of Tintin comic The Castafiore Emerald are based on this theme. In Bulgarian, Czech, German, Hungarian, Polish and Swedish folklore the magpie is also seen as a thief. In Sweden it is further associated with witchcraft.[18] In Norway, a magpie is considered cunning and thievish, but also the bird of huldra, the underground people.[19] In the British Isles a widespread traditional rhyme, One for Sorrow records the myth (it is not clear whether it has been seriously believed) that seeing magpies predicts the future, depending on how many are seen. There are many regional variations on the rhyme, which means that it is impossible to give a definitive version.[20][21] In culture[edit] La gazza ladra (The Thieving Magpie) is an opera in two acts by Gioachino Rossini. The very distinctive overture is well known.[citation needed] A British children's TV show called Magpie featured a theme song based on the "one for sorrow" rhyme, and featured a large cartoon Magpie as its mascot or logo.[citation needed] Magpie (Margaret Pye) is the name of a villain in DC Comics known for her grating voice and penchant for stealing shiny objects.[citation needed] In Marvel's Journey into Mystery, Loki's former soul turns into a magpie to follow his reborn self.[22][citation needed] American rock group Counting Crows released the single "A Murder of One" in 1995 from the album August and Everything After. The song contains version A (per this article) of the Magpie rhyme.[citation needed] Three English football clubs, Notts County, Maidenhead United and Newcastle United are nicknamed "The Magpies" due to their black and white striped playing kits. Notts County's club crest depicts a football on which perch two magpies. Thieving Magpie, named after the Thieving Magpie Overture, is a popular card in the trading card game Magic: the Gathering. In target shooting the score for a shot striking the outermost division but one is called a "magpie" because it was signalled by a black and white flag. Bishops were formerly called "magpies" in humour or derision because of their black and white vestments. Lawyers as vultures, had soared up and down; / Prelates, like Magpies, in the Air had flown.--Howell's Letters: Lines to the knowing reader.[17] gsfsjssitsjtstjsjtstjsfjsfjgdhcjfifurysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃ Home  New Poll  To Poll  About jgdhcjfifu  gravatar Web Clicker  Ornery Poll #47   Question 1 click to collapse contents  Question: Best Bird  Answer: Crow  50%50% Possible Answers: Crow Pidgeon Magpie Question 2 click to collapse contents  Question: Why did you pick magpie  Answer: because they are the best..  50%50% Possible Answers: because they are the best.. I never picked magpie (because i dont know too much about birds) Question 3 click to collapse contents  Question: How much wood would a magpie chuck if a magpie could chuck wood?  Answer: many  100% Possible Answers: many much Question 4 click to collapse contents  Question: In 1000 words or more, tell me how awesome magpies are.  There are numerous subspecies. The northwest African race differs in having a patch of blue bare skin around the eye, no white patch on the rump and an unglossed tail. The southwest Arabian race differs in being smaller, with dull black plumage lacking iridescent tones, and minimal white in the wings. The Siberian races have more extensive white in the wings, and brilliant green iridescence; Korean birds have a purple gloss instead and relatively longer wings and a shorter tail. Analysis of mtDNA sequences[4] has indicated that the Korean race, P. pica sericea, is very distinct from the other Eurasian forms, and may be a separate species. The North American Black-billed Magpie which looks almost identical to the Eurasian form and was previously considered conspecific is genetically closer to the Yellow-billed Magpie. The main Eurasian lineages of this astoundingly variable species have not been sufficiently sampled to clarify the status of such forms as the northwest African race P. p. mauretanica and the southwest Arabian race P. p. asirensis, which could also be distinct species. A larger palaeosubspecies of the European Magpie was described as Pica pica major. Etymology[edit] The common name comes from magot pie (pied Margot), first found[5] in Shakespeare's Macbeth.[6] The scientific name Pica is just the Latin word for Magpie.[7] When Linnaeus first described this species in 1758, he named it Corvus pica.[8] Description[edit] In flight The Eurasian Magpie is 44–46 centimetres (17–18 in) in length - in the adult over 50% of this is tail - and a wingspan of 52–62 centimetres (20–24 in).[9] Its head, neck and breast are glossy black with a metallic green and violet sheen; the belly and scapulars (shoulder feathers) are pure white; the wings are black glossed with green or purple, and the primaries have white inner webs, conspicuous when the wing is open. The graduated tail is black, shot with bronze-green and other iridescent colours. The legs and bill are black. The young resemble the adults, but are at first without much of the gloss on the sooty plumage. The male is slightly larger than the female.[9] Behaviour and ecology[edit] This section needs additional citations for verification. Please help improve this article by adding citations to reliable sources. Unsourced material may be challenged and removed. (January 2011) Perching in a mountain ash tree in Manchester, England The Eurasian Magpie is a distinctive species with pied plumage, long 20–30 centimetres (8–12 in) graduated tail, and loud chatter. When passing in open country they rapidly move their wings and chatter. Upon landing the long tail is elevated and carefully carried clear of the ground. Like other corvids such as crows, the Magpie usually walks, but can also hop quickly sideways with wings slightly opened. They are fond of bright objects.[citation needed] In West Drayton, London The Magpie is omnivorous, eating young birds and eggs, insects, scraps and carrion, acorns, grain, and other vegetable substances. Magpies are common in suburban areas[10] but tend toward shyness and caution in the country. They only avoid humans when harassed. Sometimes two or more birds appear to "tease" other animals, such as cats, a behaviour thought to scare away potential predators and egg thieves.[citation needed] A young European Magpie, not yet fledge. In winter Magpies often form groups, feeding and roosting at night. Early in the year large numbers gather for mating in groups Charles Darwin described as "marriage meetings".[citation needed] Magpies have been observed taking small songbirds in flight, a behaviour once thought unique to birds of prey.[citation needed] Reproduction[edit] Magpies are territorial and stay in theirs all year, even in the north of the species range. The pairs are monogamous and remain together for life, finding new partners from the stock of yearlings if one is lost. Mating takes place in spring. In the courtship display males rapidly raise and depress their head feathers, uplift, open and close their tails like fans, and call in soft tones quite distinct from their usual chatter. The loose feathers of the flanks are brought over the primaries, and the shoulder patch is spread so the white is conspicuous, presumably to attract females. Short buoyant flights and chases follow. Egg of Eurasian Magpie Magpies prefer tall trees for their bulky nest, firmly attaching them to a central fork in the upper branches. A framework of the sticks is cemented with earth and clay, and a lining of the same is covered with fine roots. Above is a stout though loosely built dome of prickly branches with a single well-concealed entrance. These huge nests are conspicuous when the leaves fall. Where trees are scarce, though even in well-wooded country, nests are at times built in bushes and hedgerows. Eggs are typically laid in April, five to eight is normal though as many as ten have been recorded. Small for the size of the bird, they are typically blue-green with close specks and spots of brown and grey, but show much variation in ground and marking. Only one brood is reared unless disaster overtakes the first clutch. Intelligence[edit] The Eurasian Magpie is believed not only to be among the brightest of birds but among the most intelligent of all animals. Magpies have been observed engaging in elaborate social rituals, possibly including the expression of grief.[11] Mirror self-recognition has been demonstrated in European magpies,[12] making them one but a few species and the only non-mammal known to possess this capability.[13] The cognitive abilities of the Eurasian Magpie are regarded as evidence that intelligence evolved independently in both corvids and primates. This is indicated by tool use, an ability to hide and store food across seasons, episodic memory, using their own experience to predict the behavior of conspecifics.[2] Another behavior exhibiting intelligence is cutting their food in correctly sized proportions for the size of their young. In captivity magpies have been observed counting up to get food, imitating human voices, and regularly using tools to clean their own cages.[citation needed] In the wild, they organise themselves into gangs and use complex strategies hunting other birds and when confronted by predators.[14] Along with the Jackdaw, the Eurasian Magpie's nidopallium is approximately the same relative size as those in chimpanzees and humans, significantly larger than the gibbon's.[3] Like other corvids, such as Ravens and Crows, their total Brain-to-body mass ratio is equal to most great apes' and cetaceans.'[15] Relationship with humans[edit] Traditions[edit] In European folklore the magpie is associated with a number of superstitions[16] surrounding its reputation as an omen of ill fortune. This reputation may derive from the bird's widely believed tendency to "steal" shiny objects or its aggressive behaviour toward favoured songbirds. In the 19th century book, A Guide to the Scientific Knowledge of Things Familiar, a proverb concerning magpies is recited: "A single magpie in spring, foul weather will bring". The book further explains that this superstition arises from the habits of pairs of magpies to forage together only when the weather is fine. In Scotland, a magpie near the window of the house foretells death.[17] A hopscotch game with the Magpie rhyme In both Italian and French folklore, magpies' penchant for picking up shiny items is thought to be particularly directed towards precious stones. Rossini's opera La gazza ladra and The Adventures of Tintin comic The Castafiore Emerald are based on this theme. In Bulgarian, Czech, German, Hungarian, Polish and Swedish folklore the magpie is also seen as a thief. In Sweden it is further associated with witchcraft.[18] In Norway, a magpie is considered cunning and thievish, but also the bird of huldra, the underground people.[19] In the British Isles a widespread traditional rhyme, One for Sorrow records the myth (it is not clear whether it has been seriously believed) that seeing magpies predicts the future, depending on how many are seen. There are many regional variations on the rhyme, which means that it is impossible to give a definitive version.[20][21] In culture[edit] La gazza ladra (The Thieving Magpie) is an opera in two acts by Gioachino Rossini. The very distinctive overture is well known.[citation needed] A British children's TV show called Magpie featured a theme song based on the "one for sorrow" rhyme, and featured a large cartoon Magpie as its mascot or logo.[citation needed] Magpie (Margaret Pye) is the name of a villain in DC Comics known for her grating voice and penchant for stealing shiny objects.[citation needed] In Marvel's Journey into Mystery, Loki's former soul turns into a magpie to follow his reborn self.[22][citation needed] American rock group Counting Crows released the single "A Murder of One" in 1995 from the album August and Everything After. The song contains version A (per this article) of the Magpie rhyme.[citation needed] Three English football clubs, Notts County, Maidenhead United and Newcastle United are nicknamed "The Magpies" due to their black and white striped playing kits. Notts County's club crest depicts a football on which perch two magpies. Thieving Magpie, named after the Thieving Magpie Overture, is a popular card in the trading card game Magic: the Gathering. In target shooting the score for a shot striking the outermost division but one is called a "magpie" because it was signalled by a black and white flag. Bishops were formerly called "magpies" in humour or derision because of their black and white vestments. Lawyers as vultures, had soared up and down; / Prelates, like Magpies, in the Air had flown.--Howell's Letters: Lines to the knowing reader.[17] gsfsjssitsjtstjsjtstjsfjsfjgdhcjfifurysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃ Home  New Poll  To Poll  About rysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃
116	bdehl	anonymous@anonymous.com	2683	Crow
117	bdehl	anonymous@anonymous.com	2684	I never picked magpie (because i dont know too much about birds)
118	bdehl	anonymous@anonymous.com	2685	much
119	bdehl	anonymous@anonymous.com	2686	gsfsjssitsjtstjsjtstjsfjsf  gravatar Web Clicker  Ornery Poll #47   Question 1 click to collapse contents  Question: Best Bird  Answer: Crow  50%50% Possible Answers: Crow Pidgeon Magpie Question 2 click to collapse contents  Question: Why did you pick magpie  Answer: because they are the best..  50%50% Possible Answers: because they are the best.. I never picked magpie (because i dont know too much about birds) Question 3 click to collapse contents  Question: How much wood would a magpie chuck if a magpie could chuck wood?  Answer: many  100% Possible Answers: many much Question 4 click to collapse contents  Question: In 1000 words or more, tell me how awesome magpies are.  There are numerous subspecies. The northwest African race differs in having a patch of blue bare skin around the eye, no white patch on the rump and an unglossed tail. The southwest Arabian race differs in being smaller, with dull black plumage lacking iridescent tones, and minimal white in the wings. The Siberian races have more extensive white in the wings, and brilliant green iridescence; Korean birds have a purple gloss instead and relatively longer wings and a shorter tail. Analysis of mtDNA sequences[4] has indicated that the Korean race, P. pica sericea, is very distinct from the other Eurasian forms, and may be a separate species. The North American Black-billed Magpie which looks almost identical to the Eurasian form and was previously considered conspecific is genetically closer to the Yellow-billed Magpie. The main Eurasian lineages of this astoundingly variable species have not been sufficiently sampled to clarify the status of such forms as the northwest African race P. p. mauretanica and the southwest Arabian race P. p. asirensis, which could also be distinct species. A larger palaeosubspecies of the European Magpie was described as Pica pica major. Etymology[edit] The common name comes from magot pie (pied Margot), first found[5] in Shakespeare's Macbeth.[6] The scientific name Pica is just the Latin word for Magpie.[7] When Linnaeus first described this species in 1758, he named it Corvus pica.[8] Description[edit] In flight The Eurasian Magpie is 44–46 centimetres (17–18 in) in length - in the adult over 50% of this is tail - and a wingspan of 52–62 centimetres (20–24 in).[9] Its head, neck and breast are glossy black with a metallic green and violet sheen; the belly and scapulars (shoulder feathers) are pure white; the wings are black glossed with green or purple, and the primaries have white inner webs, conspicuous when the wing is open. The graduated tail is black, shot with bronze-green and other iridescent colours. The legs and bill are black. The young resemble the adults, but are at first without much of the gloss on the sooty plumage. The male is slightly larger than the female.[9] Behaviour and ecology[edit] This section needs additional citations for verification. Please help improve this article by adding citations to reliable sources. Unsourced material may be challenged and removed. (January 2011) Perching in a mountain ash tree in Manchester, England The Eurasian Magpie is a distinctive species with pied plumage, long 20–30 centimetres (8–12 in) graduated tail, and loud chatter. When passing in open country they rapidly move their wings and chatter. Upon landing the long tail is elevated and carefully carried clear of the ground. Like other corvids such as crows, the Magpie usually walks, but can also hop quickly sideways with wings slightly opened. They are fond of bright objects.[citation needed] In West Drayton, London The Magpie is omnivorous, eating young birds and eggs, insects, scraps and carrion, acorns, grain, and other vegetable substances. Magpies are common in suburban areas[10] but tend toward shyness and caution in the country. They only avoid humans when harassed. Sometimes two or more birds appear to "tease" other animals, such as cats, a behaviour thought to scare away potential predators and egg thieves.[citation needed] A young European Magpie, not yet fledge. In winter Magpies often form groups, feeding and roosting at night. Early in the year large numbers gather for mating in groups Charles Darwin described as "marriage meetings".[citation needed] Magpies have been observed taking small songbirds in flight, a behaviour once thought unique to birds of prey.[citation needed] Reproduction[edit] Magpies are territorial and stay in theirs all year, even in the north of the species range. The pairs are monogamous and remain together for life, finding new partners from the stock of yearlings if one is lost. Mating takes place in spring. In the courtship display males rapidly raise and depress their head feathers, uplift, open and close their tails like fans, and call in soft tones quite distinct from their usual chatter. The loose feathers of the flanks are brought over the primaries, and the shoulder patch is spread so the white is conspicuous, presumably to attract females. Short buoyant flights and chases follow. Egg of Eurasian Magpie Magpies prefer tall trees for their bulky nest, firmly attaching them to a central fork in the upper branches. A framework of the sticks is cemented with earth and clay, and a lining of the same is covered with fine roots. Above is a stout though loosely built dome of prickly branches with a single well-concealed entrance. These huge nests are conspicuous when the leaves fall. Where trees are scarce, though even in well-wooded country, nests are at times built in bushes and hedgerows. Eggs are typically laid in April, five to eight is normal though as many as ten have been recorded. Small for the size of the bird, they are typically blue-green with close specks and spots of brown and grey, but show much variation in ground and marking. Only one brood is reared unless disaster overtakes the first clutch. Intelligence[edit] The Eurasian Magpie is believed not only to be among the brightest of birds but among the most intelligent of all animals. Magpies have been observed engaging in elaborate social rituals, possibly including the expression of grief.[11] Mirror self-recognition has been demonstrated in European magpies,[12] making them one but a few species and the only non-mammal known to possess this capability.[13] The cognitive abilities of the Eurasian Magpie are regarded as evidence that intelligence evolved independently in both corvids and primates. This is indicated by tool use, an ability to hide and store food across seasons, episodic memory, using their own experience to predict the behavior of conspecifics.[2] Another behavior exhibiting intelligence is cutting their food in correctly sized proportions for the size of their young. In captivity magpies have been observed counting up to get food, imitating human voices, and regularly using tools to clean their own cages.[citation needed] In the wild, they organise themselves into gangs and use complex strategies hunting other birds and when confronted by predators.[14] Along with the Jackdaw, the Eurasian Magpie's nidopallium is approximately the same relative size as those in chimpanzees and humans, significantly larger than the gibbon's.[3] Like other corvids, such as Ravens and Crows, their total Brain-to-body mass ratio is equal to most great apes' and cetaceans.'[15] Relationship with humans[edit] Traditions[edit] In European folklore the magpie is associated with a number of superstitions[16] surrounding its reputation as an omen of ill fortune. This reputation may derive from the bird's widely believed tendency to "steal" shiny objects or its aggressive behaviour toward favoured songbirds. In the 19th century book, A Guide to the Scientific Knowledge of Things Familiar, a proverb concerning magpies is recited: "A single magpie in spring, foul weather will bring". The book further explains that this superstition arises from the habits of pairs of magpies to forage together only when the weather is fine. In Scotland, a magpie near the window of the house foretells death.[17] A hopscotch game with the Magpie rhyme In both Italian and French folklore, magpies' penchant for picking up shiny items is thought to be particularly directed towards precious stones. Rossini's opera La gazza ladra and The Adventures of Tintin comic The Castafiore Emerald are based on this theme. In Bulgarian, Czech, German, Hungarian, Polish and Swedish folklore the magpie is also seen as a thief. In Sweden it is further associated with witchcraft.[18] In Norway, a magpie is considered cunning and thievish, but also the bird of huldra, the underground people.[19] In the British Isles a widespread traditional rhyme, One for Sorrow records the myth (it is not clear whether it has been seriously believed) that seeing magpies predicts the future, depending on how many are seen. There are many regional variations on the rhyme, which means that it is impossible to give a definitive version.[20][21] In culture[edit] La gazza ladra (The Thieving Magpie) is an opera in two acts by Gioachino Rossini. The very distinctive overture is well known.[citation needed] A British children's TV show called Magpie featured a theme song based on the "one for sorrow" rhyme, and featured a large cartoon Magpie as its mascot or logo.[citation needed] Magpie (Margaret Pye) is the name of a villain in DC Comics known for her grating voice and penchant for stealing shiny objects.[citation needed] In Marvel's Journey into Mystery, Loki's former soul turns into a magpie to follow his reborn self.[22][citation needed] American rock group Counting Crows released the single "A Murder of One" in 1995 from the album August and Everything After. The song contains version A (per this article) of the Magpie rhyme.[citation needed] Three English football clubs, Notts County, Maidenhead United and Newcastle United are nicknamed "The Magpies" due to their black and white striped playing kits. Notts County's club crest depicts a football on which perch two magpies. Thieving Magpie, named after the Thieving Magpie Overture, is a popular card in the trading card game Magic: the Gathering. In target shooting the score for a shot striking the outermost division but one is called a "magpie" because it was signalled by a black and white flag. Bishops were formerly called "magpies" in humour or derision because of their black and white vestments. Lawyers as vultures, had soared up and down; / Prelates, like Magpies, in the Air had flown.--Howell's Letters: Lines to the knowing reader.[17] gsfsjssitsjtstjsjtstjsfjsfjgdhcjfifurysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃ Home  New Poll  To Poll  About jgdhcjfifu  gravatar Web Clicker  Ornery Poll #47   Question 1 click to collapse contents  Question: Best Bird  Answer: Crow  50%50% Possible Answers: Crow Pidgeon Magpie Question 2 click to collapse contents  Question: Why did you pick magpie  Answer: because they are the best..  50%50% Possible Answers: because they are the best.. I never picked magpie (because i dont know too much about birds) Question 3 click to collapse contents  Question: How much wood would a magpie chuck if a magpie could chuck wood?  Answer: many  100% Possible Answers: many much Question 4 click to collapse contents  Question: In 1000 words or more, tell me how awesome magpies are.  There are numerous subspecies. The northwest African race differs in having a patch of blue bare skin around the eye, no white patch on the rump and an unglossed tail. The southwest Arabian race differs in being smaller, with dull black plumage lacking iridescent tones, and minimal white in the wings. The Siberian races have more extensive white in the wings, and brilliant green iridescence; Korean birds have a purple gloss instead and relatively longer wings and a shorter tail. Analysis of mtDNA sequences[4] has indicated that the Korean race, P. pica sericea, is very distinct from the other Eurasian forms, and may be a separate species. The North American Black-billed Magpie which looks almost identical to the Eurasian form and was previously considered conspecific is genetically closer to the Yellow-billed Magpie. The main Eurasian lineages of this astoundingly variable species have not been sufficiently sampled to clarify the status of such forms as the northwest African race P. p. mauretanica and the southwest Arabian race P. p. asirensis, which could also be distinct species. A larger palaeosubspecies of the European Magpie was described as Pica pica major. Etymology[edit] The common name comes from magot pie (pied Margot), first found[5] in Shakespeare's Macbeth.[6] The scientific name Pica is just the Latin word for Magpie.[7] When Linnaeus first described this species in 1758, he named it Corvus pica.[8] Description[edit] In flight The Eurasian Magpie is 44–46 centimetres (17–18 in) in length - in the adult over 50% of this is tail - and a wingspan of 52–62 centimetres (20–24 in).[9] Its head, neck and breast are glossy black with a metallic green and violet sheen; the belly and scapulars (shoulder feathers) are pure white; the wings are black glossed with green or purple, and the primaries have white inner webs, conspicuous when the wing is open. The graduated tail is black, shot with bronze-green and other iridescent colours. The legs and bill are black. The young resemble the adults, but are at first without much of the gloss on the sooty plumage. The male is slightly larger than the female.[9] Behaviour and ecology[edit] This section needs additional citations for verification. Please help improve this article by adding citations to reliable sources. Unsourced material may be challenged and removed. (January 2011) Perching in a mountain ash tree in Manchester, England The Eurasian Magpie is a distinctive species with pied plumage, long 20–30 centimetres (8–12 in) graduated tail, and loud chatter. When passing in open country they rapidly move their wings and chatter. Upon landing the long tail is elevated and carefully carried clear of the ground. Like other corvids such as crows, the Magpie usually walks, but can also hop quickly sideways with wings slightly opened. They are fond of bright objects.[citation needed] In West Drayton, London The Magpie is omnivorous, eating young birds and eggs, insects, scraps and carrion, acorns, grain, and other vegetable substances. Magpies are common in suburban areas[10] but tend toward shyness and caution in the country. They only avoid humans when harassed. Sometimes two or more birds appear to "tease" other animals, such as cats, a behaviour thought to scare away potential predators and egg thieves.[citation needed] A young European Magpie, not yet fledge. In winter Magpies often form groups, feeding and roosting at night. Early in the year large numbers gather for mating in groups Charles Darwin described as "marriage meetings".[citation needed] Magpies have been observed taking small songbirds in flight, a behaviour once thought unique to birds of prey.[citation needed] Reproduction[edit] Magpies are territorial and stay in theirs all year, even in the north of the species range. The pairs are monogamous and remain together for life, finding new partners from the stock of yearlings if one is lost. Mating takes place in spring. In the courtship display males rapidly raise and depress their head feathers, uplift, open and close their tails like fans, and call in soft tones quite distinct from their usual chatter. The loose feathers of the flanks are brought over the primaries, and the shoulder patch is spread so the white is conspicuous, presumably to attract females. Short buoyant flights and chases follow. Egg of Eurasian Magpie Magpies prefer tall trees for their bulky nest, firmly attaching them to a central fork in the upper branches. A framework of the sticks is cemented with earth and clay, and a lining of the same is covered with fine roots. Above is a stout though loosely built dome of prickly branches with a single well-concealed entrance. These huge nests are conspicuous when the leaves fall. Where trees are scarce, though even in well-wooded country, nests are at times built in bushes and hedgerows. Eggs are typically laid in April, five to eight is normal though as many as ten have been recorded. Small for the size of the bird, they are typically blue-green with close specks and spots of brown and grey, but show much variation in ground and marking. Only one brood is reared unless disaster overtakes the first clutch. Intelligence[edit] The Eurasian Magpie is believed not only to be among the brightest of birds but among the most intelligent of all animals. Magpies have been observed engaging in elaborate social rituals, possibly including the expression of grief.[11] Mirror self-recognition has been demonstrated in European magpies,[12] making them one but a few species and the only non-mammal known to possess this capability.[13] The cognitive abilities of the Eurasian Magpie are regarded as evidence that intelligence evolved independently in both corvids and primates. This is indicated by tool use, an ability to hide and store food across seasons, episodic memory, using their own experience to predict the behavior of conspecifics.[2] Another behavior exhibiting intelligence is cutting their food in correctly sized proportions for the size of their young. In captivity magpies have been observed counting up to get food, imitating human voices, and regularly using tools to clean their own cages.[citation needed] In the wild, they organise themselves into gangs and use complex strategies hunting other birds and when confronted by predators.[14] Along with the Jackdaw, the Eurasian Magpie's nidopallium is approximately the same relative size as those in chimpanzees and humans, significantly larger than the gibbon's.[3] Like other corvids, such as Ravens and Crows, their total Brain-to-body mass ratio is equal to most great apes' and cetaceans.'[15] Relationship with humans[edit] Traditions[edit] In European folklore the magpie is associated with a number of superstitions[16] surrounding its reputation as an omen of ill fortune. This reputation may derive from the bird's widely believed tendency to "steal" shiny objects or its aggressive behaviour toward favoured songbirds. In the 19th century book, A Guide to the Scientific Knowledge of Things Familiar, a proverb concerning magpies is recited: "A single magpie in spring, foul weather will bring". The book further explains that this superstition arises from the habits of pairs of magpies to forage together only when the weather is fine. In Scotland, a magpie near the window of the house foretells death.[17] A hopscotch game with the Magpie rhyme In both Italian and French folklore, magpies' penchant for picking up shiny items is thought to be particularly directed towards precious stones. Rossini's opera La gazza ladra and The Adventures of Tintin comic The Castafiore Emerald are based on this theme. In Bulgarian, Czech, German, Hungarian, Polish and Swedish folklore the magpie is also seen as a thief. In Sweden it is further associated with witchcraft.[18] In Norway, a magpie is considered cunning and thievish, but also the bird of huldra, the underground people.[19] In the British Isles a widespread traditional rhyme, One for Sorrow records the myth (it is not clear whether it has been seriously believed) that seeing magpies predicts the future, depending on how many are seen. There are many regional variations on the rhyme, which means that it is impossible to give a definitive version.[20][21] In culture[edit] La gazza ladra (The Thieving Magpie) is an opera in two acts by Gioachino Rossini. The very distinctive overture is well known.[citation needed] A British children's TV show called Magpie featured a theme song based on the "one for sorrow" rhyme, and featured a large cartoon Magpie as its mascot or logo.[citation needed] Magpie (Margaret Pye) is the name of a villain in DC Comics known for her grating voice and penchant for stealing shiny objects.[citation needed] In Marvel's Journey into Mystery, Loki's former soul turns into a magpie to follow his reborn self.[22][citation needed] American rock group Counting Crows released the single "A Murder of One" in 1995 from the album August and Everything After. The song contains version A (per this article) of the Magpie rhyme.[citation needed] Three English football clubs, Notts County, Maidenhead United and Newcastle United are nicknamed "The Magpies" due to their black and white striped playing kits. Notts County's club crest depicts a football on which perch two magpies. Thieving Magpie, named after the Thieving Magpie Overture, is a popular card in the trading card game Magic: the Gathering. In target shooting the score for a shot striking the outermost division but one is called a "magpie" because it was signalled by a black and white flag. Bishops were formerly called "magpies" in humour or derision because of their black and white vestments. Lawyers as vultures, had soared up and down; / Prelates, like Magpies, in the Air had flown.--Howell's Letters: Lines to the knowing reader.[17] gsfsjssitsjtstjsjtstjsfjsfjgdhcjfifurysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃ Home  New Poll  To Poll  About rysrst'''""%&+8900&%$@_*__|° , cc,⊙⊙ω®®®⊙⊙¤°℃§§\\¢££€¿>|§«¡¡»«§°¤℃℃℃℃℉℉℉℉℉come℉℉℉℉℃℉℃
92	twx29	anonymous@anonymous.com	2687	This site is perfect. You guys are all perfect.
92	twx29	anonymous@anonymous.com	2688	This site is perfect. You guys are all perfect.
92	twx29	anonymous@anonymous.com	2689	This site is perfect. You guys are all perfect.
115	drsz1	anonymous@anonymous.com	2690	Sisco
112	drsz1	anonymous@anonymous.com	2691	Worf
113	drsz1	anonymous@anonymous.com	2692	Seven
114	drsz1	anonymous@anonymous.com	2693	Flox
115	drsz1	anonymous@anonymous.com	2694	Sisco
120	buvw7	saeed.cs@usask.ca	2695	Design
121	buvw7	saeed.cs@usask.ca	2696	PHP
91	twx29	saeed.cs@usask.ca	2697	Could be improved
92	twx29	saeed.cs@usask.ca	2698	Page layout is not easy to navigate
93	twx29	saeed.cs@usask.ca	2699	Yes!
94	twx29	saeed.cs@usask.ca	2700	Good!
112	drsz1	abc@def	2701	Worf
113	drsz1	abc@def	2702	Seven
114	drsz1	abc@def	2703	Neelix
120	buvw7	anonymous@anonymous.com	2704	Design
121	buvw7	anonymous@anonymous.com	2705	PHP
121	buvw7	anonymous@anonymous.com	2706	ASP
120	buvw7	anonymous@anonymous.com	2707	Testing
121	buvw7	anonymous@anonymous.com	2708	PHP
121	buvw7	anonymous@anonymous.com	2709	ASP
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY users (user_email, user_hash, user_alias, user_authorized, user_salt) FROM stdin;
anonymous@anonymous.com	dasdasdasd	Anonymous	t	12456
fafmaster@hotmail.com	30e0435f7acc1101b4cea6ecb6508778de56b35b	Dylan	t	41340
zillionk1973@gmail.com	e4c1ccdbb27c62f4b771ed604b2444945a2634c1	znk	t	9394
j@b.c	b525c96bf0b256e7bdd6db94e079bcc60d5806e3	Jason	t	53153
max@max.com	3ca45e0960c7d3f66a8b92f43f7665e27921c491	max	t	4556
bas453@mail.usask.ca	d230458b1ea76c6330b2b5db78f2fa353b5c3ce2	BradySmith	t	39271
t@t.com	875a4621dc6db41a60f3da13bb9b4c1010e07bef	t	t	92931
brady_smith87@hotmail.com	844443991a3edf98fdfa98538018f251a630fb0f	brady	t	28100
maxgooding@gmail.com	a6a8cebebcfa7714edc6025ad05d1e5adf6c2594	Max	t	41716
jasonprokop@gmail.com	da7ed75b48c1dd16c5bfe92d84308c7e9e6662dd	Jason	t	70778
nallelcm@gmail.com	6bf310344e4545335ff234187109095a3b6b4cd2	nallelcm	t	47996
saeed.cs@usask.ca	4f5bfe77b67957963ad835530c5263742a8c3f8b		t	31207
abc@def	01cc11e0152d9fe9b8a900688ea1a7923754265a		t	97487
abc@defa	ddaeb8e7bbfbf22681e6150ad2e157773514c776	abc@defa	t	66991
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

