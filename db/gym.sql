DROP TABLE schedule;
DROP TABLE members;
DROP TABLE sessions;

CREATE TABLE sessions (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255),
  start_time VARCHAR(255),
  duration VARCHAR(255)
);

CREATE TABLE members (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE schedule (
  id SERIAL4 PRIMARY KEY,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE,
  session_id INT4 REFERENCES sessions(id) ON DELETE CASCADE
);
