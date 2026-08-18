# Creating, Altering and Dropping a Database

SQL Server databases can be created and managed in two ways:

1. Graphically using SSMS
2. Using T-SQL

For this repository, the primary focus is on using **T-SQL**.

---

## Creating a Database

```sql
CREATE DATABASE SQLPlayground;
```

This creates a new database named `SQLPlayground`.

The database can also be created graphically in SSMS:

**Object Explorer → Databases → Right Click → New Database**

---

## Database Files

A SQL Server database normally consists of data and transaction-log files.

### Data File

The data file stores database data and objects.

Common extension:

```text
.mdf
```

### Transaction Log File

The transaction log records database changes and is important for transaction management and recovery.

Common extension:

```text
.ldf
```

Conceptually:

```text
SQLPlayground
│
├── SQLPlayground.mdf
│
└── SQLPlayground_log.ldf
```

SQL Server manages these files internally.

---

# Using a Database

After creating a database:

```sql
USE SQLPlayground;
```

Check the current database:

```sql
SELECT DB_NAME();
```

---

# Renaming a Database

A database can be renamed using:

```sql
ALTER DATABASE SQLPlayground
MODIFY NAME = SQLPlaygroundDemo;
```

It is generally safest to perform database-level administrative operations from the `master` database rather than from the database being modified.

---

# Dropping a Database

A database can be permanently removed using:

```sql
DROP DATABASE SQLPlaygroundDemo;
```

> ⚠️ **Warning:** `DROP DATABASE` is destructive. Use it only with databases that can safely be deleted.

---

# Database Currently in Use

If a database has active connections, SQL Server may prevent operations that require exclusive access.

For a test database, we can use:

```sql
ALTER DATABASE SQLPlaygroundDemo
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
```

Then:

```sql
DROP DATABASE SQLPlaygroundDemo;
```

### What does `ROLLBACK IMMEDIATE` mean?

It immediately terminates existing connections and rolls back incomplete transactions.

This should be used carefully on production databases.

---

# Useful Commands

### List databases

```sql
SELECT name
FROM sys.databases;
```

### Get current database

```sql
SELECT DB_NAME();
```

### Get database ID

```sql
SELECT DB_ID('SQLPlayground');
```

### Switch database

```sql
USE SQLPlayground;
```

---

# Complete Database Lifecycle

```text
CREATE
   ↓
USE
   ↓
ALTER
   ↓
WORK WITH DATABASE
   ↓
DROP
```

---

# 🧠 What I Learned

* `CREATE DATABASE` creates a database.
* `USE` changes the current database context.
* `ALTER DATABASE` modifies database-level properties.
* `DROP DATABASE` removes a database.
* `.mdf` is commonly used for the primary data file.
* `.ldf` is commonly used for the transaction log.
* Active connections can prevent certain database operations.
* `SINGLE_USER WITH ROLLBACK IMMEDIATE` can terminate existing connections and roll back incomplete transactions.

---

# 🔬 Experiments

## Experiment 1 — Duplicate Database

Try creating the same database twice:

```sql
CREATE DATABASE SQLPlayground;
GO

CREATE DATABASE SQLPlayground;
GO
```

Observe the error.

---

## Experiment 2 — Current Database

Run:

```sql
SELECT DB_NAME();
```

Then:

```sql
USE master;
GO

SELECT DB_NAME();
```

Observe how the result changes.

---

## Experiment 3 — Active Connection

Connect to a database using one query window and attempt to drop it from another connection.

Observe the error and understand why SQL Server prevents the operation.

---

# Key Takeaway

A database is more than just a collection of tables.

SQL Server manages:

* Data
* Transactions
* Metadata
* Recovery information
* Database files
* Security
* Database objects

Understanding database-level operations is the foundation for everything that follows in this SQL Playground.
