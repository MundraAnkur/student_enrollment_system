class AddDatabaseTriggersForEnroll < ActiveRecord::Migration[7.0]
  def change
    execute <<~SQL
        CREATE OR REPLACE FUNCTION process_student_enrollment() RETURNS TRIGGER AS $student_enrollment$
          DECLARE
              course_code varchar;
              course_status varchar;
              course_capacity integer;
              course_enrolled integer;
              course_waitlist_capacity integer;
              course_waitlist integer;
              is_waitlist boolean;
          BEGIN
              IF (TG_OP = 'DELETE') THEN
                  course_code = OLD.course_id;
                  is_waitlist = OLD.waitlist;
                  SELECT capacity, waitlist_capacity, status, enrolled, wait_listed INTO
                  course_capacity, course_waitlist_capacity, course_status, course_enrolled, course_waitlist
                  FROM public.courses WHERE code = course_code;

                  IF (is_waitlist) THEN
                      course_waitlist = course_waitlist - 1;
                      IF (course_status = 'CLOSED') THEN
                          course_status = 'WAITLIST';
                      END IF;
                      UPDATE public.courses SET status = course_status, wait_listed = course_waitlist WHERE code = course_code;
                  ELSE
                      IF (course_status = 'OPEN') THEN
                          course_enrolled = course_enrolled - 1;
                      ELSIF (course_status = 'WAITLIST') THEN
                          IF (course_waitlist = 0) THEN
                              course_status = 'OPEN';
                              course_enrolled = course_enrolled - 1;
                          ELSE
                              course_waitlist = course_waitlist - 1;
                              UPDATE public.enrolls SET waitlist = false WHERE student_id =
                               (SELECT student_id FROM public.enrolls WHERE course_id = course_code AND waitlist = true ORDER BY created_at LIMIT 1);
                          END IF;
                      ELSE
                          IF (course_waitlist_capacity > 0) THEN
                              course_status = 'WAITLIST';
                              course_waitlist = course_waitlist - 1;
                          ELSE
                              course_status = 'OPEN';
                              course_enrolled = course_enrolled - 1;
                          END IF;
                          UPDATE public.enrolls SET waitlist = false WHERE student_id =
                          (SELECT student_id FROM public.enrolls WHERE course_id = course_code AND waitlist = true ORDER BY created_at LIMIT 1);
                      END IF;
                      UPDATE public.courses SET status = course_status, wait_listed = course_waitlist, enrolled = course_enrolled WHERE code = course_code;
                  END IF;
                  return NULL;
              ELSIF (TG_OP = 'INSERT') THEN
                  course_code = NEW.course_id;
                  SELECT capacity, waitlist_capacity, status, enrolled, wait_listed INTO
                      course_capacity, course_waitlist_capacity, course_status, course_enrolled, course_waitlist
                  FROM public.courses WHERE code = course_code;

                  IF (course_status = 'OPEN') THEN
                      course_enrolled = course_enrolled + 1;
                      IF (course_capacity = course_enrolled) THEN
                          IF (course_waitlist_capacity > 0) THEN
                              course_status = 'WAITLIST';
                          ELSE
                              course_status = 'CLOSED';
                          END IF;
                      END IF;
                  ELSIF (course_status = 'WAITLIST') THEN
                      course_waitlist = course_waitlist + 1;
                      NEW.waitlist = true;
                      IF (course_waitlist = course_waitlist_capacity) THEN
                          course_status = 'CLOSED';
                      END IF;
                  END IF;
                  UPDATE public.courses SET status = course_status, wait_listed = course_waitlist, enrolled = course_enrolled WHERE code = course_code;
                  return NEW;
          END IF;
        END;
      $student_enrollment$ LANGUAGE plpgsql;

      CREATE TRIGGER student_enrollment_del AFTER DELETE ON public.enrolls
          FOR EACH ROW EXECUTE FUNCTION process_student_enrollment();

      CREATE TRIGGER student_enrollment_ins BEFORE INSERT ON public.enrolls
          FOR EACH ROW EXECUTE FUNCTION process_student_enrollment();
    SQL
  end
end
