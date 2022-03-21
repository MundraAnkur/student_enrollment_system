CREATE OR REPLACE FUNCTION process_course() RETURNS TRIGGER AS
$course_status$
DECLARE
    available_capacity   integer;
    wait_listed_students integer;
BEGIN
    IF (NEW.capacity > OLD.capacity OR NEW.waitlist_capacity > OLD.waitlist_capacity) THEN
        available_capacity = NEW.capacity - NEW.enrolled;
        IF (available_capacity > 0) THEN
            SELECT count(student_id)
            INTO wait_listed_students
            FROM enrolls
            WHERE course_id = NEW.code and waitlist = true;
            UPDATE enrolls
            SET waitlist = false
            WHERE course_id = NEW.code
              and student_id IN
                  (SELECT student_id
                   FROM enrolls
                   WHERE course_id = NEW.code and waitlist = true
                   ORDER BY created_at
                   LIMIT available_capacity);
            IF (wait_listed_students < available_capacity) THEN
                NEW.enrolled = NEW.enrolled + wait_listed_students;
                NEW.wait_listed = 0;
                NEW.status = 'OPEN';
            ELSE
                NEW.enrolled = NEW.enrolled + available_capacity;
                NEW.wait_listed = NEW.wait_listed - available_capacity;
                NEW.status = 'WAITLIST';
            END IF;
        ELSE
            NEW.status = 'WAITLIST';
        END IF;
    END IF;
    return NEW;
END;
$course_status$ LANGUAGE plpgsql;

CREATE TRIGGER course_status_update
    BEFORE UPDATE
    ON public.courses
    FOR EACH ROW
EXECUTE FUNCTION process_course();