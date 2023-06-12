-- FUNCTION: public.get_schedule_id_by_day_and_service(date, integer)

-- DROP FUNCTION IF EXISTS public.get_schedule_id_by_day_and_service(date, integer);

CREATE OR REPLACE FUNCTION public.get_schedule_id_by_day_and_service(p_schedule_date date, p_service_id integer)
    RETURNS TABLE(schedule_id integer)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY
    SELECT s.schedule_id
      FROM public.schedule s
      JOIN public.employee_service_link esl ON esl.employee_service_link_id  = s.employee_service_link_id
                                           AND esl.service_id = p_service_id
     WHERE DATE(s.schedule_date_time) = DATE(p_schedule_date)
       AND s.client_id IS NULL;
END;
$BODY$;

ALTER FUNCTION public.get_schedule_id_by_day_and_service(date, integer)
    OWNER TO postgres;
