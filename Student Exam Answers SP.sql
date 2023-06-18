CREATE TYPE QuestionAnswerType AS TABLE (
    QuestionId INT,
    StudentAnswer VARCHAR(50)
)

CREATE PROCEDURE InputStudentExamAnswers2 
    @StudentId INT, 
    @ExamId INT, 
    @QuestionAnswers QuestionAnswerType READONLY
AS
BEGIN
    UPDATE dbo.Exam_Ques_Stud
    SET st_answer = qa.StudentAnswer
    FROM dbo.Exam_Ques_Stud eqs
    INNER JOIN @QuestionAnswers qa ON eqs.Q_id = qa.QuestionId
    WHERE eqs.st_id = @StudentId AND eqs.ex_id = @ExamId 
END


SELECT *
FROM dbo.Exam_Ques_Stud
WHERE st_id = 1 AND ex_id = 1





DECLARE @QuestionAnswers QuestionAnswerType
INSERT INTO @QuestionAnswers (QuestionId, StudentAnswer)
VALUES (172, 'd'), (173, 'b'), (176, 'b'), (177, 'a'), (180, 'c'), (181, 'd'), (182, 'a'), (183, 'a'), (184, 'b'), (185, 'c')
EXEC InputStudentExamAnswers2 @StudentId = 3, @ExamId = 1, @QuestionAnswers = @QuestionAnswers
