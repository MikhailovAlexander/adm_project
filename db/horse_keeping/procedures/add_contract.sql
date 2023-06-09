-- PROCEDURE: public.add_contract(character varying, date, date, integer, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_contract(character varying, date, date, integer, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_contract(
	IN p_horse_name character varying,
	IN p_horse_birth_date date,
	IN p_contract_active_from date,
	IN p_client_id integer,
	IN p_employee_registration_id integer,
    OUT p_contract_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_horse_id INT;
BEGIN
  INSERT INTO public.horse(horse_name, horse_birth_date)
	VALUES (p_horse_name, p_horse_birth_date)
	RETURNING horse_id INTO v_horse_id;

  INSERT INTO public.contract(contract_active_from, client_id, horse_id, employee_registration_id)
	VALUES (p_contract_active_from, p_client_id, v_horse_id, p_employee_registration_id)
	RETURNING contract_id INTO p_contract_id;
END;
$BODY$;
ALTER PROCEDURE public.add_contract(character varying, date, date, integer, integer, integer)
    OWNER TO postgres;
