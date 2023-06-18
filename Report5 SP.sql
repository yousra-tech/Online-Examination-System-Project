
create PROC GetQuestions_ChoicesByExamID @ExamID int
AS 
SELECT Q_ID, Q_text, EX_id
FROM Exam E INNER JOIN Question Q
ON E.Crs_id = Q.crs_id
WHERE Ex_id = @ExamID


