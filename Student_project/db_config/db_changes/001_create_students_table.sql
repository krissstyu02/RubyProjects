USE student_db;


CREATE TABLE students (
    id INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(32) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    paternal_name VARCHAR(32) NOT NULL,
    phone VARCHAR(32) NULL,
    telegram VARCHAR(32) NULL,
    email VARCHAR(32)  NULL,
    git VARCHAR(32) NULL,
    PRIMARY KEY (id)
);
