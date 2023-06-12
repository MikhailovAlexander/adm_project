-- PROCEDURE: public.add_horse(character varying, date)

-- DROP PROCEDURE IF EXISTS public.add_horse(character varying, date);

CREATE OR REPLACE PROCEDURE public.add_horse(
	IN p_horse_name character varying,
	IN p_horse_birth_date date,
    OUT p_horse_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  INSERT INTO public.horse(horse_name, horse_birth_date)
	VALUES (p_horse_name, p_horse_birth_date)
	RETURNING horse_id INTO p_horse_id;
END;
$BODY$;
ALTER PROCEDURE public.add_horse(character varying, date)
    OWNER TO postgres;
