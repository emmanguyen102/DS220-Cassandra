-- switch to this keyspace 'killrvideo'
USE killrvideo

-- create a new table 
CREATE TABLE videos_by_title_year (
	title TEXT,
	added_year INT,
	added_date TIMESTANP,
	description TEXT,
	user_id UUID,
	video_id UUID,
	PRIMARY KEY ( title, added_year)
);

-- import data into this new table
COPY videos_by_title_year (
	title, added_year, 
	added_date, 
	description, 
	user_id, 
	video_id
	) 
from 'labwork/partitions/videos_by_title_year.csv' ;

-- query check
SELECT * FROM videos_by_title_year
	WHERE title = 'Grumpy Cat: Slow Motion' 
		AND added_year = 2015;
