-- navigate to udts folder
cd labwork/udts

cqlsh

-- switch to specific keyspace
USE killrvideo;

-- truncate all date from table videos
truncate table videos;

-- Alter the 'videos' table to add a 'tags' column.
alter table videos add tags set<text>;

-- Load the data from the 'videos.csv' file using the COPY command.
COPY videos FROM 'videos.csv' WITH HEADER=true;

-- Alter your table to add an 'encoding' column of the 'video_encoding' type.
alter table videos add encoding video_encoding;

-- Load the data from the 'videos_encoding.csv' file using the COPY command.
COPY videos (video_id, encoding) FROM 'videos_encoding.csv' WITH
HEADER=true;

-- Run a query to retrieve the first 10 rows of the 'videos' table.
select * from videos
limit 10;

-- exit cqlsh
exit
