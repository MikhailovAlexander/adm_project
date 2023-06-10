-- PROCEDURE: public.add_payment(date, decimal, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_payment(date, decimal, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_payment(
	IN p_payment_date date,
	IN p_payment_ammount decimal,
	IN p_client_id integer,
    OUT p_payment_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  INSERT INTO public.payment(payment_date, payment_ammount, client_id)
	VALUES (p_payment_date, p_payment_ammount, p_client_id)
	RETURNING payment_id INTO p_payment_id;
END;
$BODY$;
ALTER PROCEDURE public.add_payment(date, decimal, integer, integer)
    OWNER TO postgres;
