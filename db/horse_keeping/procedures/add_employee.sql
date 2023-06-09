-- PROCEDURE: public.add_employee(character varying, date, integer, character varying, character varying, date, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_employee(character varying, date, integer, character varying, character varying, date, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_employee(
	IN p_person_name character varying,
	IN p_person_birth_date date,
	IN p_sex_id integer,
	in p_employee_phone character varying,
	in p_employee_email character varying,
	IN p_employee_hire_date date,
	IN p_profession_id integer,
    OUT p_employee_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_person_id INT;
BEGIN
  INSERT INTO public.person(person_name, person_birth_date, sex_id)
	VALUES (p_person_name, p_person_birth_date, p_sex_id)
	RETURNING person_id INTO v_person_id;

  INSERT INTO public.employee(employee_phone, employee_email, employee_hire_date, profession_id, person_id)
	VALUES (p_employee_phone, p_employee_email, p_employee_hire_date, p_profession_id, v_person_id)
	RETURNING employee_id INTO p_employee_id;
END;
$BODY$;
ALTER PROCEDURE public.add_employee(character varying, date, integer, character varying, character varying, date, integer, integer)
    OWNER TO postgres;
