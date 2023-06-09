-- PROCEDURE: public.add_client(character varying, date, integer, character varying, character varying, integer)

-- DROP PROCEDURE IF EXISTS public.add_client(character varying, date, integer, character varying, character varying, integer);

CREATE OR REPLACE PROCEDURE public.add_client(
	IN p_person_name character varying,
	IN p_person_birth_date date,
	IN p_sex_id integer,
	IN p_client_phone character varying,
	IN p_client_email character varying,
    OUT p_client_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_person_id INT;
BEGIN
  INSERT INTO public.person(person_name, person_birth_date, sex_id)
	VALUES (p_person_name, p_person_birth_date, p_sex_id)
	RETURNING person_id INTO v_person_id;

  INSERT INTO public.client(client_phone, client_email, person_id)
	VALUES (p_client_phone, p_client_email, v_person_id)
	RETURNING client_id INTO p_client_id;
END;
$BODY$;
ALTER PROCEDURE public.add_client(character varying, date, integer, character varying, character varying, integer)
    OWNER TO postgres;