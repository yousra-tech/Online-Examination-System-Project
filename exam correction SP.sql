CREATE PROCEDURE CorrectQuestionsForStudent 
    @StudentId INT,
    @ExamId INT
AS
BEGIN
    -- Declare variables
    DECLARE @QuestionId INT
    DECLARE @QuestionGrade DECIMAL(5,2)
    DECLARE @QuestionCorrectAnswer VARCHAR(50)
    DECLARE @StudentAnswer VARCHAR(50)
    DECLARE @IsCorrect BIT
    DECLARE @TotalGrade DECIMAL(5,2) = 0
    
    -- Get the questions for the exam for the given student
    DECLARE question_cursor CURSOR FOR 
    SELECT q.Q_ID, q.Q_Grade, q.Right_Answer, eqs.st_answer
    FROM question q
    INNER JOIN exam e ON q.crs_id = e.Crs_id
    INNER JOIN dbo.Exam_Ques_Stud eqs ON q.Q_ID = eqs.Q_id
    WHERE e.Ex_id = @ExamId AND eqs.st_id = @StudentId

    OPEN question_cursor

    FETCH NEXT FROM question_cursor INTO @QuestionId, @QuestionGrade, @QuestionCorrectAnswer, @StudentAnswer

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check if the student's answer is correct
        
            IF @StudentAnswer = @QuestionCorrectAnswer
                UPDATE dbo.Exam_Ques_Stud
				SET st_grade = 1
				WHERE st_id = @StudentId AND ex_id = @ExamId AND Q_id = @QuestionId
            ELSE
                UPDATE dbo.Exam_Ques_Stud
				SET st_grade = 0
				WHERE st_id = @StudentId AND ex_id = @ExamId AND Q_id = @QuestionId
        
        
        -- Calculate the grade for the question
--        IF @IsCorrect = 1
--            SET @TotalGrade = @TotalGrade + @QuestionGrade
        
        -- Update the student's grade for the question
        
        
        FETCH NEXT FROM question_cursor INTO @QuestionId, @QuestionGrade, @QuestionCorrectAnswer, @StudentAnswer
    END

    CLOSE question_cursor
    DEALLOCATE question_cursor
END


EXECUTE dbo.CorrectQuestionsForStudent @StudentId = 2, -- int
                                       @ExamId = 1     -- int

