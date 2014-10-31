# RailsStats

See stuff about a Rails app.

```bash
$ bundle exec thor stats:calculate ../../path/to/app/

Directory: ../../path/to/app/

+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |  1848 |  1483 |      32 |     174 |   5 |     6 |
| Helpers              |  2257 |  1892 |      45 |     245 |   5 |     5 |
| Models               |  4584 |  3509 |      61 |     526 |   8 |     4 |
| Libraries            |  2987 |  2272 |      30 |     287 |   9 |     5 |
| Helper tests         |   124 |   107 |       3 |      16 |   5 |     4 |
| Model tests          |  3397 |  2522 |       0 |      18 |   0 |   138 |
| Integration tests    |    91 |    73 |       0 |       1 |   0 |    71 |
| Library tests        |   856 |   721 |       0 |       2 |   0 |   358 |
| Cucumber tests       |   739 |   521 |       0 |       1 |   0 |   519 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                | 16883 | 13100 |     171 |    1270 |   7 |     8 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 9156     Test LOC: 3944     Code to Test Ratio: 1:0.4
```