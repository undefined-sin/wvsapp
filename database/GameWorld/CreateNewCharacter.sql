USE [GameWorld]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewCharacter]    Script Date: 10/05/2021 17:56:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CreateNewCharacter]
	@AccountID int,
	@WorldID int,
	@CharacterName varchar(20),
	@Gender int,
	@FaceID int,
	@SkinID int,
	@HairID int,
	@p8 int,--hat?
	@Equip_Top int,
	@Equip_Bottom int,
	@Equip_Shoes int,
	@p12 int,--glove?
	@p13 int,--shield?
	@Equip_Weapon int,
	@STR int,
	@DEX int,
	@INT int,
	@LUK int,
	@CheckSum int,
	@NewCharacterID int output
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--INSERT INTO [Character] VALUES (@AccountID, @WorldID, @CharacterName, @Gender, GETDATE(), @SkinID, @FaceID, @HairID, 0, 1, 0, @STR, @DEX, @INT, @LUK, 50, 50, 50, 50, 0, 0, 0, 0, 0, 0, 0, @CheckSum, 0);
	INSERT INTO [Character] VALUES (@AccountID, @WorldID, @CharacterName, @Gender, GETDATE(), @SkinID, @FaceID, @HairID, 0, 1, 0, @STR, @DEX, @INT, @LUK, 50, 50, 50, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	SET @NewCharacterID = SCOPE_IDENTITY()

	--Add shoes
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-7
           ,@Equip_Shoes
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);

	--Add bottom:
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-6
           ,@Equip_Bottom
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);

	--Add top
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-5
           ,@Equip_Top
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);
	--Add weapon
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-11
           ,@Equip_Weapon
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,17
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);
    
	EXEC InventorySize_Set @NewCharacterID, 24, 24, 24, 24, 64;

	SELECT * FROM Trunk WHERE AccountID = @AccountID;
	IF @@ROWCOUNT < 1
	BEGIN
	  INSERT INTO Trunk VALUES(@AccountID, 4, 0);
	END;

	RETURN(0)
END


