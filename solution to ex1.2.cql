-- Create keyspace using Simple Strategy replication method and 1 replication factor
CREATE KEYSPACE killrvideo 
	WITH replication = {
		'class': 'SimpleStrategy', 
		'replication_factor': 1
	};

-- switch to use this keyspace
USE killrvideo;

# create tables named 'videos' in this keyspace
CREATE TABLE videos (
	video_id TIMEUUID,
	added_date TIMESTAMP,
	description TEXT,
	title TEXT,
	user_id UUID,
	PRIMARY KEY (video_id)
);

-- import data into table
COPY videos (video_id, added_date, description, title, user_id) 
FROM 'labwork/cql/videos.csv' WITH HEADER = true;

-- check 10 rows of table videos
SELECT * FROM videos
LIMIT 10;

-- check total imported rows
SELECT COUNT(*) FROM videos; -- 430 rows

-- check the row that has video_id = 6c4cffb9-0dc4-1d59-af24-c960b5fc3652
SELECT * FROM videos
WHERE video_id = 6c4cffb9-0dc4-1d59-af24-c960b5fc3652; 

--6c4cffb9-0dc4-1d59-af24-c960b5fc3652 | 2014-11-06 01:11:50.000000+0000 | Speaker: Luke 
--Tillman, Language Evangelist at DataStaxnnKeyboard Cat, Nyan Cat, and of course the world 
--famous Grumpy Cat--it seems like the Internet can’t get enough cat videos. If you were 
--building an application to let users share and consume their fill of videos, how would 
--you go about it? In this talk, we’ll take a look at the data model for KillrVideo, a sample 
--video sharing application similar to YouTube where users can share videos, comment, rate 
--them, and more. You’ll learn get a practical introduction to Cassandra data modeling, 
--querying with CQL, how the application drives the data model, and how to shift your thinking 
--from the relational world you probably have experience with. | Cassandra Day Denver 2014: 
--A Cassandra Data Model for Serving up Cat Videos | fd3f7889-fc0c-43db-951c-7b77710898bc




