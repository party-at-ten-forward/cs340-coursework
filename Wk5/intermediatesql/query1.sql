-- Write the query to create the 4 tables below.
CREATE TABLE client (
    id int(11) NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    CONSTRAINT full_name UNIQUE (first_name, last_name),
    PRIMARY KEY (id)
);

CREATE TABLE employee (
    id int(11) NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    start_date date NOT NULL,
    email varchar(255) NOT NULL,
    CONSTRAINT full_name UNIQUE (first_name, last_name),
    PRIMARY KEY (id)
);

CREATE TABLE project (
    id int(11) NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    comments text,
    cid int,
    CONSTRAINT proj_title UNIQUE (title),
    PRIMARY KEY (id),
    FOREIGN KEY (cid) REFERENCES client(id)
);

CREATE TABLE works_on (
    pid int,
    eid int,
    due_date date NOT NULL,
    PRIMARY KEY (eid, pid),
    FOREIGN KEY (pid) REFERENCES project(id),
    FOREIGN KEY (eid) REFERENCES employee(id)
);
