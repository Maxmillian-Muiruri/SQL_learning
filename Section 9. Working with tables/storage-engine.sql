-- MySQL Storage Engines

/* a storage engine is a software component responsible 
for managing how data is stored, retrieved, and manipulated within tables.*/

/* To find the available storage engines on your
 MySQL server, you can use the following query:*/
SELECT 
  engine, 
  support 
FROM 
  information_schema.engines 
ORDER BY 
  engine;
--   use the SHOW ENGINES statement to list all available storage engines: 
  SHOW ENGINES;
--   Default engine: InnoDB, used from MySQL 5.5 onward (before that it was MyISAM).

-- The Engines

# InnoDB
-- Supports full ACID transactions, so your data stays safe and consistent.
-- Supports foreign keys, commit, rollback, and roll-forward.
-- Tables can be up to 64TB.
-- Portable across platforms and operating systems.
-- MySQL checks and repairs InnoDB tables at startup if needed.
-- Best choice for most applications
  
  #  MyISAM

-- An older engine focused on speed and compression.
-- Tables can be up to 256TB.
-- Can be compressed into read-only tables to save space.
-- Portable across platforms, and checked and repaired at startup.
-- Drawback: it is not transaction-safe.
-- Was the default engine before MySQL 5.5.

#  MERGE (MRG_MyISAM)

-- A virtual table that combines several MyISAM tables with identical structure into one.
-- Has no indexes of its own and uses the indexes of the underlying tables.
-- DROP TABLE removes only the MERGE table, not the underlying tables.
-- Allows SELECT, INSERT, UPDATE, and DELETE.

# MEMORY (formerly HEAP)

-- Stores all data in RAM and uses hash indexes, so it is faster than MyISAM.
-- Data lasts only while the server is running and is lost on restart.
-- Useful for temporary or fast-lookup data.

#  ARCHIVE

-- Stores huge numbers of records in compressed form to save disk space.
-- Compresses data on insert and decompresses it on read.
-- Only allows INSERT and SELECT.
-- Has no indexes, so reads need a full table scan.

#  CSV

-- Stores data as comma-separated values files.
-- Convenient for moving data to spreadsheets or other non-SQL tools.
-- Does not support NULL values.
-- Reads need a full table scan.

# BLACKHOLE

-- Throws away any data written to it and stores nothing.
-- Useful in replication to capture changes on the master without storing the data locally.
  
 #   FEDERATED

-- Lets you work with a table on a remote MySQL server without clustering or replication.
-- The local table holds no data and pulls it from the remote table when queried.
-- Disabled by default (shows NO in the support column).