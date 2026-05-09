
--Steve Phillips-Ward

/* 1. [30 points] Give an SQL schema definition for the following employee database:

employee (employee name, street, city)
works (employee name, company_name, salary)
company (company name, city)
manages(employee name, manager_name)

Choose an appropriate domain for each attribute and an appropriate primary key for each relation schema. Include foreign key constraints where needed. The table manages contains two foreign keys where both employee_name and manager_name are foreign keys referencing the relation employee. Be careful about the order you create the tables */
Drop table if exists manages;
Drop table if exists works;
Drop table if exists employee;
Drop table if exists company;

CREATE TABLE employee (
    employee_name varchar(255) primary key,
    street varchar(255),
    city varchar(255)
);

CREATE TABLE company (
    company_name varchar(255) primary key,
    city varchar(255)
);

CREATE TABLE works (
    employee_name varchar(255), 
    company_name varchar(255),
    salary int,
    primary key (employee_name, company_name),
    foreign key (employee_name) references employee(employee_name),
    foreign key (company_name) references company(company_name)
);

CREATE TABLE manages (
    employee_name varchar(255),
    manager_name varchar(255),
    primary key (employee_name, manager_name),
    foreign key (employee_name) references employee(employee_name),
    foreign key (manager_name) references employee(employee_name)
);

 /* 2. [20 points] Populate the tables you created for the previous question with data (i.e, write SQL insert statements to insert data in the tables). You need to insert at least three rows in each table. Be careful about the order you populate the tables with data.*/

insert into employee values ('Alice', '123 Main St', 'New York'), ('Bob', '456 Elm St', 'Los Angeles'), ('Charlie', '789 Oak St', 'Chicago'), ('David', '111 Pine St','Springfield'), ('Eve', '111 Pine St','Springfield');

insert into company values ('First Bank Corporation', 'New York'), ('Second Bank Corporation', 'Los Angeles'), ('Third Bank Corporation', 'Chicago');

insert into works values ('Alice', 'First Bank Corporation', 70000), ('Bob', 'Second Bank Corporation', 60000), ('Charlie', 'Third Bank Corporation', 80000), ('David', 'First Bank Corporation', 65000), ('Eve', 'Second Bank Corporation', 65000);

insert into manages values ('Alice', 'Bob'), ('Bob', 'Charlie'), ('Charlie', 'Alice'), ('Eve', 'David');

 /* 3. [50 points; each part is worth 10 points] For this question, you are not allowed to use any SQL command that was not covered in module 5. Answers that use SQL commands covered in modules after module 5 will be considered wrong. Write SQL queries to answer the following questions:*/
 -- 3-1 Find the names of all employees who work for “First Bank Corporation”.
    select employee_name from works where company_name = 'First Bank Corporation';
 -- 3-2 Find the company_name and city for every company. Order the output in alphabetical order by company_name.
    select company_name, city from company order by company_name;
 -- 3-3 Find the names of the employees who make a salary of at least $65,000. Notice: in the query the value should be specified as 65000.
    select employee_name from works where salary >= 65000;
 -- 3-4 Find all employees in the database who live in the same cities as the companies for which they work.
    select e.employee_name from employee as e, works as w, company as c where e.employee_name = w.employee_name and w.company_name = c.company_name and e.city = c.city;
 -- 3-5 Find all employees in the database who live in the same cities and on the same streets as do their managers.
    select e.employee_name from employee as e, manages as m, employee as mng where e.employee_name = m.employee_name and m.manager_name = mng.employee_name and e.city = mng.city and e.street = mng.street;