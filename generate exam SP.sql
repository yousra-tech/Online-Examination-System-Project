USE back1

CREATE PROCEDURE RandomExamQuestionswithqtype 
    @StudentId INT, 
    @ExamId INT, 
    @NumMCQ INT,
    @NumTF INT
AS
BEGIN
    -- Create a temporary table to store the selected questions
    CREATE TABLE #SelectedQuestions (
        QuestionId INT
    )

    -- Get the list of questions for the course
    INSERT INTO #SelectedQuestions (QuestionId)
    SELECT TOP (@NumMCQ) q.Q_ID
    FROM Question q
    INNER JOIN Course c ON q.crs_id = c.Crs_ID
    INNER JOIN Exam e ON c.Crs_ID = e.crs_id
    WHERE e.Ex_id = @ExamId AND q.q_type = 'MCQ'
    ORDER BY NEWID()

    -- Get the list of true/false questions for the course
    INSERT INTO #SelectedQuestions (QuestionId)
    SELECT TOP (@NumTF) q.Q_ID
    FROM Question q
    INNER JOIN Course c ON q.crs_id = c.Crs_ID
    INNER JOIN Exam e ON c.Crs_ID = e.crs_id
    WHERE e.Ex_id = @ExamId AND q.q_type = 'T/F'
    ORDER BY NEWID()

    -- Insert the selected questions into the student_exam_question table
    INSERT INTO dbo.Exam_Ques_Stud (st_id,ex_id, Q_id)
    SELECT @StudentId, @ExamId, QuestionId
    FROM #SelectedQuestions

    -- Clean up the temporary table
    DROP TABLE #SelectedQuestions
END


EXECUTE dbo.RandomExamQuestionswithqtype @StudentId = 1, -- int
                                         @ExamId = 1,    -- int
                                         @NumMCQ = 7,    -- int
                                         @NumTF = 3      -- int
go
EXECUTE dbo.RandomExamQuestionswithqtype @StudentId = 2, -- int
                                         @ExamId = 1,    -- int
                                         @NumMCQ = 6,    -- int
                                         @NumTF = 4      -- int
										 @NumTF = 3      -- int
go
EXECUTE dbo.RandomExamQuestionswithqtype @StudentId = 3, -- int
                                         @ExamId = 1,    -- int
                                         @NumMCQ = 5,    -- int
                                         @NumTF = 5      -- int

