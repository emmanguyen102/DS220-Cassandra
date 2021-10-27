-- navigate to udts folder
cd labwork/counters

cqlsh

-- switch to specific keyspace
USE killrvideo;

-- Create a new table called 'videos_count_by_tag' with a column 'video_count' 
-- which makes use of a counter type to store the video count.
CREATE TABLE videos_count_by_tag (
	tag TEXT,
	added_year TIMESTAMP,
	video_count counter,
	PRIMARY KEY (tag, added_year)
);

-- Load the number of counts from the 'videos_count_by_tag.cql' file into the
-- 'videos_count_by_tag' table using the SOURCE command.
SOURCE 'videos_count_by_tag.cql'

-- Run a query to display each category of tag and added year, 
-- along with the count of videos for each.
SELECT * FROM videos_count_by_tag;

-- Simulate adding another a tag for another video by incrementing the video count for a
-- category, and then querying the new count from the 'videos_count_by_tag' table.
UPDATE videos_count_by_tag SET video_count = video_count + 100
WHERE tag = 'nosql' AND added_year = 2015;


SELECT * FROM videos_count_by_tag WHERE tag = 'nosql' AND
added_year = 2015;


-- exit cqlsh
exit
