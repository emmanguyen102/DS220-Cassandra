cd labwork/final

cqlsh

SOURCE 'killrvideo.cql';

DESCRIBE KEYSPACE killr_video;

-- Set the default keyspace to killr_video with the USE command.
USE killr_video;

COPY videos FROM 'videos.csv' WITH HEADER=true;
COPY latest_videos FROM 'latest_videos.csv' WITH HEADER=true;
COPY trailers_by_video FROM 'trailers_by_video.csv' WITH HEADER=true;
COPY actors_by_video FROM 'actors_by_video.csv' WITH HEADER=true;
