# 🗄️ SQL Playground

A hands-on **Microsoft SQL Server** learning repository where I practice SQL concepts, experiment with database behavior, solve problems, and document what I learn.

The goal is not just to memorize SQL syntax, but to understand **how SQL Server works internally and how to write reliable, efficient queries**.

---

## 🎯 Goals

* Build strong SQL fundamentals
* Understand Microsoft SQL Server deeply
* Practice SQL through hands-on experiments
* Understand database constraints and relationships
* Learn query optimization and indexing
* Understand transactions and concurrency
* Practice advanced SQL Server features
* Document errors, experiments, and lessons learned
* Build a consistent GitHub learning history

---

## 🛠️ Database

**Database:** Microsoft SQL Server

**Tools:**

* SQL Server Management Studio (SSMS)
* Git
* GitHub

---

# 📚 Topics

## 01. Database & Tables

* Connecting to SQL Server
* Working with databases
* Creating and working with tables
* Identity columns
* Retrieving identity column values
* Altering table columns
* Re-runnable SQL Server scripts

---

## 02. Constraints

* Default Constraint
* Primary Key
* Foreign Key
* Cascading Referential Integrity
* Check Constraint
* Unique Key Constraint

---

## 03. SELECT & Filtering

* SELECT statement
* WHERE
* ORDER BY
* DISTINCT
* NULL handling
* WHERE vs HAVING
* SELECT INTO

---

## 04. Grouping & Aggregation

* GROUP BY
* HAVING
* GROUPING SETS
* ROLLUP
* CUBE
* GROUPING
* GROUPING_ID

---

## 05. Joins

* Basic Joins
* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL JOIN
* Advanced Joins
* Self Join
* CROSS JOIN
* CROSS APPLY
* OUTER APPLY

---

## 06. NULL & Set Operations

* Different ways to replace NULL
* COALESCE
* UNION
* UNION ALL
* INTERSECT
* EXCEPT
* EXCEPT vs NOT IN

---

## 07. String Functions

* Built-in String Functions
* LEFT
* RIGHT
* CHARINDEX
* SUBSTRING
* REPLICATE
* SPACE
* PATINDEX
* REPLACE
* STUFF

---

## 08. Date & Time Functions

* ISDATE
* DAY
* MONTH
* YEAR
* DATENAME
* DATEPART
* DATEADD
* DATEDIFF
* CAST
* CONVERT
* EOMONTH
* DATEFROMPARTS
* DATETIME vs SMALLDATETIME
* DATETIME vs DATETIME2
* DATETIME2FROMPARTS

---

## 09. Mathematical Functions

* Mathematical functions
* Numeric calculations
* Rounding and numeric manipulation

---

## 10. User Defined Functions

* Scalar User Defined Functions
* Inline Table Valued Functions
* Multi-Statement Table Valued Functions
* Important concepts related to SQL Server functions

---

## 11. Stored Procedures

* Creating Stored Procedures
* Input Parameters
* Output Parameters
* Output Parameters vs Return Values
* Advantages of Stored Procedures
* Optional Parameters
* Table-Valued Parameters
* Sending DataTables to Stored Procedures
* Debugging Stored Procedures

---

## 12. Views

* Creating Views
* Updatable Views
* Indexed Views
* View Limitations

---

## 13. Temporary Tables

* Temporary Tables
* Local Temporary Tables
* Global Temporary Tables
* Temporary Tables in Dynamic SQL

---

## 14. Indexes

* What are Indexes?
* Clustered Indexes
* Non-Clustered Indexes
* Unique Indexes
* Non-Unique Indexes
* Advantages of Indexes
* Disadvantages of Indexes
* Index Performance

---

## 15. Triggers

### DML Triggers

* DML Triggers
* AFTER UPDATE Trigger
* INSTEAD OF INSERT
* INSTEAD OF UPDATE
* INSTEAD OF DELETE

### DDL Triggers

* DDL Triggers
* Server-Scoped DDL Triggers
* Trigger Execution Order
* Auditing Table Changes

### Other Triggers

* Logon Triggers

---

## 16. Subqueries & CTEs

* Subqueries
* Correlated Subqueries
* Derived Tables
* Common Table Expressions
* Updatable CTEs
* Recursive CTEs

---

## 17. Database Normalization

* First Normal Form (1NF)
* Second Normal Form (2NF)
* Third Normal Form (3NF)

---

## 18. PIVOT & UNPIVOT

* PIVOT Operator
* UNPIVOT
* Reverse PIVOT

---

## 19. Error Handling

* Error Handling in SQL Server
* Legacy SQL Server Error Handling
* TRY...CATCH
* Error Functions
* Handling SQL Server Errors

---

## 20. Transactions

* Transactions
* BEGIN TRANSACTION
* COMMIT
* ROLLBACK
* SAVEPOINT
* ACID Properties

---

## 21. Concurrency & Isolation Levels

* Concurrent Transactions
* Dirty Reads
* Lost Updates
* Non-Repeatable Reads
* Phantom Reads
* Snapshot Isolation
* Read Committed Snapshot Isolation
* Snapshot Isolation vs Read Committed Snapshot

---

## 22. Deadlocks & Blocking

* Deadlock Example
* Deadlock Victim Selection
* Logging Deadlocks
* Deadlock Analysis
* Deadlock Prevention
* Capturing Deadlocks
* Deadlock Error Handling
* Handling Deadlocks in ADO.NET
* Retry Logic for Deadlock Exceptions
* Finding Blocking Queries

---

## 23. Window Functions

* OVER Clause
* ROW_NUMBER
* RANK
* DENSE_RANK
* RANK vs DENSE_RANK vs ROW_NUMBER
* Running Totals
* NTILE
* LEAD
* LAG
* FIRST_VALUE
* LAST_VALUE
* Window Functions
* ROWS vs RANGE

---

## 24. Database Metadata & Objects

* List All Tables
* Object Dependencies
* `sys.dm_sql_referencing_entities`
* `sp_depends`
* Sequence Objects
* Sequence vs Identity
* GUID
* Checking GUID for NULL or Empty Values

---

## 25. Dynamic SQL

* Dynamic SQL
* Dynamic SQL in Stored Procedures
* `EXEC` vs `sp_executesql`
* Dynamic Table Names
* `QUOTENAME`
* Dynamic SQL Output Parameters
* Temporary Tables in Dynamic SQL
* SQL Injection
* Preventing SQL Injection
* Dynamic SQL vs Stored Procedures

---

## 26. Performance

* Creating Large Tables with Random Data
* Performance Testing
* Subquery vs JOIN
* Query Plan Cache
* Index Performance
* Query Optimization

---

## 27. Cursors

* Cursors in SQL Server
* Cursor Performance
* Replacing Cursors with JOINs
* Set-Based Operations vs Cursors

---

## 28. MERGE

* MERGE Statement
* INSERT / UPDATE / DELETE using MERGE
* MERGE Use Cases

---

## 29. Pagination

* OFFSET
* FETCH NEXT
* Pagination in SQL Server

---

## 30. Built-in Functions

* CHOOSE
* IIF
* TRY_PARSE
* TRY_CONVERT
* EOMONTH
* DATEFROMPARTS

---

# 🧪 Learning Philosophy

Each topic is practiced using hands-on SQL scripts.

Instead of simply writing:

```sql
SELECT * FROM Employee;
```

I try to understand:

> **What happens? Why does it happen? What happens if I change it?**

Each experiment may contain:

1. Concept
2. Example
3. Experiment
4. Expected result
5. Error / unexpected behavior
6. Explanation
7. Lesson learned

---

# 🐛 Errors & Debugging

A separate section is maintained for SQL Server errors and debugging experiments.

Examples:

* Foreign Key Constraint Errors
* Duplicate Key Errors
* NULL Constraint Errors
* Conversion Errors
* Deadlocks
* Blocking
* Query Performance Problems

### Example

```text
31-errors-and-debugging/
└── 01-foreign-key-error.sql
```

A mistake is not deleted.

It is documented and turned into a learning example.

---

# 📁 Repository Structure

```text
sql-playground/
│
├── 00-setup/
├── 01-database-and-tables/
├── 02-constraints/
├── 03-select-and-filtering/
├── 04-grouping-and-aggregation/
├── 05-joins/
├── 06-null-and-set-operations/
├── 07-string-functions/
├── 08-date-functions/
├── 09-mathematical-functions/
├── 10-functions/
├── 11-stored-procedures/
├── 12-views/
├── 13-temporary-tables/
├── 14-indexes/
├── 15-triggers/
├── 16-subqueries-and-cte/
├── 17-normalization/
├── 18-pivoting/
├── 19-error-handling/
├── 20-transactions/
├── 21-isolation-and-concurrency/
├── 22-deadlocks-and-blocking/
├── 23-window-functions/
├── 24-database-metadata/
├── 25-dynamic-sql/
├── 26-performance/
├── 27-cursors/
├── 28-merge-and-sequence/
├── 29-pagination/
├── 30-misc-functions/
└── 31-errors-and-debugging/
```

---

# 📝 SQL File Convention

Each SQL file follows a consistent structure:

```sql
/*
=========================================================
TOPIC: Foreign Key Constraint
=========================================================

PURPOSE:
Understand how foreign keys maintain referential integrity.

CONCEPTS:
- Parent table
- Child table
- Foreign key
- Referential integrity
=========================================================
*/

-- Example

-- Experiment

-- Result

-- Lesson Learned
```

This makes the repository easier to understand and revisit later.

---
---

# 🚀 How I Use This Repository

For every new concept:

```text
Learn
  ↓
Write SQL
  ↓
Experiment
  ↓
Break it
  ↓
Understand the error
  ↓
Fix it
  ↓
Document the lesson
  ↓
Commit to Git
```

Example Git workflow:

```bash
git add .
git commit -m "learn foreign key constraints"
git push
```

---

# 🎓 Objective

The final goal of this repository is to develop a strong understanding of:

**SQL → Database Design → SQL Server Internals → Query Optimization → Transactions → Concurrency → Performance**

rather than simply memorizing SQL commands.

---

## ⭐ Progress is measured by understanding, not by the number of queries written.

> **Learn it. Break it. Fix it. Document it.**

