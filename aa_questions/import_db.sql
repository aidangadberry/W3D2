PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  user_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_id INTEGER,
  user_id INTEGER,
  body TEXT,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Peter', 'Pan'),
  ('Captain', 'Hook'),
  ('Arthur', 'Miller'),
  ('Tom', 'Hanks');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('How do I SQL?!?!', 'Please help me :(', 4),
  ('Where''s Tinkerbell?', 'I haven''t seen her in 4 weeks...', 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 4),
  (2, 1),
  (1, 3),
  (2, 2);

INSERT INTO
  replies (question_id, user_id, parent_id, body)
VALUES
  (1, 1, NULL, 'SQL is hella ez bro. Y do u not know 😎'),
  (2, 2, NULL, '😈'),
  (1, 4, 1, 'C''mon man, I''ve been stuck on an island for 5 years..'),
  (2, 1, 2, '😳 💩');

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (2, 2),
  (1, 3);
