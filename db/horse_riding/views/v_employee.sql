-- View: public.v_employee

-- DROP VIEW public.v_employee;

CREATE OR REPLACE VIEW public.v_employee
  AS
  SELECT p.person_id
        ,p.person_name
        ,p.person_birth_date
        ,p.sex_id
        ,s.sex_name
        ,e.employee_id
        ,e.employee_phone
        ,e.employee_email
        ,e.employee_hire_date
        ,e.employee_fire_date
        ,pr.profession_id
        ,pr.profession_name
    FROM public.employee e
    JOIN public.person p ON p.person_id = e.person_id
    JOIN public.sex s ON s.sex_id = p.sex_id
    JOIN public.profession pr on pr.profession_id  = e.profession_id;

ALTER TABLE public.v_employee
    OWNER TO postgres;