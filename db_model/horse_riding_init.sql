-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: horse_keeping_center | type: DATABASE --
-- DROP DATABASE IF EXISTS horse_keeping_center;
CREATE DATABASE horse_keeping_center;
-- ddl-end --


-- object: public.sex | type: TABLE --
-- DROP TABLE IF EXISTS public.sex CASCADE;
CREATE TABLE public.sex (
	sex_id serial NOT NULL,
	sex_name varchar(20),
	CONSTRAINT sex_id_unique_consraint UNIQUE (sex_name),
	CONSTRAINT sex_pk PRIMARY KEY (sex_id)

);
-- ddl-end --
ALTER TABLE public.sex OWNER TO postgres;
-- ddl-end --

INSERT INTO public.sex (sex_id, sex_name) VALUES (E'1', E'male');
-- ddl-end --
INSERT INTO public.sex (sex_id, sex_name) VALUES (E'2', E'female');
-- ddl-end --

-- object: public.person | type: TABLE --
-- DROP TABLE IF EXISTS public.person CASCADE;
CREATE TABLE public.person (
	person_id serial NOT NULL,
	person_name varchar(255) NOT NULL,
	person_birth_date date NOT NULL,
	sex_id integer NOT NULL,
	CONSTRAINT person_pk PRIMARY KEY (person_id)

);
-- ddl-end --
ALTER TABLE public.person OWNER TO postgres;
-- ddl-end --

-- object: public.client | type: TABLE --
-- DROP TABLE IF EXISTS public.client CASCADE;
CREATE TABLE public.client (
	client_id serial,
	client_phone varchar(11),
	client_email varchar(255),
	person_id integer NOT NULL
);
-- ddl-end --
ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public.profession | type: TABLE --
-- DROP TABLE IF EXISTS public.profession CASCADE;
CREATE TABLE public.profession (
	profession_id serial NOT NULL,
	profession_name varchar(255) NOT NULL,
	CONSTRAINT profession_unique UNIQUE (profession_name),
	CONSTRAINT profession_pk PRIMARY KEY (profession_id)

);
-- ddl-end --
ALTER TABLE public.profession OWNER TO postgres;
-- ddl-end --

INSERT INTO public.profession (profession_id, profession_name) VALUES (E'1', E'Concours coach');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'2', E'Dressage coach');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'3', E'Hippotherapist');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'4', E'Riding instructor');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'5', E'Horse breeder');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'6', E'Bereitor');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'7', E'Stableman');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'8', E'Veterinarian');
-- ddl-end --
INSERT INTO public.profession (profession_id, profession_name) VALUES (E'9', E'Manager');
-- ddl-end --

-- object: public.employee | type: TABLE --
-- DROP TABLE IF EXISTS public.employee CASCADE;
CREATE TABLE public.employee (
	employee_id serial NOT NULL,
	employee_phone varchar(11),
	employee_email varchar(255),
	employee_hire_date date NOT NULL,
	employee_fire_date date,
	profession_id integer NOT NULL,
	person_id integer NOT NULL,
	CONSTRAINT employee_pk PRIMARY KEY (employee_id)

);
-- ddl-end --
ALTER TABLE public.employee OWNER TO postgres;
-- ddl-end --

-- object: public.horse | type: TABLE --
-- DROP TABLE IF EXISTS public.horse CASCADE;
CREATE TABLE public.horse (
	horse_id serial NOT NULL,
	horse_name varchar(255) NOT NULL,
	horse_birth_date date NOT NULL,
	CONSTRAINT horse_pk PRIMARY KEY (horse_id)

);
-- ddl-end --
ALTER TABLE public.horse OWNER TO postgres;
-- ddl-end --

-- object: public.service | type: TABLE --
-- DROP TABLE IF EXISTS public.service CASCADE;
CREATE TABLE public.service (
	service_id serial NOT NULL,
	service_name varchar(255) NOT NULL,
	CONSTRAINT service_name_unique UNIQUE (service_name),
	CONSTRAINT service_pk PRIMARY KEY (service_id)

);
-- ddl-end --
ALTER TABLE public.service OWNER TO postgres;
-- ddl-end --

INSERT INTO public.service (service_id, service_name) VALUES (E'1', E'Horseback riding workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'2', E'Concours  workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'3', E'Dressage workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'4', E'Pony riding');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'5', E'Hippotherapy');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'6', E'Horseback riding outing');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'7', E'Photo session');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'8', E'Excursion');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'9', E'Celebration event');
-- ddl-end --

-- object: public.service_price | type: TABLE --
-- DROP TABLE IF EXISTS public.service_price CASCADE;
CREATE TABLE public.service_price (
	service_price_id serial NOT NULL,
	service_price decimal(10,2) NOT NULL,
	service_price_active_from date NOT NULL,
	service_price_active_to date,
	service_id integer NOT NULL,
	CONSTRAINT service_price_pk PRIMARY KEY (service_price_id)

);
-- ddl-end --
ALTER TABLE public.service_price OWNER TO postgres;
-- ddl-end --

-- object: public.payment | type: TABLE --
-- DROP TABLE IF EXISTS public.payment CASCADE;
CREATE TABLE public.payment (
	payment_id serial NOT NULL,
	payment_date date NOT NULL,
	payment_ammount decimal(10,2) NOT NULL,
	client_id integer NOT NULL,
	CONSTRAINT payment_pk PRIMARY KEY (payment_id)

);
-- ddl-end --
ALTER TABLE public.payment OWNER TO postgres;
-- ddl-end --

-- object: public.horse_service_link | type: TABLE --
-- DROP TABLE IF EXISTS public.horse_service_link CASCADE;
CREATE TABLE public.horse_service_link (
	horse_service_link_id serial NOT NULL,
	horse_service_link_active_from date NOT NULL,
	horse_service_link_active_to date,
	horse_id integer NOT NULL,
	service_id integer NOT NULL,
	CONSTRAINT horse_service_link_pk PRIMARY KEY (horse_service_link_id)

);
-- ddl-end --
ALTER TABLE public.horse_service_link OWNER TO postgres;
-- ddl-end --

-- object: public.employee_service_link | type: TABLE --
-- DROP TABLE IF EXISTS public.employee_service_link CASCADE;
CREATE TABLE public.employee_service_link (
	employee_service_link_id serial NOT NULL,
	employee_service_link_active_from date NOT NULL,
	employee_service_link_active_to date,
	employee_id integer NOT NULL,
	service_id integer NOT NULL,
	CONSTRAINT employee_service_link_pk PRIMARY KEY (employee_service_link_id)

);
-- ddl-end --
ALTER TABLE public.employee_service_link OWNER TO postgres;
-- ddl-end --

-- object: public.schedule | type: TABLE --
-- DROP TABLE IF EXISTS public.schedule CASCADE;
CREATE TABLE public.schedule (
	schedule_id serial NOT NULL,
	schedule_date_time timestamp NOT NULL,
	schedule_is_done bool,
	schedule_is_paid bool,
	employee_service_link_id integer,
	horse_service_link_id integer,
	employee_registration_id integer NOT NULL,
	client_id integer,
	service_price_id integer,
	CONSTRAINT schedule_pk PRIMARY KEY (schedule_id)

);
-- ddl-end --
ALTER TABLE public.schedule OWNER TO postgres;
-- ddl-end --

-- object: fk_person_sex | type: CONSTRAINT --
-- ALTER TABLE public.person DROP CONSTRAINT IF EXISTS fk_person_sex CASCADE;
ALTER TABLE public.person ADD CONSTRAINT fk_person_sex FOREIGN KEY (sex_id)
REFERENCES public.sex (sex_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: client_person_fk | type: CONSTRAINT --
-- ALTER TABLE public.client DROP CONSTRAINT IF EXISTS client_person_fk CASCADE;
ALTER TABLE public.client ADD CONSTRAINT client_person_fk FOREIGN KEY (person_id)
REFERENCES public.person (person_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: employee_profession_fk | type: CONSTRAINT --
-- ALTER TABLE public.employee DROP CONSTRAINT IF EXISTS employee_profession_fk CASCADE;
ALTER TABLE public.employee ADD CONSTRAINT employee_profession_fk FOREIGN KEY (profession_id)
REFERENCES public.profession (profession_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: employee_person_fk | type: CONSTRAINT --
-- ALTER TABLE public.employee DROP CONSTRAINT IF EXISTS employee_person_fk CASCADE;
ALTER TABLE public.employee ADD CONSTRAINT employee_person_fk FOREIGN KEY (person_id)
REFERENCES public.person (person_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: service_price_service_fk | type: CONSTRAINT --
-- ALTER TABLE public.service_price DROP CONSTRAINT IF EXISTS service_price_service_fk CASCADE;
ALTER TABLE public.service_price ADD CONSTRAINT service_price_service_fk FOREIGN KEY (service_id)
REFERENCES public.service (service_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: payment_client_fk | type: CONSTRAINT --
-- ALTER TABLE public.payment DROP CONSTRAINT IF EXISTS payment_client_fk CASCADE;
ALTER TABLE public.payment ADD CONSTRAINT payment_client_fk FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: horse_service_link_horse_fk | type: CONSTRAINT --
-- ALTER TABLE public.horse_service_link DROP CONSTRAINT IF EXISTS horse_service_link_horse_fk CASCADE;
ALTER TABLE public.horse_service_link ADD CONSTRAINT horse_service_link_horse_fk FOREIGN KEY (horse_id)
REFERENCES public.horse (horse_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: horse_service_link_service_fk | type: CONSTRAINT --
-- ALTER TABLE public.horse_service_link DROP CONSTRAINT IF EXISTS horse_service_link_service_fk CASCADE;
ALTER TABLE public.horse_service_link ADD CONSTRAINT horse_service_link_service_fk FOREIGN KEY (service_id)
REFERENCES public.service (service_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: employee_service_link_employee_id | type: CONSTRAINT --
-- ALTER TABLE public.employee_service_link DROP CONSTRAINT IF EXISTS employee_service_link_employee_id CASCADE;
ALTER TABLE public.employee_service_link ADD CONSTRAINT employee_service_link_employee_id FOREIGN KEY (employee_id)
REFERENCES public.employee (employee_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: employee_service_link_service_id | type: CONSTRAINT --
-- ALTER TABLE public.employee_service_link DROP CONSTRAINT IF EXISTS employee_service_link_service_id CASCADE;
ALTER TABLE public.employee_service_link ADD CONSTRAINT employee_service_link_service_id FOREIGN KEY (service_id)
REFERENCES public.service (service_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: schedule_employee_service_link_fk | type: CONSTRAINT --
-- ALTER TABLE public.schedule DROP CONSTRAINT IF EXISTS schedule_employee_service_link_fk CASCADE;
ALTER TABLE public.schedule ADD CONSTRAINT schedule_employee_service_link_fk FOREIGN KEY (employee_service_link_id)
REFERENCES public.employee_service_link (employee_service_link_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: schedule_horce_service_link_fk | type: CONSTRAINT --
-- ALTER TABLE public.schedule DROP CONSTRAINT IF EXISTS schedule_horce_service_link_fk CASCADE;
ALTER TABLE public.schedule ADD CONSTRAINT schedule_horce_service_link_fk FOREIGN KEY (horse_service_link_id)
REFERENCES public.horse_service_link (horse_service_link_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: schedule_employee_registration_fk | type: CONSTRAINT --
-- ALTER TABLE public.schedule DROP CONSTRAINT IF EXISTS schedule_employee_registration_fk CASCADE;
ALTER TABLE public.schedule ADD CONSTRAINT schedule_employee_registration_fk FOREIGN KEY (employee_registration_id)
REFERENCES public.employee (employee_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: schedule_client_fk | type: CONSTRAINT --
-- ALTER TABLE public.schedule DROP CONSTRAINT IF EXISTS schedule_client_fk CASCADE;
ALTER TABLE public.schedule ADD CONSTRAINT schedule_client_fk FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: schedule_service_price_fk | type: CONSTRAINT --
-- ALTER TABLE public.schedule DROP CONSTRAINT IF EXISTS schedule_service_price_fk CASCADE;
ALTER TABLE public.schedule ADD CONSTRAINT schedule_service_price_fk FOREIGN KEY (service_price_id)
REFERENCES public.service_price (service_price_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


