# RailsStats

See stuff about a Rails app.

```bash
$ bundle exec thor stats:calculate ../../path/to/app/

Directory: ../../path/to/app/

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| assets               |     0 |     0 |       0 |       0 |   0 |     0 |
| controllers          |  1848 |  1483 |      32 |     174 |   5 |     6 |
| helpers              |  2257 |  1892 |      45 |     245 |   5 |     5 |
| jobs                 |   399 |   295 |      11 |      33 |   3 |     6 |
| models               |  4584 |  3509 |      61 |     526 |   8 |     4 |
| observers            |    42 |    22 |       2 |       5 |   2 |     2 |
| views                |     0 |     0 |       0 |       0 |   0 |     0 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                |  9130 |  7201 |     151 |     983 |   6 |     5 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 7201     Test LOC: 0     Code to Test Ratio: 1:0.0

```

### TODO

* option to print out by app directory (stats per engine)

