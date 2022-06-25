-- Exercise 2
CREATE TABLE mentors (
  id           SERIAL PRIMARY KEY,
  name         VARCHAR(30) NOT NULL,
  yearsInBCN   INT,
  address      VARCHAR(120),
  favLang      VARCHAR(120)
);
-- Exercise 3
INSERT INTO mentors (name,              yearsInBCN,   address,                   favLang)
             VALUES ('John Smith',      7,            'New Road 11, Barcelona',  'phyton'),
                    ('Juan Lopez',      3,            'Enamorados 2, Barcelona', 'phyton'),
                    ('Ivan Solari',     5,            'Xifré 23, Barcelona',     'Java'),
                    ('Bruce Dickinson', 6,            'Heaven 666, NoWhere',     'JavaScript'),
                    ('Alvaro Solana',   2,            'Old Avenue 33, Badalona', 'C#'  );

-- Exercise 4
CREATE TABLE students (
  id           SERIAL PRIMARY KEY,
  name         VARCHAR(30) NOT NULL,
  address      VARCHAR(120),
  graduated    BOOLEAN
);
-- Exercise 5
INSERT INTO students (name,                address,                                graduated)
              VALUES ('Mckayla Mooney',    '20 Launceston Place, London',          'yes'),
                     ('Roderick Perez',    '21 Utting Avenue, Liverpool',          'yes'),
                     ('Heaven Bernard',    '11 Thornydyke, Thurstonfield',         'no'),
                     ('Jason Kennedy',     '33 Yans Lane, Milnthorpe',             'yes'),
                     ('Kendall Woodard',   '37 Hornchurch Road, Bowerhill',        'yes'),
                     ('Keyla Tyler',       'Platform 17 Grovehill Road, Beverley', 'no'),
                     ('Nevaeh Case',       '64A Inverness Road, Portsmouth',       'yes'),
                     ('Demarion Blair',    '17 Oaklands Avenue, West Wickham',     'no'),
                     ('Layla Christensen', '44 Town Lane, Bebington',              'yes'),
                     ('Kate Phillips',     'Flat 55, 9A York Way, London',         'yes');

-- Exercise 6
SELECT * from mentors;
SELECT * from students;

-- Exercise 7
CREATE TABLE classes (
  id            SERIAL PRIMARY KEY,
  mentor        VARCHAR(30) NOT NULL,
  topic         VARCHAR(120),
  date          TIMESTAMP,
  location      VARCHAR(120)
);
-- Exercise 8
INSERT INTO classes (mentor,             topic,        date,                  location)
             VALUES ('John Smith',      'COBOL',      '2022-01-01 13:00:00', 'New Road 11, Barcelona'),
                    ('Juan Lopez',      'phyton',     '2022-05-02 13:10:00', 'Enamorados 2, Barcelona'),
                    ('Ivan Solari',     'Java',       '2022-08-03 13:20:00', 'Xifré 23, Barcelona'),
                    ('Bruce Dickinson', 'JavaScript', '2022-05-04 13:30:00', 'Heaven 666, NoWhere'),
                    ('Alvaro Solana',   'C#',         '2022-09-05 13:40:00', 'Old Avenue 33, Badalona');
SELECT * from classes;

-- Exercise 9
CREATE TABLE assistance (
    id          SERIAL PRIMARY KEY,
    student_id     INT REFERENCES students(id),
    class_id       INT REFERENCES classes(id)
)
INSERT INTO assistance (student_id,class_id)
                VALUES (1,      1),
                       (2,      2),
                       (3,      3),
                       (4,      4),
                       (5,      5),
                       (6,      1),
                       (7,      2),
                       (8,      3),
                       (9,      4),
                       (10,     5);

SELECT * from assistance;

-- Exercise 10
--10.1
SELECT name,yearsInBCN FROM mentors WHERE yearsInBCN > 5;
--10.2
SELECT name,favLang FROM mentors WHERE favLang = 'JavaScript';
--10.3
SELECT name FROM students WHERE graduated = true;
--10.4
SELECT * FROM classes WHERE date < '2022-06-01';
--10.5
SELECT name, topic FROM assistance
INNER JOIN students ON students.id=assistance.student_id
INNER JOIN classes ON classes.id=assistance.class_id
WHERE topic = 'JavaScript';