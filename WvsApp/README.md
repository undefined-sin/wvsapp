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
127.0.0.1 bms_public
127.0.0.1 bmsdb
```
You can change bms_public to your public ip address to bind the server to a public ip.

