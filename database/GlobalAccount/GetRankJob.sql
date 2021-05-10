USE [GlobalAccount]
GO
/****** Object:  StoredProcedure [dbo].[GetRankJob]    Script Date: 10/05/2021 17:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetRankJob]
@WorldID int,
@CharacterID int,
@JobRank int output
AS
BEGIN
	DECLARE @CharacterJob int;
	SELECT @CharacterJob = B_Job FROM GameWorld.dbo.Character WHERE CharacterID = @CharacterID;
	
	SELECT 
		@JobRank = a.JobRank
	FROM(
		SELECT 
			CharacterID, 
			CharacterName, 
			B_Job, B_Level, ROW_NUMBER()  OVER(order by B_Level desc) 
			JobRank 
		FROM 
			GameWorld.dbo.Character
		WHERE 
			(B_Job / 100) = @CharacterJob / 100
			AND AccountID NOT IN (
				SELECT AccountID From GlobalAccount.dbo.Account WHERE Admin IN (1, 255)
			)
	) a
	WHERE a.CharacterID = @CharacterID

	RETURN(0);
END;

