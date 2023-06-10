-- PROCEDURE: public.add_invoice(date, date, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_invoice(date, date, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_invoice(
	IN p_invoice_date date,
	IN p_invoice_period date,
	IN p_contract_id integer,
    OUT p_invoice_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  INSERT INTO public.invoice(invoice_date, invoice_period, contract_id)
	VALUES (p_invoice_date, p_invoice_period, p_contract_id)
	RETURNING invoice_id INTO p_invoice_id;

  INSERT INTO public.invoice_detail(invoice_id, service_contract_link_id)
    SELECT p_invoice_id
          ,scl.service_contract_link_id
	  FROM public.service_contract_link scl
	 WHERE scl.contract_id = p_contract_id;
END;
$BODY$;
ALTER PROCEDURE public.add_invoice(date, date, integer, integer)
    OWNER TO postgres;