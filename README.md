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
                                          user     system      total        real
eager_load: one join/all              0.940000   0.040000   0.980000 (  1.041810)
eager_load: one join/conditional      0.130000   0.000000   0.130000 (  0.143286)
eager_load: full join/all             5.570000   0.170000   5.740000 (  6.653135)
eager_load: full join/conditional     4.210000   0.110000   4.320000 (  4.816287)
preload: one join/all                 0.710000   0.020000   0.730000 (  0.838022)
preload: one join/conditional         0.040000   0.000000   0.040000 (  0.050240)
preload: full join/all                3.760000   0.090000   3.850000 (  4.351897)
preload: full join/conditional        1.600000   0.040000   1.640000 (  2.059543)
select_all: full_join/all             0.740000   0.030000   0.770000 (  1.007104)
find_by_sql: full_join/all            1.570000   0.060000   1.630000 (  1.873213)
cache: full_join/all                  0.000000   0.000000   0.000000 (  0.000123)
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
