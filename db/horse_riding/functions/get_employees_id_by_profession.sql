-- FUNCTION: public.get_employees_id_by_profession(varchar)

-- DROP FUNCTION IF EXISTS public.get_employees_id_by_profession(varchar);

CREATE OR REPLACE FUNCTION public.get_employees_id_by_profession(p_profession_name varchar)
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
                            AND e.employee_fire_date IS NULL
     WHERE p.profession_name = p_profession_name;
END;
$BODY$;

ALTER FUNCTION public.get_employees_id_by_profession(varchar)
    OWNER TO postgres;