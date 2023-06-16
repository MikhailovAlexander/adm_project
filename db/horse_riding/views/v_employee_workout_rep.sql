-- View: public.v_employee_workout_rep

-- DROP VIEW public.v_employee_workout_rep;

CREATE OR REPLACE VIEW public.v_employee_workout_rep
  AS
  SELECT DATE_TRUNC('month', sc.schedule_date_time) workout_month
        ,s.service_name
        ,ve.person_name employee_name
        ,COUNT(sc.schedule_id) workout_cnt
    FROM public.schedule sc
    JOIN public.employee_service_link esl on esl.employee_service_link_id = sc.employee_service_link_id
    JOIN public.service s ON s.service_id = esl.service_id
    JOIN public.v_employee ve ON ve.employee_id = esl.employee_service_link_id
   WHERE sc.schedule_is_done
   GROUP BY DATE_TRUNC('month', sc.schedule_date_time)
           ,s.service_name
           ,ve.person_name;

ALTER TABLE public.v_employee_workout_rep
    OWNER TO postgres;
