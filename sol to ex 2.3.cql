-- navigate to denormalization folder
cd labwork/denormalization

cqlsh

-- switch to specific keyspace
USE killrvideo;

-- create UTD video_encoding
CREATE TYPE IF NOT EXISTS video_encoding (
 encoding TEXT,
 height INT,
 width INT,
 bit_rates SET<TEXT>
);

-- Creating a new videos_by_actor table to retrieve videos an actor has appeared in (newest first)
CREATE TABLE videos_by_actor (
 actor text,
 added_date timestamp,
 video_id timeuuid,
 character_name text,
 description text,
 encoding frozen<video_encoding>,
 tags set<text>,
 title text,
 user_id uuid,
 PRIMARY KEY ((actor), added_date, video_id )
) WITH CLUSTERING ORDER BY (added_date DESC, video_id ASC);

-- import data into videos_by_actor
COPY videos_by_actor
(actor,added_date,video_id,character_name,description,encoding,tags,title,user_id) 
FROM 'videos_by_actor.csv' WITH HEADER = true;

-- all films played by Tom Hanks
select * from videos_by_actor
where actor = 'Tom Hanks';

-- Try SELECTing just the actor and the added_date columns. Notice the order of 
-- column video_id is also in descending order.
select * from videos_by_actor
where actor = 'Tom Hanks'and added_date > 2000;

--  create a new table called 'videos_by_genre' to retrieve videos within a particular genre (newest first)
CREATE TABLE videos_by_genre (
 genre text,
 added_date timestamp,
 video_id timeuuid,
 description text,
 encoding frozen<video_encoding>,
 tags set<text>,
 title text,
 user_id uuid,
 PRIMARY KEY ((genre), added_date, video_id )
) WITH CLUSTERING ORDER BY (added_date DESC, video_id DESC );

-- import data into this table
COPY videos_by_genre
(genre,added_date,video_id,description,encoding,tags,title, user_id) 
FROM 'videos_by_genre.csv' WITH HEADER = true;

-- Run a query to retrieve the video information for a particular genre
SELECT * FROM videos_by_genre WHERE genre = 'Musical' LIMIT 10;

-- exit cqlsh
exit
