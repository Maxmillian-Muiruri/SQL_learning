-- MySQL CREATE TABLE
/* In MySQL, each table has a storage engine such as InnoDB or MyISAM. The ENGINE clause allows
 you to specify the storage engine of the table. */
 
 CREATE DATABASE test;
 USE test;
 
 CREATE TABLE tasks (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE
);

SHOW TABLES;
/* each task has a checklist. To store the checklists of tasks,
 you can create a new table called checklists */
CREATE TABLE checklists(
  id INT, 
  task_id INT, 
  title VARCHAR(255) NOT NULL, 
  is_completed BOOLEAN NOT NULL DEFAULT FALSE, 
  PRIMARY KEY (id, task_id), 
  FOREIGN KEY (task_id) 
      REFERENCES tasks (id) 
      ON UPDATE RESTRICT 
      ON DELETE CASCADE
);


