USE student_db;


INSERT INTO students (last_name, first_name, paternal_name, phone, telegram, email, git) VALUES
    ('Иванов', 'Иван', 'Иванович', '79180000000', NULL, 'test@mail.ru', NULL);
    
INSERT INTO students (last_name, first_name, paternal_name, phone, telegram, git, email) 
VALUES ('Петров', 'Петр', 'Петрович', '79181111111', '@petrov', 'https://github.com/petrov', 'petrov@mail.ru');

INSERT INTO students (last_name, first_name, phone, email) 
VALUES ('Иванова', 'Мария', '79232222222', 'mariya@mail.ru');

