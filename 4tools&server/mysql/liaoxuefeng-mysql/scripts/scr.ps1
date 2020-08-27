-- insert into
--     students (name, class_id, gender, score)
-- values
--     ('BigBao', 1, 'M', 87),
--     ('SmallBao', 2, 'M', 86);
-- update
--     students
-- set
--     score = score + 10
-- where
--     score < 80;
delete from
    students
where
    id = 14;

select
    *
from
    students;