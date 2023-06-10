-- FUNCTION: public.get_unpaid_invoice_details_by_client(integer)

-- DROP FUNCTION IF EXISTS public.get_unpaid_invoice_details_by_client(integer);

CREATE OR REPLACE FUNCTION public.get_unpaid_invoice_details_by_client(p_client_id integer)
    RETURNS TABLE(contract_id integer, invoice_id integer, invoice_date date, invoice_period date, invoice_detail_id integer, service_id integer, service_price decimal(10,2), payment_ammount decimal(10,2), debt decimal(10,2))
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
  RETURN QUERY
    SELECT c.contract_id
          ,inv.invoice_id
          ,inv.invoice_date
          ,inv.invoice_period
          ,id.invoice_detail_id
          ,scl.service_id
          ,sp.service_price
          ,COALESCE(pays.payment_ammount, 0) payment_ammount
          ,sp.service_price - coalesce(pays.payment_ammount, 0) debt
      FROM public.contract c
      JOIN public.invoice inv ON c.contract_id = inv.contract_id
      JOIN public.invoice_detail id ON id.invoice_id = inv.invoice_id
      JOIN public.service_contract_link scl ON scl.service_contract_link_id = id.service_contract_link_id
      JOIN public.service_price sp ON sp.service_price_id = scl.service_price_id
      LEFT JOIN LATERAL
      (
        SELECT SUM(pd.payment_distribution_ammount) payment_ammount
          FROM public.payment_distribution pd
         WHERE pd.invoice_detail_id = id.invoice_detail_id
      )pays ON TRUE
     WHERE c.client_id  = p_client_id
       AND COALESCE(pays.payment_ammount, 0) < sp.service_price
     ORDER BY inv.invoice_period
             ,scl.service_id;
END;
$BODY$;

ALTER FUNCTION public.get_unpaid_invoice_details_by_client(integer)
    OWNER TO postgres;