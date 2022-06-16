-- Given by question:
CREATE TABLE docs01 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert01 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs01(id) ON DELETE CASCADE
);



INSERT INTO docs01 (doc) VALUES
('the clown ran after the car and the car ran into the tent'),
('and the tent fell down on the clown and the car'),
('Then imagine that you are doing this task looking at millions of lines'),
('of text Frankly it would be quicker for you to learn Python and write a'),
('Python program to count the words than it would be to manually scan the'),
('The even better news is that I already came up with a simple program to'),
('find the most common word in a text file I wrote it tested it and now'),
('I am giving it to you to use so you can save some time'),
('You dont even need to know Python to use this program You will need to'),
('get through Chapter 10 of this book to fully understand the awesome');


-- My part to make invert index:

INSERT INTO invert01 (doc_id, keyword)
SELECT distinct id,unnest(string_to_array(lower(doc), ' ')) from docs01;


-- Checking part from auto grader:
SELECT keyword, doc_id FROM invert01 ORDER BY keyword, doc_id LIMIT 10;
