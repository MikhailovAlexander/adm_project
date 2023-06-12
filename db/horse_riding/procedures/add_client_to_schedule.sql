-- PROCEDURE: public.add_client_to_schedule(integer, bool, bool, integer)

-- DROP PROCEDURE IF EXISTS public.add_client_to_schedule(integer, bool, bool, integer);

CREATE OR REPLACE PROCEDURE public.add_client_to_schedule(
	IN p_client_id integer,
    IN p_schedule_is_done bool,
    IN p_schedule_is_paid bool,
    IN p_schedule_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  UPDATE public.schedule
    SET client_id = p_client_id
       ,schedule_is_done = p_schedule_is_done
       ,schedule_is_paid = p_schedule_is_paid
   WHERE schedule_id = p_schedule_id;
END;
$BODY$;
ALTER PROCEDURE public.add_client_to_schedule(integer, bool, bool, integer)
    OWNER TO postgres;
