-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`name`,`students`.`surname` AS 'Surname' ,`degrees`.`name` AS 'Corso_di_laurea'
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` LIKE '%Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT `degrees`.`name` AS 'Nome_corso', `departments`.`name` AS 'Dipartimento'
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT `degrees`.`name` AS 'Nome_corso', `teachers`.`name` AS 'Nome_Ins', `teachers`.`surname` AS 'Cognome_Ins', `teachers`.`id`
FROM `degrees`
JOIN `course_teacher`
ON `degrees`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`name` = 'Fulvio' AND `teachers`.`surname` = 'Amato';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea 
-- a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`name`  AS 'Nome', `students`.`surname` AS 'Cognome', `degrees`.*, `departments`.`name`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON`departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`name`ASC, `students`.`surname` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`name` AS 'Nome_corso', `courses`.`name` AS 'Nome_corso', `teachers`.`name` AS 'Nome_insegnante', `teachers`.`surname` AS 'Cognome_Insegnante'
FROM `degrees`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
ORDER BY `degrees`.`name`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica

SELECT DISTINCT `teachers`.`name` AS 'Nome_Ins', `teachers`.`surname` AS 'Cognome_ins', `departments`.`name` AS 'Nome_dipartimento'
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per 
-- superare ciascuno dei suoi esami

SELECT COUNT(*) AS 'Numero_tentativi', `students`.`name` AS 'Nome', `students`.`surname` AS 'Cognome'
FROM `students`
JOIN `exam_student`
ON `students`.`degree_id` = `exam_student`.`student_id`
GROUP BY `students`.`id`;