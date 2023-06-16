-- View: public.v_payment

-- DROP VIEW public.v_payment;

CREATE OR REPLACE VIEW public.v_payment
  AS
  SELECT p.payment_date
        ,s.service_name
        ,vc.person_name client_name
        ,h.horse_name
        ,ve.person_name manager_name
        ,pd.payment_distribution_ammount payment_ammount
    FROM public.payment p
    JOIN public.payment_distribution pd ON pd.payment_id = p.payment_id
    JOIN public.invoice_detail id ON id.invoice_detail_id = pd.invoice_detail_id
    JOIN public.invoice i ON i.invoice_id = id.invoice_id
    JOIN public.contract c ON c.contract_id = i.contract_id
    JOIN public.horse h ON h.horse_id = c.horse_id
    JOIN public.v_client vc ON vc.client_id = c.client_id
    JOIN public.v_employee ve ON ve.employee_id = c.employee_registration_id
    JOIN public.service_contract_link scl ON scl.service_contract_link_id = id.service_contract_link_id
    JOIN public.service s ON s.service_id  = scl.service_id;

ALTER TABLE public.v_payment
    OWNER TO postgres;
