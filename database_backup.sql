CREATE DATABASE IF NOT EXISTS anychart_db;
USE anychart_db;
DROP PROCEDURE IF EXISTS init;
DELIMITER //
CREATE PROCEDURE init ()
LANGUAGE SQL
BEGIN
  DECLARE user_exist, data_present INT;
  SET user_exist = (SELECT EXISTS (SELECT DISTINCT user FROM mysql.user WHERE user = "anychart_user"));
  IF user_exist = 0 THEN
    CREATE USER 'anychart_user'@'localhost' IDENTIFIED BY 'anychart_pass';
    GRANT ALL PRIVILEGES ON anychart_db.* TO 'anychart_user'@'localhost';
    FLUSH PRIVILEGES;
  END IF;
  CREATE TABLE IF NOT EXISTS fruits (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64),
    value INT
  );
  SET data_present = (SELECT COUNT(*) FROM fruits);
  IF data_present = 0 THEN
    INSERT INTO fruits (name, value) VALUES
      ('apple',100),
      ('orange',58),
      ('banana',81),
      ('lemon',42),
      ('melon',21),
      ('kiwi',66),
      ('mango',22),
      ('pear',48),
      ('coconut',29),
      ('cherries',65),
      ('grapes',31),
      ('strawberries',76),
      ('plum',98),
      ('peach',62),
      ('mandarin',79),
      ('watermelon',72),
      ('garnet',38);
  END IF;
END;//
DELIMITER ;
CALL init();
