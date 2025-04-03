# RailsStats

See stuff about a Rails app.

There were a few things missing to the included `rake stats`

RailsStats mainly adds the ability to be run from outside the project in question. This can be helpful if the app you are interested in can not be booted for some reason.

### Run it outside Rails project

Install the gem globally with:

`gem install rails_stats`

You can then run:

`rails_stats PATH_TO_APP [FORMAT]`

(the format is optional and defaults to the console formatter).

Then you can call it:

```bash
$ rails_stats /path/to/app/

Directory: /path/to/app/

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  1848 |  1483 |      32 |     174 |   5 |     6 |
| Helpers              |  2257 |  1892 |      45 |     245 |   5 |     5 |
| Jobs                 |   399 |   295 |      11 |      33 |   3 |     6 |
| Models               |  4584 |  3509 |      61 |     526 |   8 |     4 |
| Observers            |    42 |    22 |       2 |       5 |   2 |     2 |
| Libraries            |  2987 |  2272 |      30 |     287 |   9 |     5 |
| Configuration        |  1233 |   669 |       4 |      17 |   4 |    37 |
| Spec Support         |  1416 |  1152 |       4 |      30 |   7 |    36 |
| Integration Tests    |    91 |    73 |       0 |       1 |   0 |    71 |
| Lib Tests            |   101 |    83 |       0 |       1 |   0 |    81 |
| Model Tests          |  3397 |  2522 |       0 |      18 |   0 |   138 |
| Cucumber Support     |   739 |   521 |       0 |       1 |   0 |   519 |
| Cucumber Features    |  2711 |  2487 |      29 |     145 |   5 |    15 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 21805 | 16980 |     218 |    1483 |   6 |     9 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 10142     Test LOC: 6838     Code to Test Ratio: 1:0.7
```

### Run it on many Rails engines

```bash
$ for dir in /path/to/many/engines/*/; do rails_stats /users/brian/examples/$dir; done
```

### Within your Rails project

You can also include it within your Rails application to _replace_ the default `rake stats` implementation.

Just add rails_stats to your Gemfile.
Depending on your setup, you might need to `require rails_stats` in your Rakefile.

Then you'll be able to just run:

```bash
$ bundle exec rake stats
```

### Things it knows about

RailsStats adds more coverage than the default.

* Any concepts you've added within an `app` directory
* Configuration files
* Library files
* Gems that you've created and embedded in the project
* Engines and their code
* RSpec/Unit/Cucumber Tests

### Example output

Here are some open source Rails projects and their output.

```bash
$ rails_stats /users/brian/examples//users/brian/examples/diaspora

Directory: /users/brian/examples/diaspora

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Collections          |   259 |   198 |       0 |      56 |   0 |     1 |
| Helpers              |  1863 |  1478 |       0 |     218 |   0 |     4 |
| Models               |  4694 |  3517 |      55 |     580 |  10 |     4 |
| Pages                |   201 |   158 |       0 |      21 |   0 |     5 |
| Controllers          |  2797 |  2168 |      40 |     208 |   5 |     8 |
| Mailers              |   313 |   263 |      13 |      32 |   2 |     6 |
| Presenters           |   516 |   425 |      18 |      71 |   3 |     3 |
| Uploaders            |    84 |    63 |       2 |       9 |   4 |     5 |
| Workers              |   600 |   399 |      32 |      33 |   1 |    10 |
| Javascripts          |  7550 |  4941 |       0 |     741 |   0 |     4 |
| Libraries            |  7031 |  4890 |      69 |     701 |  10 |     4 |
| Configuration        |  2556 |   833 |       5 |      10 |   2 |    81 |
| Controller Tests     |  4628 |  3775 |       0 |       2 |   0 |  1885 |
| Spec Support         |  1141 |   900 |       6 |      56 |   9 |    14 |
| Helper Tests         |   771 |   615 |       0 |       6 |   0 |   100 |
| Integration Tests    |   891 |   647 |       0 |      14 |   0 |    44 |
| Lib Tests            |  4076 |  3259 |       2 |       4 |   2 |   812 |
| Other Tests          |   120 |   101 |       0 |       0 |   0 |     0 |
| Mailer Tests         |   412 |   328 |       0 |       0 |   0 |     0 |
| Model Tests          |  6120 |  4964 |       0 |       1 |   0 |  4962 |
| Presenter Tests      |   353 |   303 |       0 |       0 |   0 |     0 |
| Worker Tests         |   821 |   648 |       0 |       0 |   0 |     0 |
| Cucumber Features    |  2157 |  1863 |      47 |     155 |   3 |    10 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 49954 | 36736 |     289 |    2918 |  10 |    10 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 19333     Test LOC: 17403     Code to Test Ratio: 1:0.9


$ rails_stats /users/brian/examples//users/brian/examples/discourse

Directory: /users/brian/examples/discourse

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  5005 |  3812 |      56 |     416 |   7 |     7 |
| Helpers              |   286 |   218 |       0 |      32 |   0 |     4 |
| Jobs                 |  1830 |  1343 |      53 |     114 |   2 |     9 |
| Mailers              |   438 |   340 |       7 |      24 |   3 |    12 |
| Models               | 12378 |  8393 |     123 |     983 |   7 |     6 |
| Serializers          |  2809 |  2223 |      73 |     374 |   5 |     3 |
| Services             |  1353 |  1060 |      20 |     106 |   5 |     8 |
| Javascripts          | 21722 | 13649 |       0 |    1844 |   0 |     5 |
| Libraries            | 35298 | 27521 |     189 |    2565 |  13 |     8 |
| Configuration        |  1758 |  1179 |       6 |      12 |   2 |    96 |
| Other Tests          | 12998 |  9830 |      20 |      41 |   2 |   237 |
| Controller Tests     |  7673 |  5911 |       0 |       4 |   0 |  1475 |
| Spec Support         |   707 |   560 |       1 |      16 |  16 |    33 |
| Helper Tests         |    88 |    71 |       0 |       0 |   0 |     0 |
| Integration Tests    |   307 |   235 |       0 |       1 |   0 |   233 |
| Job Tests            |  1343 |  1017 |       3 |       9 |   3 |   111 |
| Mailer Tests         |   421 |   302 |       0 |       1 |   0 |   300 |
| Model Tests          | 11236 |  8599 |       2 |      49 |  24 |   173 |
| Serializer Tests     |   297 |   236 |       0 |       2 |   0 |   116 |
| Service Tests        |  1767 |  1406 |       0 |       2 |   0 |   701 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 119714| 87905 |     553 |    6595 |  11 |    11 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 59738     Test LOC: 28167     Code to Test Ratio: 1:0.5


$ rails_stats /users/brian/examples//users/brian/examples/gitlabhq

Directory: /users/brian/examples/gitlabhq

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  3690 |  2890 |      66 |     384 |   5 |     5 |
| Finders              |   428 |   267 |       8 |      27 |   3 |     7 |
| Helpers              |  2280 |  1761 |       0 |     222 |   0 |     5 |
| Mailers              |   382 |   275 |       1 |      29 |  29 |     7 |
| Models               |  6922 |  4680 |      58 |     714 |  12 |     4 |
| Services             |  2021 |  1502 |      51 |     149 |   2 |     8 |
| Uploaders            |    81 |    62 |       2 |      14 |   7 |     2 |
| Workers              |   128 |    99 |       6 |       8 |   1 |    10 |
| Javascripts          |  3843 |  2936 |       1 |     534 | 534 |     3 |
| Libraries            |  7246 |  4785 |     120 |     438 |   3 |     8 |
| Configuration        |  1421 |   782 |       4 |      11 |   2 |    69 |
| Controller Tests     |   428 |   334 |       0 |       0 |   0 |     0 |
| Spec Support         |  1119 |   715 |       2 |      27 |  13 |    24 |
| Other Tests          |    67 |    55 |       0 |       0 |   0 |     0 |
| Feature Tests        |  2209 |  1765 |       0 |       8 |   0 |   218 |
| Finder Tests         |   281 |   230 |       0 |       0 |   0 |     0 |
| Helper Tests         |  1608 |  1255 |       0 |       5 |   0 |   249 |
| Lib Tests            |  1459 |  1180 |       1 |      11 |  11 |   105 |
| Mailer Tests         |   630 |   478 |       0 |       0 |   0 |     0 |
| Model Tests          |  3856 |  2669 |       0 |      10 |   0 |   264 |
| Request Tests        |  4229 |  3600 |       0 |      10 |   0 |   358 |
| Routing Tests        |   849 |   520 |       0 |       0 |   0 |     0 |
| Service Tests        |  1611 |  1307 |       0 |      34 |   0 |    36 |
| Worker Tests         |    45 |    35 |       0 |       2 |   0 |    15 |
| Cucumber Features    |  6749 |  5734 |     141 |     947 |   6 |     4 |
| Cucumber Support     |  6235 |  4980 |      65 |      71 |   1 |    68 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 59817 | 44896 |     526 |    3655 |   6 |    10 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 20039     Test LOC: 24857     Code to Test Ratio: 1:1.2


$ rails_stats /users/brian/examples//users/brian/examples/redmine/

Directory: /users/brian/examples/redmine

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  6738 |  5005 |      51 |     416 |   8 |    10 |
| Helpers              |  4445 |  3014 |       2 |     281 | 140 |     8 |
| Models               | 13221 |  9369 |      86 |    1026 |  11 |     7 |
| Libraries            | 19041 | 13499 |     137 |    1147 |   8 |     9 |
| Configuration        |   779 |   550 |      14 |      18 |   1 |    28 |
| Integration Tests    |  8286 |  6032 |      92 |     202 |   2 |    27 |
| Other Tests          |   669 |   521 |       3 |      53 |  17 |     7 |
| Test Support         |  1102 |   791 |       8 |      70 |   8 |     9 |
| Functional Tests     | 18448 | 14784 |      61 |    1372 |  22 |     8 |
| Unit Tests           | 23680 | 18217 |     117 |    1783 |  15 |     8 |
| Helper Tests         |  3321 |  2567 |      16 |     171 |  10 |    13 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 99730 | 74349 |     587 |    6539 |  11 |     9 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 31437     Test LOC: 42912     Code to Test Ratio: 1:1.4


$ rails_stats /users/brian/examples//users/brian/examples/refinerycms

Directory: /users/brian/examples/refinerycms

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |   950 |   748 |      17 |      83 |   4 |     7 |
| Helpers              |   399 |   308 |       0 |      28 |   0 |     9 |
| Mailers              |    22 |    18 |       1 |       2 |   2 |     7 |
| Models               |   846 |   570 |      14 |      86 |   6 |     4 |
| Presenters           |   365 |   271 |       8 |      44 |   5 |     4 |
| Javascripts          |   717 |   531 |       0 |      52 |   0 |     8 |
| Libraries            |     4 |     4 |       0 |       0 |   0 |     0 |
| Gems                 |  4166 |  2997 |      44 |     372 |   8 |     6 |
| Controller Tests     |   207 |   170 |       1 |       1 |   1 |   168 |
| Spec Support         |   309 |   243 |       2 |       6 |   3 |    38 |
| Feature Tests        |  1907 |  1484 |       0 |       4 |   0 |   369 |
| Lib Tests            |  1952 |  1687 |       6 |       4 |   0 |   419 |
| Model Tests          |  1323 |  1072 |       0 |       5 |   0 |   212 |
| Helper Tests         |   324 |   264 |       0 |       1 |   0 |   262 |
| Presenter Tests      |   355 |   299 |       0 |       0 |   0 |     0 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 13846 | 10666 |      93 |     688 |   7 |    13 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 5447     Test LOC: 5219     Code to Test Ratio: 1:1.0


$ rails_stats /users/brian/examples//users/brian/examples/spree

Directory: /users/brian/examples/spree

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  4653 |  3800 |      86 |     492 |   5 |     5 |
| Helpers              |  1142 |   949 |       0 |      90 |   0 |     8 |
| Models               |  9893 |  7308 |     167 |     973 |   5 |     5 |
| Javascripts          |  2770 |  2100 |       9 |     416 |  46 |     3 |
| Mailers              |    63 |    58 |       5 |       8 |   1 |     5 |
| Libraries            |    15 |    14 |       0 |       0 |   0 |     0 |
| Gems                 |  4690 |  3641 |      35 |     254 |   7 |    12 |
| Controller Tests     |  7344 |  6000 |       6 |      19 |   3 |   313 |
| Model Tests          | 16747 | 13452 |      20 |      27 |   1 |   496 |
| Request Tests        |    32 |    24 |       0 |       0 |   0 |     0 |
| Spec Support         |   577 |   427 |       3 |       9 |   3 |    45 |
| Feature Tests        |  6079 |  4809 |       0 |      17 |   0 |   280 |
| Helper Tests         |   602 |   470 |       2 |       1 |   0 |   468 |
| Lib Tests            |  1455 |  1216 |       8 |      11 |   1 |   108 |
| Mailer Tests         |   252 |   208 |       0 |       0 |   0 |     0 |
| Other Tests          |    33 |    27 |       0 |       0 |   0 |     0 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 56347 | 44503 |     341 |    2317 |   6 |    17 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 17870     Test LOC: 26633     Code to Test Ratio: 1:1.5

```

#### JSON Format

If you want to export the details using JSON, you can use this command:

```
$ rake stats\[test/dummy,json\]

Directory: /Users/etagwerker/Projects/fastruby/rails_stats/test/dummy

[{"name":"Mailers","lines":"4","loc":"4","classes":"1","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Models","lines":"3","loc":"3","classes":"1","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Javascripts","lines":"27","loc":"7","classes":"0","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Jobs","lines":"7","loc":"2","classes":"1","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Controllers","lines":"7","loc":"6","classes":"1","methods":"1","m_over_c":"1","loc_over_m":"4"},{"name":"Helpers","lines":"3","loc":"3","classes":"0","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Channels","lines":"8","loc":"8","classes":"2","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Configuration","lines":"417","loc":"111","classes":"1","methods":"0","m_over_c":"0","loc_over_m":"0"},{"name":"Total","lines":"476","loc":"144","classes":"7","methods":"1","m_over_c":"0","loc_over_m":"142","code_to_test_ratio":"0.0","total":true}]
```

### Testing

In order to run the tests for this gem:

```bash
bundle exec rake

# Running:

.

Fabulous run in 0.013349s, 74.9120 runs/s, 74.9120 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

### TODO

* Option to print out by app directory (stats per engine)
* Add views (jbuilder, erb, haml) but don't count towards ratios
* Support JS for projects that have it in public (but not compiled)
* Add CSS but don't count towards ratios
* Output other metrics like number of tables and columns
* Different output formatters
