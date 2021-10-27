-- switch to this keyspace 'killrvideo'
USE killrvideo

-- create a poorly structured new table 
CREATE TABLE bad_videos_by_tag_year (
 tag text,
 added_year int,
 added_date timestamp,
 title text,
 description text,
 user_id uuid,
 video_id timeuuid,
 PRIMARY KEY ((video_id))
);

-- have a look at the table structure in Cassandra
DESCRIBE TABLE bad_videos_by_tag_year; 

--all the columns have been reordered so that primary key appears first, then come a-z order of the rest of columns
--CREATE TABLE killrvideo.bad_videos_by_tag_year (
--    video_id timeuuid PRIMARY KEY,
--    added_date timestamp,
--    added_year int,
--    description text,
--    tag text,
--    title text,
--    user_id uuid
--) WITH bloom_filter_fp_chance = 0.01
--    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
--    AND comment = ''
--    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
--    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
--    AND crc_check_chance = 1.0
--    AND dclocal_read_repair_chance = 0.1
--    AND default_time_to_live = 0
--    AND gc_grace_seconds = 864000
--    AND max_index_interval = 2048
--    AND memtable_flush_period_in_ms = 0
--    AND min_index_interval = 128
--    AND read_repair_chance = 0.0
--    AND speculative_retry = '99PERCENTILE';


-- import data into this new table
COPY bad_videos_by_tag_year (tag, added_year, video_id,
added_date, description, title, user_id) FROM
'labwork/clustering/videos_by_tag_year.csv' WITH HEADER=true; --imported 797 rows

-- query check the numbers of rows in this table 
SELECT COUNT(*)
FROM bad_videos_by_tag_year; 

-- only 422 rows in this table. the number of rows in the 'bad_videos_by_tag_year' does not match the number of
rows imported from 'videos_by_tag_year.csv'. Since 'videos_by_tag_year.csv' duplicates
'video_id' for each unique 'tag' and 'year' per video, Cassandra upserted several records during
the COPY. `video_id` is not a proper partition key for this scenario. Therefore, this table is not valid to be utilized.
DROP TABLE bad_videos_by_tag_year;

-- create a new optimized table
CREATE TABLE videos_by_tag_year (
 tag text,
 added_year int,
 video_id timeuuid,
 added_date timestamp,
 description text,
 title text,
 user_id uuid,
 PRIMARY KEY ((tag), added_year, video_id)
)
WITH CLUSTERING ORDER BY (added_year DESC, video_id ASC);

-- import data again to this new table
COPY videos_by_tag_year (tag, added_year, video_id, added_date, description, title, user_id) FROM 'labwork/clustering/videos_by_tag_year.csv' 
WITH HEADER=true;

-- check the number of rows in this table
SELECT COUNT(*)
FROM videos_by_tag_year; -- 797 rows. Now it's correct.

-- Try querying for all videos with tag "cql" added before the year 2015
SELECT * FROM videos_by_tag_year
WHERE tag = 'cql' AND added_year < 2015;

--  cql |       2014 | b68132a3-7a41-10b3-9d9e-f60d2acf59bd | 2014-11-05 03:45:47.000000+0000 | 
--Speaker: J.B. Langston Company: DataStax I'll give a general lay of the land for troubleshooting Cassandra. 
-- I'll show you what to look for in the logs, what ... | The Last Pickle: Lesser Known Features of Cassandra 
--2.0 and 2.1 | fd3f7889-fc0c-43db-951c-7b77710898bc

-- Try querying for all videos added before 2015. The query will fail.
SELECT * FROM videos_by_tag_year
WHERE added_year < 2015;

-- InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot execute this query as it might 
--involve data filtering and thus may have unpredictable performance. If you want to execute this query despite 
--the performance unpredictability, use ALLOW FILTERING"

			
-- exit cql
exit 
