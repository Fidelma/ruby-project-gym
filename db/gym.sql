DROP TABLE schedule;
DROP TABLE members;
DROP TABLE memberships;
DROP TABLE sessions;

CREATE TABLE sessions (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255),
  start_time VARCHAR(255),
  duration VARCHAR(255),
  capacity INT4 NOT NULL
);

CREATE TABLE memberships (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255),
  price INT4,
  access_hours VARCHAR(255)
);

CREATE TABLE members (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  membership_id INT4 REFERENCES memberships(id) ON DELETE CASCADE
);

CREATE TABLE schedule (
  id SERIAL4 PRIMARY KEY,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE,
  session_id INT4 REFERENCES sessions(id) ON DELETE CASCADE
);
