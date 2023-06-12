-- FUNCTION: public.get_service_id_by_schedule_day(date)

-- DROP FUNCTION IF EXISTS public.get_service_id_by_schedule_day(date);

CREATE OR REPLACE FUNCTION public.get_service_id_by_schedule_day(p_schedule_date date)
    RETURNS TABLE(service_id integer)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY
    SELECT DISTINCT esl.service_id
      FROM public.schedule s
      JOIN public.employee_service_link esl ON esl.employee_service_link_id  = s.employee_service_link_id
     WHERE DATE(s.schedule_date_time) = DATE(p_schedule_date)
       AND s.client_id IS NULL;
END;
$BODY$;

ALTER FUNCTION public.get_service_id_by_schedule_day(date)
    OWNER TO postgres;