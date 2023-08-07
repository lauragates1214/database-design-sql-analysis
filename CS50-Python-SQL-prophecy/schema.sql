CREATE TABLE students (
    id           INTEGER,
    student_name TEXT NOT NULL
                 UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE houses (
    id         INTEGER,
    house_name TEXT NOT NULL
               UNIQUE,
    head       TEXT,
    PRIMARY KEY(id)
);

CREATE TABLE assignments (
    id         INTEGER,
    student_id INTEGER
               UNIQUE,
    house_id   INTEGER,
    FOREIGN KEY(student_id) REFERENCES students(id),
    FOREIGN KEY(house_id) REFERENCES houses(id)
    PRIMARY KEY(id)
);