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

# Stability:

Crashs may happen in WvsGame.exe / WvsGame.dll and is not ready for production use yet.

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

# Global Maple Story V53 support:

The BMS V8 binaries have a packet structures similar to GMS V53 which allows a GMS client  to connect  to BMS backend. Although higher versions may be supported until character selection. There are a lot of changes during version 54 that breaks some packet structures, for example, V54 is prepared to support multiple pets, while v53 not. 

Know issues:
- After a login-out there is no way to loggin again without restarting the client.

The solo purpose of this implementation was to study reversing enginnering. 
The owner of this repository is not responsable for any misusage relating to this.

