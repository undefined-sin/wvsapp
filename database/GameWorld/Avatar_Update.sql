USE [GameWorld]
GO
/****** Object:  StoredProcedure [dbo].[Avatar_Update]    Script Date: 01/05/2021 05:35:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 for positive ints:

	a << b = a * power(2, b)
	a >> b = a / power(2, b)


*/
ALTER PROCEDURE [dbo].[Avatar_Update]
	-- Add the parameters for the stored procedure here
	@CharacterID int,
	@p2 varbinary(20),
	@p3 varbinary(2)
AS
BEGIN
	DECLARE @firstBit varbinary(1) = substring(@p2, 1, 1);
	DECLARE @secondBit varbinary(1) = substring(@p2, 2, 1);
	DECLARE @thirdBit varbinary(1) = substring(@p2, 3, 1);
	DECLARE @fourBit varbinary(1) = substring(@p2, 4, 1);
	DECLARE @Gender int = CAST((@firstBit & 1) AS int);
	DECLARE @Skin int = CAST((@firstBit / power(2, 1)) & 0xF AS int);
	DECLARE @firstCheck int = CAST((@secondBit / power(2, 7)) & 0xF AS int);
	DECLARE @v18 int;
	IF @firstCheck > 0
		BEGIN
			SET @v18 = 2000;
		END
	ELSE
	BEGIN
		SET @v18 = 1000 * @Gender;
	END;
	
	DECLARE @nFaceLow int = CAST((@firstBit / power(2, 5)) & 0x3FF AS int) + @v18 + 20000;

	SET @nFaceLow = @nFaceLow + CAST((@secondBit * power(2, 3)) AS int);

	DECLARE @anHairEquipZero int = CAST(@thirdBit as int)  & 0x3FF;
	DECLARE @anHairEquipOne int;
	IF @anHairEquipZero = 1023
	BEGIN
		SET @anHairEquipZero = 0;
	END
	ELSE
	BEGIN
		DECLARE @secondCheck int = CAST((@fourBit / power(2, 2)) & 0x1 AS int);
		DECLARE @v17 int = 0;
		IF @secondCheck > 0
		BEGIN
			SET @v17 = 2000;
		END;
		ELSE
		BEGIN
			SET @v17 = 1000 * @Gender;
		END;
		SET @anHairEquipZero = @anHairEquipZero + @v17 + 30000;
	END;
	SET @anHairEquipOne = CAST((@fourBit / power(2, 3)) & 0x3FF AS int);
	
	IF((@fourBit & 1) = 1) 
	BEGIN
	 SET @anHairEquipZero = @anHairEquipZero + 256;
	END;

	IF((@fourBit & 2^7) = 2^7)
	BEGIN
		SET @anHairEquipZero = @anHairEquipZero + 512;
	END;

	UPDATE Character 
		SET Gender = @Gender, 
			C_Skin = @Skin,
			C_Face = @nFaceLow,
			C_Hair = @anHairEquipZero
	WHERE 
		CharacterID = @CharacterID;

	SET NOCOUNT ON;

	SELECT @firstBit as firstByte, CAST((@secondBit * power(2, 3)) AS int) as secondByte,  @Gender as Gender, @Skin as Skin, @nFaceLow as Face, @anHairEquipZero as Hair, @fourBit, CASE @fourBit & 1 WHEN 1 THEN 1 WHEN 0 THEN 0 END;
	
    -- Insert statements for procedure here
	RETURN(0)
END


