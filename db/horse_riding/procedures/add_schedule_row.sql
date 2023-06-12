-- PROCEDURE: public.add_schedule_row(timestamp, integer, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_schedule_row(timestamp, integer, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_schedule_row(
	IN p_schedule_date_time timestamp,
	IN p_employee_service_link_id integer,
    IN p_horse_service_link_id integer,
    IN p_employee_registration_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_service_price_id INT;
BEGIN
  SELECT sp.service_price_id
    INTO v_service_price_id
    FROM public.employee_service_link esl
    JOIN public.service_price sp ON sp.service_id = esl.service_id
   WHERE esl.employee_service_link_id = p_employee_service_link_id
     AND sp.service_price_active_to IS NULL
   ORDER BY sp.service_price_active_from DESC
   LIMIT 1;

  INSERT INTO public.schedule(schedule_date_time, schedule_is_done, schedule_is_paid, employee_service_link_id, horse_service_link_id, employee_registration_id, service_price_id)
	VALUES
	(
	  p_schedule_date_time,
	  false,
	  false,
	  p_employee_service_link_id,
	  p_horse_service_link_id,
	  p_employee_registration_id,
	  v_service_price_id
	);
END;
$BODY$;
ALTER PROCEDURE public.add_schedule_row(timestamp, integer, integer, integer)
    OWNER TO postgres;