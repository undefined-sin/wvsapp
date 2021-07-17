# Maple Story Game server


## Pre-requisites.

## Troubleshotting:

> I can't connect after selecting the character. What could be the problem?

Make sure the itemSN table is properly initialized before the server start for the first time.
```sql
DELETE FROM ItemInitSN;
INSERT INTO ItemInitSN VALUES(0, 0);
INSERT INTO ItemInitSN VALUES(1, 0);
INSERT INTO ItemInitSN VALUES(2, 0);
INSERT INTO ItemInitSN VALUES(3, 0);
INSERT INTO ItemInitSN VALUES(4, 0);
INSERT INTO ItemInitSN VALUES(5, 0);
INSERT INTO ItemInitSN VALUES(6, 0);
INSERT INTO ItemInitSN VALUES(7, 0);
```

> How do I configure the hosts file?

The hosts file is used to define dns entries for the server.

```text
127.0.0.1 bms_server
127.0.0.1 bmsdb
```
You can change bms_server to your public ip address to bind the server to a public ip.

The configuration files should define the `PublicIP` and the `PrivateIP` as the dns entries.
```
PublicIP = bms_server
PrivateIP = localhost 
port = 8585
```

> When I start the server it says that the Center server is already connected?

- Make sure all `wvscenter` is not executed in the background.
- Set the `CenterAddress` in `Accounts.GameWorld` table to null.
