-- PROCEDURE: public.add_service_to_contract(integer, integer, integer)

-- DROP PROCEDURE IF EXISTS public.add_service_to_contract(integer, integer, integer);

CREATE OR REPLACE PROCEDURE public.add_service_to_contract(
	IN p_contract_id integer,
	IN p_service_id integer,
    OUT p_service_contract_link_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_service_price_id INT;
BEGIN
  SELECT sp.service_price_id
    INTO v_service_price_id
    FROM public.service_price sp
   WHERE sp.service_id = p_service_id
     AND sp.service_price_active_to IS NULL
   ORDER BY sp.service_price_active_from DESC
   LIMIT 1;

  INSERT INTO public.service_contract_link(contract_id, service_id, service_price_id)
	VALUES (p_contract_id, p_service_id, v_service_price_id)
	RETURNING service_contract_link_id INTO p_service_contract_link_id;
END;
$BODY$;
ALTER PROCEDURE public.add_service_to_contract(integer, integer, integer)
    OWNER TO postgres;