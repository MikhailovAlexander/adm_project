-- View: public.v_client

-- DROP VIEW public.v_client;

CREATE OR REPLACE VIEW public.v_client
  AS
  SELECT p.person_id
        ,p.person_name
        ,p.person_birth_date
        ,p.sex_id
        ,s.sex_name
        ,c.client_id
        ,c.client_phone
        ,c.client_email
    FROM public.client c
    JOIN public.person p ON p.person_id = c.person_id
    JOIN public.sex s ON s.sex_id = p.sex_id;

ALTER TABLE public.v_client
    OWNER TO postgres;