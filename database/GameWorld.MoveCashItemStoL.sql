USE [GameWorld]
GO
/****** Object:  StoredProcedure [dbo].[MoveCashItemStoL]    Script Date: 01/05/2021 05:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MoveCashItemStoL]
@AccountID int,
@characterID int,
@SN bigint,
@Name varchar(20) output,
@ItemID int output,
@PaybackRate int output,
@DiscountRate int output
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;
	UPDATE ItemLocker SET CharacterID = 0 
		WHERE 
			AccountID = @AccountID AND
			characterID = @characterID AND SN = @SN;
	IF @@ROWCOUNT < 1 
		BEGIN
			return (1);
	END;
	Select @name = buyCharacterID, 
			@ItemID = ItemID, @PaybackRate = 0, @DiscountRate = 0  FROM ItemLocker
	  WHERE 
		AccountID = @AccountID AND
		characterID = @characterID AND
		SN = @SN;
	
	

	 DELETE FROM CashItemBundle WHERE CashItemSN = @SN;
	COMMIT TRANSACTION;
	return(0);
END

