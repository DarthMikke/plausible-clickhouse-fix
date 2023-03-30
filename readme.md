# Fix imported GA data

Older versions of Plausible Analytics might have imported Google/Universal Analytics data
in wrong format. This caused errors when making exports and creating 
This is an implementation of a fix for issue
[#1980](https://github.com/plausible/analytics/issues/1980) in Plausible repo, provided by
@tssge .

## 1 Docker network

Retrieve Docker network name:

`$ docker network ls`

## 2 Endpoint IP

Retrieve Clickhouse container's IP:

`$ docker network inspect hosting-next_default`

Set it to a variable:

`$ IP=172.20.0.1`

## 3 Start querying

```sh
# Create a table mirroring the import table, but with correct column data types
cat query1.sql | curl --http0.9 "http://$IP:8123?query=" --data-binary @-
# Copy over the data from the old to the new table
cat query2.sql | curl --http0.9 "http://$IP:8123?query=" --data-binary @-
# Change the name of the old data table
cat query3.sql | curl --http0.9 "http://$IP:8123?query=" --data-binary @-
# Change the name of the new data table
cat query4.sql | curl --http0.9 "http://$IP:8123?query=" --data-binary @-
```

Restart the docker containers to be sure that everything is updated.
