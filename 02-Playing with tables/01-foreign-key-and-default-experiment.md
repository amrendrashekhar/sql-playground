# Foreign Key and Default Constraint Experiment

This experiment demonstrates how **Primary Keys, Foreign Keys, NULL values, DEFAULT constraints, and `ALTER TABLE`** work together in SQL Server.

It also demonstrates a common error:

> The INSERT statement conflicted with the FOREIGN KEY constraint.

---

# 1. The Problem We Are Trying to Solve

Suppose we have an employee table:

| ID | Name  | Salary | City      |
| -: | ----- | -----: | --------- |
|  1 | John  |  50000 | Delhi     |
|  2 | Harry |  50000 | Pune      |
|  3 | Latha |  60000 | Bangalore |

We also want to store each employee's gender.

Instead of storing:

```text
Male
Female
Other
```

directly inside every employee row, we create a separate table:

```text
tblGender
```

This gives us:

```text
tblGender

ID    Gender
1     Male
2     Female
3     Other
```

Then the employee table stores only the ID:

```text
tblEmployee

ID    Name    GenderID
1     John    1
2     Harry   1
3     Latha   2
```

This is called a **relationship between tables**.

---

# 2. What is a Primary Key?

We created:

```sql
ID INT NOT NULL PRIMARY KEY
```

A Primary Key uniquely identifies a row.

For example:

```text
ID    Gender
1     Male
2     Female
3     Other
```

The values `1`, `2`, and `3` cannot be duplicated.

A Primary Key:

* Must be unique
* Cannot contain NULL
* Identifies a row

---

# 3. What is a Foreign Key?

We created:

```sql
FOREIGN KEY (GenderID)
REFERENCES tblGender(ID)
```

This means:

```text
tblEmployee.GenderID
          ↓
     tblGender.ID
```

`tblEmployee` is the **child table**.

`tblGender` is the **parent table**.

The Foreign Key prevents us from inserting a GenderID that doesn't exist in `tblGender`.

---

# 4. Example of a Valid Foreign Key

Suppose:

```text
tblGender

ID
--
1
2
3
```

Then:

```sql
INSERT INTO tblEmployee
    (ID, Name, Salary, City, GenderID)
VALUES
    (20, 'Rahul', 50000, 'Delhi', 1);
```

works because:

```text
tblGender.ID = 1
```

exists.

---

# 5. Example of an Invalid Foreign Key

This will fail:

```sql
INSERT INTO tblEmployee
    (ID, Name, Salary, City, GenderID)
VALUES
    (21, 'Amit', 50000, 'Delhi', 5);
```

Why?

Because:

```text
tblGender.ID = 5
```

doesn't exist.

SQL Server protects the relationship between the two tables.

---

# 6. What About NULL?

This is an important point.

We created:

```sql
GenderID INT
```

rather than:

```sql
GenderID INT NOT NULL
```

Therefore `GenderID` can contain NULL.

For example:

```text
ID    Name     GenderID
10    Norry    NULL
```

This is allowed.

Why?

Because NULL means:

> No value has been provided.

It does not mean:

> GenderID = 0.

This distinction is extremely important.

---

# 7. What is a DEFAULT Constraint?

A DEFAULT provides a value automatically when an INSERT doesn't provide one.

For example:

```sql
GenderID INT DEFAULT 3
```

If we execute:

```sql
INSERT INTO tblEmployee
    (ID, Name, Salary, City)
VALUES
    (22, 'Aman', 50000, 'Delhi');
```

SQL Server automatically uses:

```text
GenderID = 3
```

We don't have to explicitly write `GenderID`.

---

# 8. DEFAULT Does Not Override a FOREIGN KEY

This is the most important lesson from this experiment.

Suppose we have:

```sql
DEFAULT 0
```

and:

```text
tblGender

ID
--
1
2
3
```

There is no `ID = 0`.

Now we execute:

```sql
INSERT INTO tblEmployee
    (ID, Name, Salary, City)
VALUES
    (23, 'Emanuel', 100000, 'Hyderabad');
```

SQL Server performs the following logic:

```text
GenderID wasn't supplied
          ↓
DEFAULT provides 0
          ↓
Foreign Key checks 0
          ↓
Does tblGender.ID = 0 exist?
          ↓
         NO
          ↓
      INSERT FAILS
```

Therefore we get:

```text
The INSERT statement conflicted with the FOREIGN KEY constraint.
```

---

# 9. Why Did the Default Not "Work"?

The DEFAULT actually **did work**.

It provided:

```text
0
```

The problem happened afterward.

The Foreign Key rejected that value.

So:

```text
DEFAULT
  ↓
provides 0
  ↓
FOREIGN KEY
  ↓
rejects 0
```

This is a very important distinction.

---

# 10. Two Ways to Fix the Problem

## Option 1 — Use a Valid Default

If:

```text
3 = Other
```

then we can use:

```sql
DEFAULT 3
```

Now:

```text
DEFAULT
   ↓
    3
   ↓
tblGender.ID = 3
   ↓
Exists
   ↓
INSERT succeeds
```

---

## Option 2 — Add an "Unknown" Record

Another design could be:

```text
ID    Gender
0     Unknown
1     Male
2     Female
3     Other
```

Then:

```sql
DEFAULT 0
```

is valid because `tblGender.ID = 0` exists.

Whether this is a good design depends on the application and database requirements.

---

# 11. NULL vs 0

These are **not the same thing**.

### NULL

Means:

> No value / unknown / not provided.

### 0

Means:

> An actual numeric value of zero.

For a Foreign Key:

```text
GenderID = NULL
```

can be allowed if the column is nullable.

But:

```text
GenderID = 0
```

must exist in the parent table.

---

# 12. Why Explicit Column Names Are Better

Instead of:

```sql
INSERT INTO tblEmployee
VALUES (2, 'Harry', 50000, 'Pune', 1);
```

prefer:

```sql
INSERT INTO tblEmployee
    (ID, Name, Salary, City, GenderID)
VALUES
    (2, 'Harry', 50000, 'Pune', 1);
```

The second version is easier to understand because we can clearly see what each value represents.

It is also safer if the table structure changes.

---

# 13. Important Commands Used

| Command          | Purpose                               |
| ---------------- | ------------------------------------- |
| `CREATE TABLE`   | Creates a table                       |
| `INSERT`         | Adds records                          |
| `SELECT`         | Retrieves records                     |
| `ALTER TABLE`    | Changes table structure               |
| `DROP COLUMN`    | Removes a column                      |
| `ADD CONSTRAINT` | Adds a constraint                     |
| `FOREIGN KEY`    | Maintains relationship between tables |
| `DEFAULT`        | Provides an automatic value           |
| `UPDATE`         | Changes existing records              |
| `sp_rename`      | Renames a database object             |
| `sp_help`        | Shows information about an object     |

---

# 14. Relationship Diagram

The relationship can be visualized as:

```text
┌─────────────────────┐
│      tblGender      │
├─────────────────────┤
│ ID       PK         │
│ Gender              │
└──────────┬──────────┘
           │
           │ ID
           │
           ▼
┌─────────────────────┐
│     tblEmployee     │
├─────────────────────┤
│ ID       PK         │
│ Name                │
│ Salary              │
│ City                │
│ GenderID FK         │
└─────────────────────┘
```

The Foreign Key connects:

```text
tblEmployee.GenderID
        ↓
tblGender.ID
```

---

# 15. What I Learned

### Primary Key

Uniquely identifies a record.

### Foreign Key

Ensures that a value exists in another table.

### NULL

Means no value has been provided.

### DEFAULT

Automatically supplies a value when one isn't provided.

### Most Important Lesson

> A DEFAULT value must still satisfy the Foreign Key constraint.

In other words:

```text
DEFAULT ≠ bypass Foreign Key
```

The database always validates the final value.

---

---

# Final Takeaway

The relationship between these concepts is:

```text
PRIMARY KEY
     ↓
Identifies the parent record
     ↓
FOREIGN KEY
     ↓
References the parent record
     ↓
DEFAULT
     ↓
Provides a value when none is supplied
     ↓
FOREIGN KEY validates that final value
```

Understanding this small experiment gives a strong foundation for working with **relational database design and constraints in SQL Server**.
