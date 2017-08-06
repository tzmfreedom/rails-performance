## Rails Performance

This rails application tell you the way to improve performance on your rails application.

### Usage

```
$ git clone git@github.com:tzmfreedom/rails-performance.git
$ cd rails-performance
$ bundle install --path vendor/bundle
$ bin/rake db:setup
$ vim .env # You need to set MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_HOSTNAME variables.
```

Run benchmark task
```
$ bin/rake benchmark:hogehoge
```

### ActiveRecord

Which you use preload or eager_load to avoid N+1 Query problem?

The following command help you to know which to use them.
```
$ bin/rake benchmark:active_record
```

The result is as follows.
```
eager_load: one join/all
                          1.345  (± 0.0%) i/s -     47.000  in  35.499157s
eager_load: one join/conditional
                         10.872  (± 9.2%) i/s -    378.000  in  35.046556s
eager_load: full join/all
                          0.218  (± 0.0%) i/s -      8.000  in  36.837148s
eager_load: full join/conditional
                          0.400  (± 0.0%) i/s -     14.000  in  35.185927s
preload: one join/all
                          1.660  (± 0.0%) i/s -     58.000  in  35.373139s
preload: one join/conditional
                         26.632  (±11.3%) i/s -    896.000  in  35.004991s
preload: full join/all
                          0.294  (± 0.0%) i/s -     11.000  in  37.782031s
preload: full join/conditional
                          0.759  (± 0.0%) i/s -     27.000  in  35.798513s
select_all: full_join/all
                          1.130  (± 0.0%) i/s -     40.000  in  35.597281s
find_by_sql: full_join/all
                          0.917  (± 0.0%) i/s -     32.000  in  35.223277s
cache: full_join/all    124.408k (±15.0%) i/s -      4.042M in  35.001589s
```

* The more you use `JOIN`, the worse active record performance is.
* In this case, `preload` method is faster than the `eager_load` method.
* You can also see `conditional` query, that is filtered by `where` clause, is faster than the not `conditional` query.
* The `selet_all` and `find_by_sql` methods may help you to improve performance, but these method is difficult for you to use than simple active record usage.
* As you know, the fastest way of fetch records from database is caching.


## Profiling

```
$ ENABLE_STACKPROF=1 bin/rails s -b 0.0.0.0
```

```
$ stackprof-webnav -f tmp/stackprof/stackprof-xxxx.dump
```
