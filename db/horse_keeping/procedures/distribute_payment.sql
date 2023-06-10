-- PROCEDURE: public.distribute_payment(integer)

-- DROP PROCEDURE IF EXISTS public.distribute_payment(integer);

CREATE OR REPLACE PROCEDURE public.distribute_payment(IN p_payment_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_client_id integer;
DECLARE v_sum_pays decimal(10, 2);
DECLARE v_sum_to_distr decimal(10, 2);
DECLARE inv_rec RECORD;
BEGIN
  SELECT SUM(pd.payment_distribution_ammount)
    INTO v_sum_pays
    FROM public.payment_distribution pd
   WHERE pd.payment_id = p_payment_id;

  SELECT p.payment_ammount - COALESCE(v_sum_pays, 0)
        ,p.client_id
    INTO v_sum_to_distr, v_client_id
    FROM public.payment p
   WHERE p.payment_id = p_payment_id;

  FOR inv_rec IN
    SELECT inv.invoice_detail_id
          ,inv.debt
      FROM public.get_unpaid_invoice_details_by_client(v_client_id) inv
  LOOP
	IF v_sum_to_distr > 0 THEN
      INSERT INTO public.payment_distribution (payment_distribution_ammount, payment_id, invoice_detail_id)
        VALUES (LEAST(inv_rec.debt, v_sum_to_distr), p_payment_id, inv_rec.invoice_detail_id);
      v_sum_to_distr = v_sum_to_distr - LEAST(inv_rec.debt, v_sum_to_distr);
    ELSE
      RETURN;
    END IF;
  END LOOP;
END;
$BODY$;
ALTER PROCEDURE public.distribute_payment(integer)
    OWNER TO postgres;