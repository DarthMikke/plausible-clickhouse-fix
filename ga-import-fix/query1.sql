CREATE TABLE plausible_events_db.imported_locations2(
  `site_id` UInt64, 
  `date` Date, 
  `country` LowCardinality(
    FixedString(2)
  ), 
  `region` String, 
  `city` UInt32, 
  `visitors` UInt64, 
  `visits` UInt64, 
  `visit_duration` UInt64, 
  `bounces` UInt32
) ENGINE = MergeTree 
ORDER BY 
  (
    site_id, date, country, region, city
  ) SETTINGS index_granularity = 8192;

