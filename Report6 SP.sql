CREATE PROC GetStudentAnswerByStudentID @StudentID int, @ExamID int
AS
SELECT Q_text, st_answer
FROM Exam_Ques_Stud eqs
INNER JOIN Question q
ON eqs.Q_id = q.Q_id
WHERE st_id = @StudentID AND ex_id = @ExamID

