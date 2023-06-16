-- View: public.v_invoice

-- DROP VIEW public.v_invoice;

CREATE OR REPLACE VIEW public.v_invoice
  AS
  SELECT i.invoice_period
        ,s.service_name
        ,vc.person_name client_name
        ,h.horse_name
        ,ve.person_name manager_name
        ,sp.service_price
    FROM public.contract c
    JOIN public.horse h ON h.horse_id = c.horse_id
    JOIN public.v_client vc ON vc.client_id = c.client_id
    JOIN public.v_employee ve ON ve.employee_id = c.employee_registration_id
    JOIN public.invoice i ON i.contract_id = c.contract_id
    JOIN public.invoice_detail id ON id.invoice_id = i.invoice_id
    JOIN public.service_contract_link scl ON scl.service_contract_link_id = id.service_contract_link_id
    JOIN public.service s ON s.service_id  = scl.service_id
    JOIN public.service_price sp ON sp.service_price_id  = scl.service_price_id;

ALTER TABLE public.v_invoice
    OWNER TO postgres;
