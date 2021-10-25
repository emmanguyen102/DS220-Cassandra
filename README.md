# DS220-Cassandra
Refer to [Data Modelling with Cassandra](https://academy.datastax.com/#/online-courses/ca2e1209-510b-44a6-97de-d5219d835319)

DataStax, DS220: Data Modeling Course


In order to do exercises, install [Oracle VM VirtualBox Manager](https://www.virtualbox.org/wiki/Downloads) and DS220 virtual machine, which can be found on the course moodle. 
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

To exit Cassadra Query Language Shell(CQLSH) with command

```
$ exit
```


