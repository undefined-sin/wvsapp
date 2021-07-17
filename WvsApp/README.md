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
