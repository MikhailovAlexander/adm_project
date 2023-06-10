-- FUNCTION: public.get_managers_employee_id()

-- DROP FUNCTION IF EXISTS public.get_managers_employee_id();

CREATE OR REPLACE FUNCTION public.get_managers_employee_id()
    RETURNS TABLE(employee_id integer)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY
    SELECT e.employee_id
      FROM public.profession p
      JOIN public.employee e ON e.profession_id = p.profession_id
                            AND e.employee_fire_date is NULL
     WHERE p.profession_name = 'Manager';
END;
$BODY$;

ALTER FUNCTION public.get_managers_employee_id()
    OWNER TO postgres;