DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR NOT NULL,
  lname VARCHAR NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE questions_follows ( 
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Katie', 'Han'),
  ('Fifi', 'Shelton');

INSERT INTO 
  questions (title, body, author_id)
VALUES
  ('What is SQL?', 'Help I dont know SQL', (SELECT id FROM users where fname = 'Katie')),
  ('SQL', 'How do I insert data?', (SELECT id FROM users where fname = 'Fifi')),
  ('Database', 'How do I make a database?', (SELECT id FROM users where fname = 'Katie'));

INSERT INTO
  questions_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users where fname = 'Katie'), (SELECT id FROM questions where author_id = 2)),
  ((SELECT id FROM users where fname = 'Fifi'), (SELECT id FROM questions where author_id = 1));

INSERT INTO
  replies(question_id, user_id, body)
VALUES
  (1, (SELECT id FROM users WHERE fname = 'Fifi'), 'SQL is Structured Query Language');

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, 1, 1, 'SQL is cool');

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, 2, 1, 'I love SQL');

INSERT INTO
  question_likes(user_id, question_id)
VALUES (1, 2), (2, 1);