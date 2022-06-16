-- Given by question:
CREATE TABLE docs02 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert02 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs02(id) ON DELETE CASCADE
);

-- DELETE FROM invert02;

INSERT INTO docs02 (doc) VALUES
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

CREATE TABLE stop_words (word TEXT unique);

INSERT INTO stop_words (word) VALUES
('i'), ('a'), ('about'), ('an'), ('are'), ('as'), ('at'), ('be'),
('by'), ('com'), ('for'), ('from'), ('how'), ('in'), ('is'), ('it'), ('of'),
('on'), ('or'), ('that'), ('the'), ('this'), ('to'), ('was'), ('what'),
('when'), ('where'), ('who'), ('will'), ('with');

-- My part to make invert index:

INSERT INTO invert02 (doc_id, keyword)
SELECT *
FROM (
  SELECT distinct id,unnest(string_to_array(lower(doc), ' ')) as jj
  FROM docs02
) tmp
WHERE tmp.jj NOT IN (SELECT word FROM stop_words);


-- Checking part from auto grader:
SELECT keyword, doc_id FROM invert02 ORDER BY keyword, doc_id LIMIT 10;
