# Connecting to SQL Server using SSMS

## What is SSMS?

**SQL Server Management Studio (SSMS)** is a client tool provided by Microsoft for connecting to and working with SQL Server.

Using SSMS, we can:

* Connect to SQL Server
* Create and manage databases
* Create and modify tables
* Write and execute SQL queries
* Create stored procedures, views, functions, and triggers
* Manage users and permissions
* Analyze query performance
* Monitor SQL Server

> **Important:** SSMS is a client tool. It is not the SQL Server itself.

---

# 1. Open SQL Server Management Studio

Open **SQL Server Management Studio (SSMS)** from the Windows Start menu.

Once SSMS opens, you will see the **Connect to Server** window.

---

# 2. Select Server Type

For working with regular SQL Server databases, select:

```text
Server type: Database Engine
```

Other server types may include:

* Analysis Services (SSAS)
* Reporting Services (SSRS)
* Integration Services (SSIS)

For this SQL Playground, we will primarily work with the **Database Engine**.

---

# 3. Specify the Server Name

The server name identifies the SQL Server instance you want to connect to.

For a SQL Server instance running on your local computer, common options include:

```text
(local)
.
localhost
127.0.0.1
```

If you installed SQL Server as a named instance, you may need something like:

```text
localhost\SQLEXPRESS
```

The exact server name depends on how SQL Server was installed.

---

# 4. Select Authentication

SSMS provides authentication methods depending on your SQL Server configuration.

### Windows Authentication

Uses your Windows account to authenticate.

```text
Authentication: Windows Authentication
```

Usually, you don't need to enter a separate username and password.

### SQL Server Authentication

Uses a SQL Server login:

```text
Authentication: SQL Server Authentication

Login:
Password:
```

This requires SQL Server Authentication to be enabled on the SQL Server instance.

---

# 5. Connect

After selecting:

```text
Server type
Server name
Authentication
```

click:

**Connect**

If the connection is successful, SSMS will open the main interface.

---

# 6. Open a New Query

Click:

**New Query**

This opens the SQL query editor.

For example:

```sql
SELECT @@VERSION;
```

Execute the query using:

* **Execute** button
* `F5`
* `Ctrl + E`

The result will appear in the Results window.

---

# 7. Understanding the Architecture

A very important concept:

```text
┌─────────────────────────┐
│          SSMS           │
│     Client Tool         │
└────────────┬────────────┘
             │
             │ Connection
             ▼
┌─────────────────────────┐
│      SQL Server         │
│     Database Engine     │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│       Databases         │
│                         │
│  Company                │
│  AdventureWorks         │
│  MyDatabase             │
└─────────────────────────┘
```

SSMS is the **client**.

SQL Server is the **database server/database engine**.

You use SSMS to send commands to SQL Server.

---

# 8. First SQL Queries

After connecting to SQL Server, try these queries.

### Check SQL Server version

```sql
SELECT @@VERSION;
```

### Check the current server name

```sql
SELECT @@SERVERNAME;
```

### Check the current database

```sql
SELECT DB_NAME();
```

### Check the current SQL Server login

```sql
SELECT SUSER_NAME();
```

---

# 9. Important Concepts

| Concept                   | Meaning                                             |
| ------------------------- | --------------------------------------------------- |
| SSMS                      | Client tool used to interact with SQL Server        |
| SQL Server                | Database engine/server                              |
| Database Engine           | Component that stores and processes relational data |
| Server Name               | Identifies the SQL Server instance                  |
| Authentication            | Determines how you prove your identity              |
| Windows Authentication    | Uses your Windows account                           |
| SQL Server Authentication | Uses a SQL Server login                             |
| Query Editor              | Where SQL commands are written                      |
| Execute                   | Sends the SQL query to SQL Server                   |

---

# 🧠 What I Learned

* SSMS is a **client tool**, not the SQL Server itself.
* SQL Server can run on the same computer or on a remote machine.
* SSMS connects to a specific SQL Server instance.
* The **Database Engine** is the server component used for relational databases.
* Authentication determines how a user connects to SQL Server.
* The **New Query** window is used to write and execute SQL commands.

---

# 🔬 Experiment

Try changing the following and observe what happens:

```sql
SELECT @@VERSION;
SELECT @@SERVERNAME;
SELECT DB_NAME();
SELECT SUSER_NAME();
```

Then disconnect from SQL Server and try executing a query.

### Question

What happens when SSMS is open but the SQL Server service is stopped?

This is a useful distinction to understand:

> **SSMS can be open even when SQL Server is unavailable.**
