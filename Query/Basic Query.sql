-- See all the table

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

-- Task 1. Create a New Book Record 
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '124 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E105';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
	issued_emp_id, COUNT(issued_id) as issued_id
	FROM issued_status
	GROUP BY 1
	HAVING COUNT(issued_id) > 1;

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results 
-- each book and total book_issued_counts**

CREATE TABLE book_issued_counts AS
SELECT 
    b.isbn, 
    b.book_title,
    COUNT(ist.issued_id) AS issue_count
FROM issued_status AS ist
JOIN books AS b
  ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title
ORDER BY issue_count DESC;
SELECT * FROM book_issued_counts;

-- Task 7. Retrieve All Books in a Specific Category:

Select * from books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:

select
b.category,
sum(b.rental_price),
count(*)
from issued_status as ist 
Join books as b
ON b.isbn = ist.issued_book_isbn
group by 1;

-- Task 9: List Members Who Registered in the Last 180 Days:

select * from members
where reg_date >= CURRENT_DATE - INTERVAL '180 days'

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:

select 
e1.emp_id,
e1.emp_name,
e1.position,
e1.salary,
b.*,
e2.emp_name as manager
from employees as e1
join branch as b
on e1.branch_id = b.branch_id
join 
employees as e2
on e2.emp_id = b.manager_id ;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:

create table expensive_books as
select * from books
where rental_price > 7.00;

-- Task 12: Retrieve the List of Books Not Yet Returned

select * from issued_status as ist
left join 
return_status as rs
on rs.issued_id = ist.issued_id
where rs.return_id is null;



