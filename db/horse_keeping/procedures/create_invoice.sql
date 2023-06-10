-- PROCEDURE: public.create_invoices(date, date)

-- DROP PROCEDURE IF EXISTS public.create_invoices(date, date);

CREATE OR REPLACE PROCEDURE public.create_invoices(
	IN p_invoice_date date,
	IN p_invoice_period date)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE cont_rec RECORD;
DECLARE p_invoice_id integer;
BEGIN
  FOR cont_rec IN
    SELECT c.contract_id
      FROM public.contract c
     WHERE c.contract_active_from < p_invoice_date
       AND c.contract_active_to IS NULL
  LOOP
	CALL public.add_invoice(p_invoice_date, p_invoice_period, cont_rec.contract_id, p_invoice_id);
  END LOOP;
END;
$BODY$;
ALTER PROCEDURE public.create_invoices(date, date)
    OWNER TO postgres;