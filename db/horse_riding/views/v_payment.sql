-- View: public.v_payment

-- DROP VIEW public.v_payment;

CREATE OR REPLACE VIEW public.v_payment
  AS
  SELECT DATE(sc.schedule_date_time) payment_date
        ,s.service_name
        ,vc.person_name client_name
        ,h.horse_name
        ,ve.person_name manager_name
        ,sp.service_price payment_ammount
    FROM public.schedule sc
    JOIN public.v_client vc ON vc.client_id = sc.client_id
                           AND sc.schedule_is_paid
    JOIN public.employee_service_link esl on esl.employee_service_link_id = sc.employee_service_link_id
    JOIN public.service s ON s.service_id  = esl.service_id
    JOIN public.v_employee ve ON ve.employee_id = esl.employee_service_link_id
    JOIN public.horse_service_link hsl ON hsl.horse_service_link_id = sc.horse_service_link_id
    JOIN public.horse h ON h.horse_id = hsl.horse_id
    JOIN public.service_price sp ON sp.service_price_id = sc.service_price_id;

ALTER TABLE public.v_payment
    OWNER TO postgres;
