# DS220-Cassandra
Data Modelling with Cassandra

Exercises for DataStax, DS220: Data Modeling Course


Open the terminal, force DSE to start

```
$ sudo service dse start 
```

And start Cassadra Query Language Shell(CQLSH) with command:

```
$ cqlsh
```

then execute cql statement in order to see all available keyspaces:

```
$ select * from system.schema_keyspaces;
```
the answer should be:

```
 keyspace_name | durable_writes | strategy_class                                  | strategy_options
---------------+----------------+-------------------------------------------------+----------------------------
    dse_system |           True | org.apache.cassandra.locator.EverywhereStrategy |                         {}
     OpsCenter |           True |     org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"1"}
        system |           True |      org.apache.cassandra.locator.LocalStrategy |                         {}
 system_traces |           True |     org.apache.cassandra.locator.SimpleStrategy | {"replication_factor":"2"}
```

