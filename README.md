# WvsApp

This project includes a small framework to extend funcionality into Brazil MapleStory server files using C++.

It is composed by the following components: 
- WvsCommon - shared code among the other parts.
- WvsClient - client code that runs on top of maplestory.exe and includes bypass code for BMS and GMS V53. 
- WvsGame - extends the main gameplay binaries in server architecture architecture. 
- WvsShop - includes fixes for the cash shop server.
- WvsCenter - includes fixes for the the core part that connecteds all the server components(not implemented).
- WvsLogin - includes fixes for the login server. 

After compilation the final result will be a DLL one dll for the client component and one for each server component.

# Configuring version:

Each compilation supports either GMS Version 53 client or Brazil Maple Story and the version can be set in Config.cpp in WvsCommon project, along with other debug flags. 

# Pre requirement

To run the server binaries, it properly you usually need to setup two DNS entries in hosts file and reference it in your configuration.

```
127.0.0.1 bms_public
127.0.0.1 bmsdb
```

# Stability

We ran a nostalgic server with it supporting 50 + players and it was stable. I hope Nexon releases a classic server one day. Until then, you may want to take a look into [MapleLegends](https://maplelegends.com).

# Reversing the database queries
If you need to reverse enginneer the database queries, check SQL Profiler from Microsoft. It will allow you to debug what queries the server executes against the database.

All the game queries happen in the center server and are inside `database.dll`, you can have an idea of the table fields by using IDA and the query strings.

# Database structure

The original MapleStory server architecture uses 5 databases.

- Claim - items and items movements in the server.
- Coupon - coupons used in game.
- Game World - Gameplay information such as skills, items and characters.
- Global Account - General account Information.
- User Connection - Has a table to control when a user is connected.

All the database queries are executed asynchronously in WVsCenter server, except some login queries in WvsLogin server.

The architecture relies heavelily on stored procedures to execute game logic and sometimes stores the binary data directly into the game tables.

The procedures naming convention matches the function names found in the PDB files. Eg: `CheckEULA`, `CheckPassword`, `MoveCashItemLtoS`.

A typical reverse engineered procedure looks like this: 

```sql

ALTER PROCEDURE [dbo].[MoveCashItemLtoS]
@AccountID int,
@CharacterID int,
@SN bigint,
@number int output ,
@expiration datetime output 
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;
		UPDATE ItemLocker SET CharacterID = @CharacterID WHERE SN = @SN AND AccountID = @AccountID;
		IF @@ROWCOUNT < 1 
		BEGIN
			return (1);
		END;
		SELECT @number = Number, @expiration = ExpiredDate FROM ItemLocker WHERE SN = @SN AND CharacterID = @CharacterID;
		DECLARE @ItemID int;
		SELECT @ItemID = ItemID FROM ItemLocker WHERE SN = @SN;
		SELECT * FROM CashItemBundle WHERE CashItemSN = @SN;
		IF @@ROWCOUNT < 1 AND (@ItemID / 1000000 != 1) AND NOT(@ItemID >= 5000000 AND @ItemID <= 5000100) 
		BEGIN
			INSERT INTO CashItemBundle VALUES(@SN, @number);
		END;
	COMMIT TRANSACTION;
	return (0);
END
```

# Global Maple Story V53 support:

The BMS V8 binaries have a packet structures similar to GMS V53 which allows a GMS client  to connect  to BMS backend. Although higher versions may be supported until character selection. There are a lot of changes during version 54 that breaks some packet structures, for example, V54 is prepared to support multiple pets, while v53 not. 

Know issues:
- After a login-out there is no way to loggin again without restarting the client.

The solo purpose of this implementation was to study reversing enginnering. 
The owner of this repository is not responsable for any misusage relating to this.

