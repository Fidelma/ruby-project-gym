DROP TABLE scheduling;
DROP TABLE members;
DROP TABLE classes;

CREATE TABLE classes (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255),
  time VARCHAR(255),
  duration VARCHAR(255)
);

CREATE TABLE members (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE scheduling (
  id SERIAL4 PRIMARY KEY,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE,
  class_id INT4 REFERENCES classes(id) ON DELETE CASCADE
);
