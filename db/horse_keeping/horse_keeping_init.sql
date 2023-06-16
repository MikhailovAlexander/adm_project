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
--CREATE DATABASE horse_keeping_center;
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
	person_id integer NOT NULL,
	CONSTRAINT client_pk PRIMARY KEY (client_id)
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

INSERT INTO public.service (service_id, service_name) VALUES (E'1', E'Owner workout with coach');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'2', E'Horse workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'3', E'Solarium');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'4', E'Indoor arena workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'5', E'Rent a locker in the locker room');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'6', E'Preparing the horse for the workout');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'7', E'Workout with a set of obstacles');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'8', E'Video surveillance');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'9', E'Veterinary treatments');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'10', E'Massage');
-- ddl-end --
INSERT INTO public.service (service_id, service_name) VALUES (E'11', E'Clearing of hooves ');
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

-- object: public.contract | type: TABLE --
-- DROP TABLE IF EXISTS public.contract CASCADE;
CREATE TABLE public.contract (
	contract_id serial NOT NULL,
	contract_active_from date NOT NULL,
	contract_active_to date,
	client_id integer NOT NULL,
	horse_id integer NOT NULL,
	employee_registration_id integer NOT NULL,
	CONSTRAINT contract_pk PRIMARY KEY (contract_id)

);
-- ddl-end --
ALTER TABLE public.contract OWNER TO postgres;
-- ddl-end --

-- object: public.service_contract_link | type: TABLE --
-- DROP TABLE IF EXISTS public.service_contract_link CASCADE;
CREATE TABLE public.service_contract_link (
	service_contract_link_id serial NOT NULL,
	contract_id integer NOT NULL,
	service_id integer NOT NULL,
	service_price_id integer NOT NULL,
	CONSTRAINT service_contract_link_pk PRIMARY KEY (service_contract_link_id)

);
-- ddl-end --
ALTER TABLE public.service_contract_link OWNER TO postgres;
-- ddl-end --

-- object: public.invoice | type: TABLE --
-- DROP TABLE IF EXISTS public.invoice CASCADE;
CREATE TABLE public.invoice (
	invoice_id serial NOT NULL,
	invoice_date date NOT NULL,
	invoice_period date NOT NULL,
	contract_id integer,
	CONSTRAINT invoice_pk PRIMARY KEY (invoice_id)

);
-- ddl-end --
ALTER TABLE public.invoice OWNER TO postgres;
-- ddl-end --

-- object: public.invoice_detail | type: TABLE --
-- DROP TABLE IF EXISTS public.invoice_detail CASCADE;
CREATE TABLE public.invoice_detail (
	invoice_detail_id serial NOT NULL,
	invoice_id integer NOT NULL,
	service_contract_link_id integer NOT NULL,
	CONSTRAINT invoice_detail_pk PRIMARY KEY (invoice_detail_id)

);
-- ddl-end --
ALTER TABLE public.invoice_detail OWNER TO postgres;
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

-- object: public.payment_distribution | type: TABLE --
-- DROP TABLE IF EXISTS public.payment_distribution CASCADE;
CREATE TABLE public.payment_distribution (
	payment_distribution_id serial NOT NULL,
	payment_distribution_ammount decimal(10,2) NOT NULL,
	payment_id integer NOT NULL,
	invoice_detail_id integer NOT NULL,
	CONSTRAINT payment_distribution_pk PRIMARY KEY (payment_distribution_id)

);
-- ddl-end --
ALTER TABLE public.payment_distribution OWNER TO postgres;
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

-- object: contract_client_fk | type: CONSTRAINT --
-- ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS contract_client_fk CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT contract_client_fk FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: contract_horse_id | type: CONSTRAINT --
-- ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS contract_horse_id CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT contract_horse_id FOREIGN KEY (horse_id)
REFERENCES public.horse (horse_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: contract_employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS contract_employee_fk CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT contract_employee_fk FOREIGN KEY (employee_registration_id)
REFERENCES public.employee (employee_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: service_contract_link_contract_fk | type: CONSTRAINT --
-- ALTER TABLE public.service_contract_link DROP CONSTRAINT IF EXISTS service_contract_link_contract_fk CASCADE;
ALTER TABLE public.service_contract_link ADD CONSTRAINT service_contract_link_contract_fk FOREIGN KEY (contract_id)
REFERENCES public.contract (contract_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: service_contract_link_service_fk | type: CONSTRAINT --
-- ALTER TABLE public.service_contract_link DROP CONSTRAINT IF EXISTS service_contract_link_service_fk CASCADE;
ALTER TABLE public.service_contract_link ADD CONSTRAINT service_contract_link_service_fk FOREIGN KEY (service_id)
REFERENCES public.service (service_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: service_contract_link_service_price_fk | type: CONSTRAINT --
-- ALTER TABLE public.service_contract_link DROP CONSTRAINT IF EXISTS service_contract_link_service_price_fk CASCADE;
ALTER TABLE public.service_contract_link ADD CONSTRAINT service_contract_link_service_price_fk FOREIGN KEY (service_price_id)
REFERENCES public.service_price (service_price_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: invoice_contract_fk | type: CONSTRAINT --
-- ALTER TABLE public.invoice DROP CONSTRAINT IF EXISTS invoice_contract_fk CASCADE;
ALTER TABLE public.invoice ADD CONSTRAINT invoice_contract_fk FOREIGN KEY (contract_id)
REFERENCES public.contract (contract_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: invoice_detail_invoice_fk | type: CONSTRAINT --
-- ALTER TABLE public.invoice_detail DROP CONSTRAINT IF EXISTS invoice_detail_invoice_fk CASCADE;
ALTER TABLE public.invoice_detail ADD CONSTRAINT invoice_detail_invoice_fk FOREIGN KEY (invoice_id)
REFERENCES public.invoice (invoice_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: invoice_detail_service_contract_link_fk | type: CONSTRAINT --
-- ALTER TABLE public.invoice_detail DROP CONSTRAINT IF EXISTS invoice_detail_service_contract_link_fk CASCADE;
ALTER TABLE public.invoice_detail ADD CONSTRAINT invoice_detail_service_contract_link_fk FOREIGN KEY (service_contract_link_id)
REFERENCES public.service_contract_link (service_contract_link_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: payment_client_fk | type: CONSTRAINT --
-- ALTER TABLE public.payment DROP CONSTRAINT IF EXISTS payment_client_fk CASCADE;
ALTER TABLE public.payment ADD CONSTRAINT payment_client_fk FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: payment_distribution_payment_fk | type: CONSTRAINT --
-- ALTER TABLE public.payment_distribution DROP CONSTRAINT IF EXISTS payment_distribution_payment_fk CASCADE;
ALTER TABLE public.payment_distribution ADD CONSTRAINT payment_distribution_payment_fk FOREIGN KEY (payment_id)
REFERENCES public.payment (payment_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: payment_distribution_invoice_detail_id | type: CONSTRAINT --
-- ALTER TABLE public.payment_distribution DROP CONSTRAINT IF EXISTS payment_distribution_invoice_detail_id CASCADE;
ALTER TABLE public.payment_distribution ADD CONSTRAINT payment_distribution_invoice_detail_id FOREIGN KEY (invoice_detail_id)
REFERENCES public.invoice_detail (invoice_detail_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- SCHEMA: golden
-- DROP SCHEMA IF EXISTS golden ;

CREATE SCHEMA IF NOT EXISTS golden
    AUTHORIZATION postgres;

-- Table: golden.client
-- DROP TABLE IF EXISTS golden.client;

CREATE TABLE IF NOT EXISTS golden.client
(
    client_id serial NOT NULL,
    person_name character varying COLLATE pg_catalog."default" NOT NULL,
    person_birth_date date NOT NULL,
    sex_name character varying COLLATE pg_catalog."default" NOT NULL,
    client_phone character varying(11) COLLATE pg_catalog."default" NOT NULL,
    client_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT client_pkey PRIMARY KEY (client_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS golden.client
    OWNER to postgres;