USE [UserConnection]
GO
/****** Object:  User [centersrv]    Script Date: 17/07/2021 06:32:50 ******/
CREATE USER [centersrv] FOR LOGIN [centersrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [couponadmin]    Script Date: 17/07/2021 06:32:50 ******/
CREATE USER [couponadmin] FOR LOGIN [couponadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gamesrv]    Script Date: 17/07/2021 06:32:50 ******/
CREATE USER [gamesrv] FOR LOGIN [gamesrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [log_npt]    Script Date: 17/07/2021 06:32:50 ******/
CREATE USER [log_npt] FOR LOGIN [log_npt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [us_trading_user]    Script Date: 17/07/2021 06:32:50 ******/
CREATE USER [us_trading_user] FOR LOGIN [us_trading_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_datareader] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_owner] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_owner] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_datareader] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_owner] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_owner] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_datareader] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [us_trading_user]
GO
/****** Object:  UserDefinedFunction [dbo].[ipIntToString]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ipIntToString] 
( 
    @ip INT 
) 
RETURNS CHAR(15) 
AS 
BEGIN 
    DECLARE @o1 INT, 
        @o2 INT, 
        @o3 INT, 
        @o4 INT 
 
    IF ABS(@ip) > 2147483647 
        RETURN '255.255.255.255' 
 
    SET @o1 = @ip / 16777216 
 
    IF @o1 = 0 
        SELECT @o1 = 255, @ip = @ip + 16777216 
 
    ELSE IF @o1 < 0 
    BEGIN 
        IF @ip % 16777216 = 0 
            SET @o1 = @o1 + 256 
        ELSE 
        BEGIN 
            SET @o1 = @o1 + 255 
            IF @o1 = 128 
                SET @ip = @ip + 2147483648 
            ELSE 
                SET @ip = @ip + (16777216 * (256 - @o1)) 
        END 
    END 
    ELSE 
    BEGIN 
        SET @ip = @ip - (16777216 * @o1) 
    END 
 
    SET @ip = @ip % 16777216 
    SET @o2 = @ip / 65536 
    SET @ip = @ip % 65536 
    SET @o3 = @ip / 256 
    SET @ip = @ip % 256 
    SET @o4 = @ip 
 
    RETURN 
        REVERSE(REVERSE(CONVERT(VARCHAR(4), @o1)) + '.' + 
        REVERSE(CONVERT(VARCHAR(4), @o2)) + '.' + 
        REVERSE(CONVERT(VARCHAR(4), @o3)) + '.' + 
        REVERSE(CONVERT(VARCHAR(4), @o4))) 
END
GO
/****** Object:  Table [dbo].[Connections]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Connections](
	[AccountID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[IPStr] [varchar](15) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[CheckUserConnected]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckUserConnected]
	@AccountID int
AS
BEGIN
	declare @AlreadyConnected tinyint
	select @AlreadyConnected = COUNT(*) from Connections where AccountID = @AccountID
	if (@AlreadyConnected >= 1)
	begin
		RETURN(1)
	end
	else
	begin
		RETURN(0)
	end	
END

GO
/****** Object:  StoredProcedure [dbo].[ClearWorldConnect]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearWorldConnect]
	@p1 int = NULL
AS
BEGIN
	delete from Connections	
	RETURN (1)
END

GO
/****** Object:  StoredProcedure [dbo].[SetUserDisconnect]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetUserDisconnect]
	-- Add the parameters for the stored procedure here
	@AccountID int 
AS
BEGIN
	delete from Connections where AccountID = @AccountID
	
END

GO
/****** Object:  StoredProcedure [dbo].[TrySetUserConnect]    Script Date: 17/07/2021 06:32:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TrySetUserConnect]
	-- Add the parameters for the stored procedure here
	@AccountID int, 
	@WorldID int, 
	@IPInt bigint
AS
BEGIN
	declare @AlreadyConnected tinyint
	select @AlreadyConnected = COUNT(*) from Connections where AccountID = @AccountID
	declare @IPStr varchar(15)
	
	set @IPStr = dbo.ipIntToString(@IPInt)
	
	
	--declare @IPbanned int;
	--select @IPbanned = COUNT(*) from GlobalAccount.dbo.IPBans where IP = @IPStr;
	--if (@IPbanned > 0)
	--begin
		--RETURN(1);
	--end

	if (@AlreadyConnected >= 1)
	begin
		print '[ERROR] Already Connected - AccountID: ' + convert(varchar(20), @AccountID) + 'ady connected to channel ' + convert(varchar(20), @WorldID);
		RETURN(1)
	end
	else
	begin
		begin tran CONNECTED
		UPDATE GlobalAccount.dbo.Account set CurrentIP = @IPStr WHERE AccountID = @AccountID;
		UPDATE GameWorld.dbo.Character set CheckSum = 0 WHERE AccountID = @AccountID; -- The checksum bugs the account sometimes, so we better reset it.
		insert into Connections values (@AccountID, @WorldID, @IPStr);
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
			RETURN (1);
		END
		ELSE
			COMMIT;
		RETURN(0)
	end
	
END


GO
