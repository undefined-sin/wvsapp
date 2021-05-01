USE [GameWorld]
GO
/****** Object:  StoredProcedure [dbo].[GetRank]    Script Date: 01/05/2021 05:32:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetRank]
	@WorldID int,
	@CharacterID int,
	@Rank int = NULL output,
	@RankMove int = NULL output,
	@JobRank int = NULL output,
	@JobRankMove int = NULL output
AS
BEGIN
	EXEC GlobalAccount.dbo.GetRankJob @WorldID, @CharacterID, @JobRank = @JobRank OUTPUT;
	SELECT 
		@Rank = Rank_
	FROM(
		SELECT 
			CharacterID, 
			CharacterName, 
			B_Job, B_Level, ROW_NUMBER()  OVER(order by B_Level desc) 
			Rank_ 
		FROM 
			GameWorld.dbo.Character WHERE AccountID NOT IN (
				SELECT AccountID From GlobalAccount.dbo.Account WHERE Admin IN (1, 255) OR IsBanned = 1
			)
	) a
	WHERE 
		a.CharacterID = @CharacterID
	SET @RankMove = 0
	SET @JobRankMove = 0
	RETURN(0)
END





