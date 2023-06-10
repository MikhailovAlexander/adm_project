-- FUNCTION: public.get_client_debt(integer)

-- DROP FUNCTION IF EXISTS public.get_client_debt(integer);

CREATE OR REPLACE FUNCTION public.get_client_debt(p_client_id integer)
    RETURNS decimal
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE

AS $BODY$
DECLARE v_debt decimal(10, 2);
BEGIN
  SELECT SUM(det.debt) debt
    INTO v_debt
    FROM public.get_unpaid_invoice_details_by_client(p_client_id) det;
  RETURN COALESCE(v_debt, 0);
END;
$BODY$;

ALTER FUNCTION public.get_client_debt(integer)
    OWNER TO postgres;
