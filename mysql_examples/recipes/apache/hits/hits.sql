# hits.sql

#@ _UPDATE_COUNT_
INSERT INTO hitcount (path,hits) VALUES('some path',LAST_INSERT_ID(1))
ON DUPLICATE KEY UPDATE hits = LAST_INSERT_ID(hits+1);
#@ _UPDATE_COUNT_
#@ _RETRIEVE_COUNT_
SELECT LAST_INSERT_ID();
#@ _RETRIEVE_COUNT_
