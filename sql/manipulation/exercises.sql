-- Lista de notas que un estudiante obtuvo en una gestión específica.
-- Student with id 28 and its grades in I/2001.
SELECT Selected_Student.ID               AS student_ID,
       Student_Course_Season.final_grade AS course_grade,
       Course.name                       AS course
FROM (SELECT ID, first_name, last_name FROM Student WHERE ID = 28) AS Selected_Student
         JOIN Student_Course_Season ON Selected_Student.ID = Student_Course_Season.student_ID
         JOIN (SELECT course_season_ID, course_ID, semester, year
               FROM Course_Season
               WHERE year = 2001
                 AND semester = 1) AS Selected_Course_Season
              ON Student_Course_Season.course_season_ID = Selected_Course_Season.course_season_ID
         JOIN Course ON Selected_Course_Season.course_ID = Course.ID
ORDER BY Selected_Student.ID, Course.ID;

-- Lista de estudiantes que tomaron una materia en una gestión específica.
-- Students that took Psychology 101 in I/2001
SELECT Student.ID AS student_ID,
       first_name,
       last_name
FROM Student
         JOIN Student_Course_Season ON Student.ID = Student_Course_Season.student_ID
         JOIN (SELECT course_season_ID, course_ID, year, semester
               FROM Course_Season
               WHERE year = 2001
                 AND semester = 1) AS Selected_Course_Season
              ON Student_Course_Season.course_season_ID = Selected_Course_Season.course_season_ID
         JOIN (SELECT ID, name AS course_name FROM Course WHERE name = 'Psychology 101') AS Selected_Course
              ON Selected_Course_Season.course_ID = Selected_Course.ID
ORDER BY Student.ID;

-- Lista de materias que dicto un profesor.
-- Courses given by the teacher with ID 56.
SELECT DISTINCT Course.ID AS course_ID, Course.name AS course_name
FROM (SELECT ID, first_name, last_name FROM Teacher WHERE ID = 56) AS Selected_Teacher
         JOIN Teacher_Course_Season ON Selected_Teacher.ID = Teacher_Course_Season.teacher_ID
         JOIN Course_Season ON Teacher_Course_Season.course_season_ID = Course_Season.course_season_ID
         JOIN Course ON Course_Season.course_ID = Course.ID
ORDER BY Course.name;

-- Lisa de materias que pertenecen a una carrera.
-- Courses that belong to Art History career.
SELECT Course.ID   AS course_ID,
       Course.name AS course_name
FROM (SELECT ID, name FROM Career WHERE name = 'Art History') AS Selected_Career
         JOIN Career_Course ON Selected_Career.ID = Career_Course.career_ID
         JOIN Course ON Career_Course.course_ID = Course.ID
ORDER BY Course.ID;

-- Promedio general de los estudiantes de un curso.
SELECT Course.ID, Course.name AS course_name, FORMAT(AVG(final_grade), 4) AS average_grade
FROM Course
         JOIN Course_Season ON Course.ID = Course_Season.course_ID
         JOIN Student_Course_Season ON Course_Season.course_season_ID = Student_Course_Season.course_season_ID
GROUP BY Course.ID
ORDER BY Course.ID;

-- Promedio general de un estudiante en una gestión específica.
-- Average grade of the student named Atlanta in II/2013.
SELECT AVG(final_grade) AS average_grade
FROM (SELECT ID, first_name, last_name FROM Student WHERE first_name = 'Atlanta') AS Selected_Student
         JOIN Student_Course_Season ON Selected_Student.ID = Student_Course_Season.student_ID
         JOIN (SELECT course_season_ID
               FROM Course_Season
               WHERE year = 2013
                 AND semester = 2) AS Selected_Course_Season
              ON Student_Course_Season.course_season_ID = Selected_Course_Season.course_season_ID
GROUP BY ID;

-- Salario promedio de los profesores por departamento.
-- Average wage by department.
SELECT department_ID                AS department_ID,
       Department.name              AS department_name,
       FORMAT(AVG(Teacher.wage), 4) AS average_wage
FROM Department
         JOIN Teacher_Department ON Teacher_Department.department_ID = Department.ID
         JOIN Teacher ON Teacher_Department.teacher_ID = Teacher.ID
GROUP BY Department.ID;

-- Obtener los carnet de identidad de todos los alumnos que reprobaron una materia
SELECT Student.ID, Reprobed_Student.final_grade
FROM (SELECT student_ID, final_grade
      FROM Student_Course_Season
      WHERE final_grade <= 51) AS Reprobed_Student
         JOIN Student ON Student.ID = Reprobed_Student.student_ID
ORDER BY Reprobed_Student.final_grade;