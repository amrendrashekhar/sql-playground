
/*
===============================================================================
TOPIC: FOREIGN KEY + DEFAULT CONSTRAINT EXPERIMENT
===============================================================================

LEVEL:
    Beginner

CONCEPTS COVERED:
    1. Creating a table
    2. Primary Key
    3. Inserting records
    4. Renaming a table
    5. ALTER TABLE
    6. Adding a column
    7. Foreign Key
    8. Removing a column
    9. NULL values
    10. DEFAULT constraint
    11. How DEFAULT interacts with FOREIGN KEY
    12. Debugging a FOREIGN KEY error
    13. sp_help

IMPORTANT:
    Run this script against a TEST/LEARNING database.

===============================================================================
*/


/*
===============================================================================
STEP 1: CREATE THE tblGender TABLE
===============================================================================

We need a parent table that stores valid genders.

ID is the PRIMARY KEY.

A Primary Key:
    - Uniquely identifies each row.
    - Cannot contain NULL.
    - Cannot contain duplicate values.

Example:

    ID    Gender
    1     Male
    2     Female
    3     Other
===============================================================================
*/

CREATE TABLE tblGender
(
    ID INT NOT NULL PRIMARY KEY,
    Gender NVARCHAR(20)
);
GO


/*
===============================================================================
STEP 2: INSERT DATA INTO tblGender
===============================================================================

We need valid Gender IDs before we create the Foreign Key.

Here we add:

    ID = 1 -> Male
    ID = 2 -> Female
    ID = 3 -> Other

===============================================================================
*/

INSERT INTO tblGender (ID, Gender)
VALUES
    (1, 'Male'),
    (2, 'Female'),
    (3, 'Other');
GO


/*
===============================================================================
STEP 3: VIEW tblGender
===============================================================================
*/

SELECT *
FROM tblGender;
GO


/*
Expected result:

ID    Gender
----  -------
1     Male
2     Female
3     Other
*/


/*
===============================================================================
STEP 4: RENAME THE EXISTING EMPLOYEE TABLE
===============================================================================

Assumption:
    A table named Employee already exists.

We rename it to tblEmployee.

sp_rename is a SQL Server system stored procedure.

===============================================================================
*/

Create table Employee (
    id int primary key, 
    Name nvarchar(30),
    Salary int ,
    City nvarchar(30),
)

EXEC sp_rename 'Employee', 'tblEmployee';

/*
===============================================================================
STEP 5: ADD GenderID TO tblEmployee
===============================================================================

The existing employee table does not yet have a GenderID column.

We add it now.

IMPORTANT:
    We are NOT making it NOT NULL.

Therefore existing rows will initially contain:

    GenderID = NULL

===============================================================================
*/

ALTER TABLE tblEmployee
ADD GenderID INT;
GO


insert into tblEmployee values (2, 'Harry', 50000, 'Pune',1)
insert into tblEmployee values(3,'Latha',60000,'Bnglore',2)
insert into tblEmployee values(4,'Amit',160000,'Pune',1)
insert into tblEmployee values(5,'Monika',30000,'Pune',2)
insert into tblEmployee values(6,'Deepali',40000,'Noida',2)
insert into tblEmployee values(7,'Neha',40000,'Indore',2)
insert into tblEmployee values(8,'Dimple',20000,'Jaipur',2)
insert into tblEmployee values(9,'Orry',80000,'Mumai',3)


/*
===============================================================================
STEP 6: VIEW tblEmployee
===============================================================================
*/

SELECT *
FROM tblEmployee;
GO


/*
===============================================================================
STEP 7: ADD THE FOREIGN KEY
===============================================================================

We want:

    tblEmployee.GenderID
            |
            |
            v
    tblGender.ID

This means that every non-NULL GenderID in tblEmployee
must already exist as an ID in tblGender.

For example:

    GenderID = 1  -> Valid
    GenderID = 2  -> Valid
    GenderID = 3  -> Valid
    GenderID = 5  -> Invalid
    GenderID = 0  -> Invalid
    GenderID = NULL -> Allowed because GenderID is nullable

===============================================================================
*/

ALTER TABLE tblEmployee
ADD CONSTRAINT tblEmployee_GenderID_FK
FOREIGN KEY (GenderID)
REFERENCES tblGender(ID);
GO


/*
===============================================================================
STEP 8: REMOVE THE OLD Gender COLUMN
===============================================================================

We now have GenderID, so we no longer need the old Gender column.

IMPORTANT:
    DROP COLUMN permanently removes the column from the table.

===============================================================================
*/

ALTER TABLE tblEmployee
DROP COLUMN Gender;
GO


/*
===============================================================================
STEP 9: VIEW THE TABLE STRUCTURE
===============================================================================
*/

SELECT *
FROM tblEmployee;
GO


/*
===============================================================================
STEP 10: INSERT EMPLOYEES WITH VALID GenderID VALUES
===============================================================================

We explicitly specify the column names.

This is recommended instead of:

    INSERT INTO tblEmployee VALUES (...)

because explicitly specifying columns makes the query easier to understand
and safer if the table structure changes.

===============================================================================
*/

INSERT INTO tblEmployee
    (ID, Name, Salary, City, GenderID)
VALUES
    (2, 'Harry',   50000,  'Pune',    1),
    (3, 'Latha',   60000,  'Bangalore', 2),
    (4, 'Amit',    160000, 'Pune',    1),
    (5, 'Monika',  30000,  'Pune',    2),
    (6, 'Deepali', 40000,  'Noida',   2),
    (7, 'Neha',    40000,  'Indore',  2),
    (8, 'Dimple',  20000,  'Jaipur',  2),
    (9, 'Orry',    80000,  'Mumbai',  3);
GO


/*
===============================================================================
STEP 11: VERIFY THE DATA
===============================================================================
*/

SELECT *
FROM tblEmployee;
GO


/*
===============================================================================
STEP 12: INSERT AN EMPLOYEE WITHOUT GenderID
===============================================================================

At this point there is NO DEFAULT constraint on GenderID.

Therefore, if we don't provide GenderID, SQL Server inserts NULL.

This is allowed because GenderID was created as:

    GenderID INT

and not:

    GenderID INT NOT NULL

===============================================================================
*/

INSERT INTO tblEmployee
    (ID, Name, Salary, City)
VALUES
    (10, 'Norry', 90000, 'Mumbai');
GO


/*
Check the result.

GenderID for Norry should be NULL.
*/

SELECT *
FROM tblEmployee
WHERE ID = 10;
GO


/*
===============================================================================
STEP 13: UPDATE AN EMPLOYEE'S GenderID
===============================================================================

We can change an employee's GenderID as long as the new value exists
in tblGender.

Here we set GenderID = 3.

tblGender.ID = 3 exists, so this is valid.

===============================================================================
*/

UPDATE tblEmployee
SET GenderID = 3
WHERE ID = 1;
GO


/*
===============================================================================
STEP 14: ADD A DEFAULT CONSTRAINT
===============================================================================

Now we create a DEFAULT constraint.

The default value is 0.

This means:

    If an INSERT does not provide GenderID,
    SQL Server will automatically use:

        GenderID = 0

IMPORTANT:
    DEFAULT does NOT override a Foreign Key.

The value generated by DEFAULT must still satisfy the Foreign Key.

===============================================================================
*/

ALTER TABLE tblEmployee
ADD CONSTRAINT DF_tblEmployee_GenderID
DEFAULT 0 FOR GenderID;
GO


/*
===============================================================================
STEP 15: CHECK tblGender
===============================================================================

Let's see which Gender IDs actually exist.

===============================================================================
*/

SELECT *
FROM tblGender;
GO


/*
At this point we have:

    ID
    --
    1
    2
    3

There is NO ID = 0.
*/


/*
===============================================================================
STEP 16: INTENTIONALLY CREATE A FOREIGN KEY ERROR
===============================================================================

We don't specify GenderID.

Because a DEFAULT exists, SQL Server will try:

    GenderID = 0

Then the Foreign Key checks:

    Does tblGender.ID = 0 exist?

The answer is NO.

Therefore this INSERT will FAIL.

EXPECTED ERROR:

    The INSERT statement conflicted with the FOREIGN KEY constraint
    "tblEmployee_GenderID_FK".

===============================================================================
*/

INSERT INTO tblEmployee
    (ID, Name, Salary, City)
VALUES
    (11, 'Emanuel', 100000, 'Hyderabad');
GO


/*
===============================================================================
WHY DID IT FAIL?
===============================================================================

The process is:

    INSERT employee
          |
          v
    GenderID not supplied
          |
          v
    DEFAULT supplies 0
          |
          v
    Foreign Key checks tblGender
          |
          v
    Does tblGender.ID = 0 exist?
          |
          v
          NO
          |
          v
    INSERT FAILS

===============================================================================
*/


/*
===============================================================================
STEP 17: VIEW TABLE STRUCTURE
===============================================================================

sp_help displays information about the table.

It can show:

    - Columns
    - Data types
    - Nullable information
    - Identity information
    - Indexes
    - Constraints

===============================================================================
*/

EXEC sp_help 'tblEmployee';
GO


/*
===============================================================================
STEP 18: VIEW COLUMN DEFAULT INFORMATION
===============================================================================

This query shows the columns and their default values.

===============================================================================
*/

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblEmployee';
GO


/*
===============================================================================
STEP 19: SOLUTION #1
===============================================================================

If we want the default value to be 3, and ID = 3 represents "Other",
we can change the default.

First remove the existing default constraint.

===============================================================================
*/

ALTER TABLE tblEmployee
DROP CONSTRAINT DF_tblEmployee_GenderID;
GO


/*
Create a new default:

    GenderID = 3

===============================================================================
*/

ALTER TABLE tblEmployee
ADD CONSTRAINT DF_tblEmployee_GenderID
DEFAULT 3 FOR GenderID;
GO


/*
Now this INSERT will work because:

    DEFAULT -> 3

and:

    tblGender.ID = 3 exists

===============================================================================
*/

INSERT INTO tblEmployee
    (ID, Name, Salary, City)
VALUES
    (11, 'Emanuel', 100000, 'Hyderabad');
GO


/*
Verify:
*/

SELECT *
FROM tblEmployee
WHERE ID = 11;
GO


/*
===============================================================================
SOLUTION #2
===============================================================================

Another approach is to create a Gender record for ID = 0.

For example:

    0 -> Unknown

Then DEFAULT 0 would be valid.

However, whether you should use 0 or NULL for "Unknown" depends
on your database design.

Example:

    INSERT INTO tblGender (ID, Gender)
    VALUES (0, 'Unknown');

After this, DEFAULT 0 would satisfy the Foreign Key.

===============================================================================
*/


/*
===============================================================================
FINAL CHECK
===============================================================================
*/

SELECT
    E.ID,
    E.Name,
    E.Salary,
    E.City,
    E.GenderID,
    G.Gender
FROM tblEmployee E
LEFT JOIN tblGender G
    ON E.GenderID = G.ID;
GO


/*
===============================================================================
KEY LESSON
===============================================================================

FOREIGN KEY:

    Ensures that a value exists in the parent table.

DEFAULT:

    Provides a value when a value is not supplied.

IMPORTANT:

    DEFAULT does NOT bypass FOREIGN KEY validation.

The DEFAULT value must itself be valid according to the
Foreign Key constraint.

===============================================================================
*/
```
