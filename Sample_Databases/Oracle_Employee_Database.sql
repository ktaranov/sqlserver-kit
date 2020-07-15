/*
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Sample_Databases/Oracle_Employee_Database.sql
Changed data type to more unviversal: varchar2 -> varchar, number -> int
Tested on SQL Server 2019 and Postgres 12.2
Original link: https://livesql.oracle.com/apex/livesql/file/content_O5AEB2HE08PYEPTGCFLZU9YCV.html
Code style for PostgresSQL - python like.
*/

CREATE DATABASE oracle_employee;

DROP TABLE employee;
DROP TABLE department;

CREATE TABLE department (
   id int NOT NULL
   , name varchar(100) NOT NULL
   , CONSTRAINT pk_department PRIMARY KEY (id)
);

CREATE TABLE employee (
    id int NOT NULL
    , department_id INT NOT NULL
    , chief_id int NULL
    , name varchar(100) NOT NULL
    , salary DECIMAL(19,2) NOT NULL
    , CONSTRAINT pk_employee PRIMARY KEY (id)
);

ALTER TABLE employee ADD CONSTRAINT fk_employee__department_id FOREIGN KEY (department_id) REFERENCES department(id);
ALTER TABLE employee ADD CONSTRAINT fk_employee__cheief_id FOREIGN KEY (chief_id) REFERENCES employee(id);

INSERT INTO department (id, name) VALUES(10, 'ACCOUNTING');
INSERT INTO department (id, name) VALUES(20, 'RESEARCH');
INSERT INTO department (id, name) VALUES(30, 'SALES');
INSERT INTO department (id, name) VALUES(40, 'OPERATIONS');

INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7839, 'KING', null, 5000, 10);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7698, 'BLAKE', 7839, 2850, 30);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7782, 'CLARK', 7839, 2450, 10);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7566, 'JONES',7839, 2975, 20);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7788, 'SCOTT', 7566, 3000, 20);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7902, 'FORD', 7566, 3000, 20);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7369, 'SMITH', 7902, 800, 20);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7499, 'ALLEN', 7698, 1600, 30);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7521, 'WARD', 7698, 1250, 30);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7654, 'MARTIN', 7698, 1250, 30);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7844, 'TURNER', 7698, 1500, 30);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7876, 'ADAMS', 7788, 1100, 20);
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7900, 'JAMES', 7698, 950, 30  );
INSERT INTO employee(id, name, chief_id, salary, department_id)
VALUES(7934, 'MILLER', 7782, 1300, 10);
