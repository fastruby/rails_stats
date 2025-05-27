# RailsStats

See stuff about a Rails app.

There were a few things missing to the included `rake stats`

RailsStats mainly adds the ability to be run from outside the project in question. This can be helpful if the app you are interested in can not be booted for some reason.

### Run it outside Rails project

You will need a `Rakefile` in the directory where you call `rake` and you will
need to require `rails_stats`:

```ruby
# Rakefile
require "rails_stats"
```

Then you can call it:

```bash
$ rake stats\[/path/to/app/\]

Directory: /path/to/app/

+-----------------------|------------|----------------+
|                  Name | Total Deps | 1st Level Deps |
+-----------------------|------------|----------------+
|     simplecov-console | 7          | 3              |
|               codecov | 5          | 2              |
|           rails_stats | 4          | 2              |
|             simplecov | 3          | 3              |
|       minitest-around | 1          | 1              |
|               bundler | 0          | 0              |
|                byebug | 0          | 0              |
|              minitest | 0          | 0              |
| minitest-spec-context | 0          | 0              |
+-----------------------|------------|----------------+

      Declared Gems   9
         Total Gems   18
  Unpinned Versions   8
        Github Refs   0

+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Name                 | Files   | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Channels             |       2 |       8 |       8 |       2 |       0 |   0 |     0 |
| Configuration        |      19 |     417 |     111 |       1 |       0 |   0 |     0 |
| Controllers          |       1 |       7 |       6 |       1 |       1 |   1 |     4 |
| Helpers              |       1 |       3 |       3 |       0 |       0 |   0 |     0 |
| Javascripts          |       3 |      27 |       7 |       0 |       0 |   0 |     0 |
| Jobs                 |       1 |       7 |       2 |       1 |       0 |   0 |     0 |
| Libraries            |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
| Mailers              |       1 |       4 |       4 |       1 |       0 |   0 |     0 |
| Model Tests          |       2 |       5 |       4 |       2 |       0 |   0 |     0 |
| Models               |       1 |       3 |       3 |       1 |       0 |   0 |     0 |
| Spec Support         |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
| Test Support         |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Code                 |      30 |     477 |     145 |       7 |       1 |   0 |   143 |
| Tests                |       4 |       7 |       6 |       2 |       0 |   0 |     0 |
| Total                |      34 |     484 |     151 |       9 |       1 |   0 |   149 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
  Code LOC: 145     Test LOC: 6     Code to Test Ratio: 1:0.0  Files: 34
```

### Run it on many Rails engines

```bash
$ for dir in /path/to/many/engines/*/; do bundle exec rake stats[$dir]; done
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

$ bundle exec rake stats[/users/brian/examples/redmine/]

+-----------------------|------------|----------------+
|                  Name | Total Deps | 1st Level Deps |
+-----------------------|------------|----------------+
|                 rails | 62         | 13             |
|          roadie-rails | 45         | 2              |
| actionpack-xml_parser | 41         | 2              |
|       importmap-rails | 41         | 3              |
|             propshaft | 41         | 4              |
|        stimulus-rails | 41         | 1              |
|         rubocop-rails | 28         | 5              |
|   rubocop-performance | 15         | 3              |
|         html-pipeline | 14         | 2              |
|     rails-dom-testing | 14         | 3              |
|               rubocop | 14         | 10             |
|                bullet | 13         | 2              |
|              capybara | 10         | 8              |
|                 debug | 10         | 2              |
|                  mail | 7          | 4              |
|    selenium-webdriver | 5          | 5              |
|           rails_stats | 4          | 2              |
|            svg_sprite | 4          | 3              |
|          bundle-audit | 3          | 1              |
|                listen | 3          | 2              |
|              net-imap | 3          | 2              |
|              sanitize | 3          | 2              |
|             simplecov | 3          | 3              |
|           mini_magick | 2          | 2              |
|               net-pop | 2          | 1              |
|              net-smtp | 2          | 1              |
|                 rbpdf | 2          | 2              |
|               rqrcode | 2          | 2              |
|           addressable | 1          | 1              |
|                  i18n | 1          | 1              |
|                 mocha | 1          | 1              |
|              nokogiri | 1          | 1              |
|                  puma | 1          | 1              |
|          commonmarker | 0          | 0              |
|                   csv | 0          | 0              |
|                   ffi | 0          | 0              |
|                marcel | 0          | 0              |
|             mini_mime | 0          | 0              |
|              net-ldap | 0          | 0              |
|                  rack | 0          | 0              |
|                  rotp | 0          | 0              |
|                 rouge | 0          | 0              |
|               rubyzip | 0          | 0              |
|           tzinfo-data | 0          | 0              |
|                  yard | 0          | 0              |
+-----------------------|------------|----------------+

      Declared Gems   45
         Total Gems   144
  Unpinned Versions   19
        Github Refs   0

+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Name                 | Files   | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Configuration        |      17 |    1090 |     666 |       7 |      14 |   2 |    45 |
| Controllers          |      57 |    9042 |    6746 |      60 |     554 |   9 |    10 |
| Functional Tests     |      65 |   35754 |   30234 |      65 |    2104 |  32 |    12 |
| Helper Tests         |      27 |    5369 |    4090 |      28 |     302 |  10 |    11 |
| Helpers              |      49 |    7068 |    5168 |       1 |     413 | 413 |    10 |
| Integration Tests    |      98 |   10349 |    7237 |     104 |     297 |   2 |    22 |
| Javascripts          |     117 |    6930 |    5362 |       0 |     446 |   0 |    10 |
| Job Tests            |       2 |     142 |      94 |       2 |       2 |   1 |    45 |
| Jobs                 |       3 |     115 |      90 |       3 |       9 |   3 |     8 |
| Libraries            |     134 |   18922 |   13178 |     128 |    1167 |   9 |     9 |
| Models               |      88 |   20110 |   14528 |     110 |    1532 |  13 |     7 |
| Other Tests          |      19 |    2339 |    1525 |      19 |      98 |   5 |    13 |
| Test Support         |      16 |    1637 |    1229 |      20 |     142 |   7 |     6 |
| Unit Tests           |     147 |   37173 |   28642 |     161 |    2778 |  17 |     8 |
| Validators           |       1 |      29 |      10 |       1 |       1 |   1 |     8 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Code                 |     466 |   63306 |   45748 |     310 |    4136 |  13 |     9 |
| Tests                |     374 |   92763 |   73051 |     399 |    5723 |  14 |    10 |
| Total                |     840 |  156069 |  118799 |     709 |    9859 |  13 |    10 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
  Code LOC: 45748     Test LOC: 73051     Code to Test Ratio: 1:1.6  Files: 840

```

#### JSON Format

If you want to export the details using JSON, you can use this command:

```
$ rake stats\[test/dummy,json\]

Directory: /Users/etagwerker/Projects/redmine

[{"summary":{"declared":45,"unpinned":19,"total":144,"github":0},"gems":[{"name":"rails","total_dependencies":62,"first_level_dependencies":13,"top_level_dependencies":{},"transitive_dependencies":["actioncable (= 7.2.2.1)","actionmailbox (= 7.2.2.1)","actionmailer (= 7.2.2.1)","actionpack (= 7.2.2.1)","actiontext (= 7.2.2.1)","actionview (= 7.2.2.1)","activejob (= 7.2.2.1)","activemodel (= 7.2.2.1)","activerecord (= 7.2.2.1)","activestorage (= 7.2.2.1)","activesupport (= 7.2.2.1)","bundler (>= 1.15.0)","railties (= 7.2.2.1)","nio4r (~> 2.0)","websocket-driver (>= 0.6.1)","zeitwerk (~> 2.6)","nokogiri (>= 1.8.5)","racc (>= 0)","rack (>= 2.2.4, < 3.2)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","websocket-extensions (>= 0.1.0)","mail (>= 2.8.0)","globalid (>= 0.3.6)","timeout (>= 0.4.0)","marcel (~> 1.0)","mini_mime (>= 0.1.1)","net-imap (>= 0)","net-pop (>= 0)","net-smtp (>= 0)","date (>= 0)","net-protocol (>= 0)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"roadie-rails","total_dependencies":45,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["railties (>= 5.1, < 8.1)","roadie (~> 5.0)","actionpack (= 7.2.2.1)","activesupport (= 7.2.2.1)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","zeitwerk (~> 2.6)","actionview (= 7.2.2.1)","nokogiri (>= 1.8.5)","racc (>= 0)","rack (>= 2.2.4, < 3.2)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)","css_parser (~> 1.4)","addressable (>= 0)","public_suffix (>= 2.0.2, < 7.0)"]},{"name":"actionpack-xml_parser","total_dependencies":41,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["actionpack (>= 5.0)","railties (>= 5.0)","actionview (= 7.2.2.1)","activesupport (= 7.2.2.1)","nokogiri (>= 1.8.5)","racc (>= 0)","rack (>= 2.2.4, < 3.2)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","zeitwerk (~> 2.6)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"importmap-rails","total_dependencies":41,"first_level_dependencies":3,"top_level_dependencies":{},"transitive_dependencies":["actionpack (>= 6.0.0)","activesupport (>= 6.0.0)","railties (>= 6.0.0)","actionview (= 7.2.2.1)","nokogiri (>= 1.8.5)","racc (>= 0)","rack (>= 2.2.4, < 3.2)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","zeitwerk (~> 2.6)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"propshaft","total_dependencies":41,"first_level_dependencies":4,"top_level_dependencies":{},"transitive_dependencies":["actionpack (>= 7.0.0)","activesupport (>= 7.0.0)","rack (>= 0)","railties (>= 7.0.0)","actionview (= 7.2.2.1)","nokogiri (>= 1.8.5)","racc (>= 0)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","zeitwerk (~> 2.6)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"stimulus-rails","total_dependencies":41,"first_level_dependencies":1,"top_level_dependencies":{},"transitive_dependencies":["railties (>= 6.0.0)","actionpack (= 7.2.2.1)","activesupport (= 7.2.2.1)","irb (~> 1.13)","rackup (>= 1.0.0)","rake (>= 12.2)","thor (~> 1.0, >= 1.2.2)","zeitwerk (~> 2.6)","actionview (= 7.2.2.1)","nokogiri (>= 1.8.5)","racc (>= 0)","rack (>= 2.2.4, < 3.2)","rack-session (>= 1.0.1)","rack-test (>= 0.6.3)","rails-dom-testing (~> 2.2)","rails-html-sanitizer (~> 1.6)","useragent (~> 0.16)","builder (~> 3.1)","erubi (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","loofah (~> 2.21)","crass (~> 1.0.2)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","reline (>= 0.4.2)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"rubocop-rails","total_dependencies":28,"first_level_dependencies":5,"top_level_dependencies":{},"transitive_dependencies":["activesupport (>= 4.2.0)","lint_roller (~> 1.1)","rack (>= 1.1)","rubocop (>= 1.75.0, < 2.0)","rubocop-ast (>= 1.38.0, < 2.0)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","json (~> 2.3)","language_server-protocol (~> 3.17.0.2)","parallel (~> 1.10)","parser (>= 3.3.0.2)","rainbow (>= 2.2.2, < 4.0)","regexp_parser (>= 2.9.3, < 3.0)","ruby-progressbar (~> 1.7)","unicode-display_width (>= 2.4.0, < 4.0)","ast (~> 2.4.1)","racc (>= 0)","prism (~> 1.4)","unicode-emoji (~> 4.0, >= 4.0.4)"]},{"name":"rubocop-performance","total_dependencies":15,"first_level_dependencies":3,"top_level_dependencies":{},"transitive_dependencies":["lint_roller (~> 1.1)","rubocop (>= 1.75.0, < 2.0)","rubocop-ast (>= 1.38.0, < 2.0)","json (~> 2.3)","language_server-protocol (~> 3.17.0.2)","parallel (~> 1.10)","parser (>= 3.3.0.2)","rainbow (>= 2.2.2, < 4.0)","regexp_parser (>= 2.9.3, < 3.0)","ruby-progressbar (~> 1.7)","unicode-display_width (>= 2.4.0, < 4.0)","ast (~> 2.4.1)","racc (>= 0)","prism (~> 1.4)","unicode-emoji (~> 4.0, >= 4.0.4)"]},{"name":"html-pipeline","total_dependencies":14,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["activesupport (>= 2)","nokogiri (>= 1.4)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","racc (~> 1.4)"]},{"name":"rails-dom-testing","total_dependencies":14,"first_level_dependencies":3,"top_level_dependencies":{"actioncable":"actioncable (7.2.2.1)","actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","actionpack":"actionpack (7.2.2.1)","actionpack-xml_parser":"actionpack-xml_parser (2.0.1)","actiontext":"actiontext (7.2.2.1)","actionview":"actionview (7.2.2.1)","activestorage":"activestorage (7.2.2.1)","importmap-rails":"importmap-rails (2.1.0)","propshaft":"propshaft (1.1.0)","rails":"rails (7.2.2.1)","railties":"railties (7.2.2.1)","roadie-rails":"roadie-rails (3.3.0)","stimulus-rails":"stimulus-rails (1.3.4)"},"transitive_dependencies":["activesupport (>= 5.0.0)","minitest (>= 0)","nokogiri (>= 1.6)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)","racc (~> 1.4)"]},{"name":"rubocop","total_dependencies":14,"first_level_dependencies":10,"top_level_dependencies":{"rubocop-performance":"rubocop-performance (1.25.0)","rubocop-rails":"rubocop-rails (2.31.0)"},"transitive_dependencies":["json (~> 2.3)","language_server-protocol (~> 3.17.0.2)","lint_roller (~> 1.1.0)","parallel (~> 1.10)","parser (>= 3.3.0.2)","rainbow (>= 2.2.2, < 4.0)","regexp_parser (>= 2.9.3, < 3.0)","rubocop-ast (>= 1.44.0, < 2.0)","ruby-progressbar (~> 1.7)","unicode-display_width (>= 2.4.0, < 4.0)","ast (~> 2.4.1)","racc (>= 0)","prism (~> 1.4)","unicode-emoji (~> 4.0, >= 4.0.4)"]},{"name":"bullet","total_dependencies":13,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["activesupport (>= 3.0.0)","uniform_notifier (~> 1.11)","base64 (>= 0)","benchmark (>= 0.3)","bigdecimal (>= 0)","concurrent-ruby (~> 1.0, >= 1.3.1)","connection_pool (>= 2.2.5)","drb (>= 0)","i18n (>= 1.6, < 2)","logger (>= 1.4.2)","minitest (>= 5.1)","securerandom (>= 0.3)","tzinfo (~> 2.0, >= 2.0.5)"]},{"name":"capybara","total_dependencies":10,"first_level_dependencies":8,"top_level_dependencies":{},"transitive_dependencies":["addressable (>= 0)","matrix (>= 0)","mini_mime (>= 0.1.3)","nokogiri (~> 1.11)","rack (>= 1.6.0)","rack-test (>= 0.6.3)","regexp_parser (>= 1.5, < 3.0)","xpath (~> 3.2)","public_suffix (>= 2.0.2, < 7.0)","racc (~> 1.4)"]},{"name":"debug","total_dependencies":10,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["irb (~> 1.10)","reline (>= 0.3.8)","pp (>= 0.6.0)","rdoc (>= 4.0.0)","prettyprint (>= 0)","erb (>= 0)","psych (>= 4.0.0)","date (>= 0)","stringio (>= 0)","io-console (~> 0.5)"]},{"name":"mail","total_dependencies":7,"first_level_dependencies":4,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":["mini_mime (>= 0.1.1)","net-imap (>= 0)","net-pop (>= 0)","net-smtp (>= 0)","date (>= 0)","net-protocol (>= 0)","timeout (>= 0)"]},{"name":"selenium-webdriver","total_dependencies":5,"first_level_dependencies":5,"top_level_dependencies":{},"transitive_dependencies":["base64 (~> 0.2)","logger (~> 1.4)","rexml (~> 3.2, >= 3.2.5)","rubyzip (>= 1.2.2, < 3.0)","websocket (~> 1.0)"]},{"name":"rails_stats","total_dependencies":4,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["bundler-stats (>= 2.1)","rake (>= 0)","bundler (>= 1.9, < 3)","thor (>= 0.19.0, < 2.0)"]},{"name":"svg_sprite","total_dependencies":4,"first_level_dependencies":3,"top_level_dependencies":{},"transitive_dependencies":["nokogiri (>= 0)","svg_optimizer (>= 0)","thor (>= 0)","racc (~> 1.4)"]},{"name":"bundle-audit","total_dependencies":3,"first_level_dependencies":1,"top_level_dependencies":{},"transitive_dependencies":["bundler-audit (>= 0)","bundler (>= 1.2.0, < 3)","thor (~> 1.0)"]},{"name":"listen","total_dependencies":3,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["rb-fsevent (~> 0.10, >= 0.10.3)","rb-inotify (~> 0.9, >= 0.9.10)","ffi (~> 1.0)"]},{"name":"net-imap","total_dependencies":3,"first_level_dependencies":2,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","mail":"mail (2.8.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":["date (>= 0)","net-protocol (>= 0)","timeout (>= 0)"]},{"name":"sanitize","total_dependencies":3,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["crass (~> 1.0.2)","nokogiri (>= 1.12.0)","racc (~> 1.4)"]},{"name":"simplecov","total_dependencies":3,"first_level_dependencies":3,"top_level_dependencies":{},"transitive_dependencies":["docile (~> 1.1)","simplecov-html (~> 0.11)","simplecov_json_formatter (~> 0.1)"]},{"name":"mini_magick","total_dependencies":2,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["benchmark (>= 0)","logger (>= 0)"]},{"name":"net-pop","total_dependencies":2,"first_level_dependencies":1,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","mail":"mail (2.8.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":["net-protocol (>= 0)","timeout (>= 0)"]},{"name":"net-smtp","total_dependencies":2,"first_level_dependencies":1,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","mail":"mail (2.8.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":["net-protocol (>= 0)","timeout (>= 0)"]},{"name":"rbpdf","total_dependencies":2,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["htmlentities (>= 0)","rbpdf-font (~> 1.19.0)"]},{"name":"rqrcode","total_dependencies":2,"first_level_dependencies":2,"top_level_dependencies":{},"transitive_dependencies":["chunky_png (~> 1.0)","rqrcode_core (~> 2.0)"]},{"name":"addressable","total_dependencies":1,"first_level_dependencies":1,"top_level_dependencies":{"capybara":"capybara (3.40.0)","css_parser":"css_parser (1.21.1)","roadie":"roadie (5.2.1)","roadie-rails":"roadie-rails (3.3.0)"},"transitive_dependencies":["public_suffix (>= 2.0.2, < 7.0)"]},{"name":"i18n","total_dependencies":1,"first_level_dependencies":1,"top_level_dependencies":{"actioncable":"actioncable (7.2.2.1)","actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","actionpack":"actionpack (7.2.2.1)","actionpack-xml_parser":"actionpack-xml_parser (2.0.1)","actiontext":"actiontext (7.2.2.1)","actionview":"actionview (7.2.2.1)","activejob":"activejob (7.2.2.1)","activemodel":"activemodel (7.2.2.1)","activerecord":"activerecord (7.2.2.1)","activestorage":"activestorage (7.2.2.1)","activesupport":"activesupport (7.2.2.1)","bullet":"bullet (8.0.7)","globalid":"globalid (1.2.1)","html-pipeline":"html-pipeline (2.13.2)","importmap-rails":"importmap-rails (2.1.0)","propshaft":"propshaft (1.1.0)","rails":"rails (7.2.2.1)","rails-dom-testing":"rails-dom-testing (2.2.0)","railties":"railties (7.2.2.1)","roadie-rails":"roadie-rails (3.3.0)","rubocop-rails":"rubocop-rails (2.31.0)","stimulus-rails":"stimulus-rails (1.3.4)"},"transitive_dependencies":["concurrent-ruby (~> 1.0)"]},{"name":"mocha","total_dependencies":1,"first_level_dependencies":1,"top_level_dependencies":{},"transitive_dependencies":["ruby2_keywords (>= 0.0.5)"]},{"name":"nokogiri","total_dependencies":1,"first_level_dependencies":1,"top_level_dependencies":{"actioncable":"actioncable (7.2.2.1)","actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","actionpack":"actionpack (7.2.2.1)","actionpack-xml_parser":"actionpack-xml_parser (2.0.1)","actiontext":"actiontext (7.2.2.1)","actionview":"actionview (7.2.2.1)","activestorage":"activestorage (7.2.2.1)","capybara":"capybara (3.40.0)","html-pipeline":"html-pipeline (2.13.2)","importmap-rails":"importmap-rails (2.1.0)","loofah":"loofah (2.24.1)","propshaft":"propshaft (1.1.0)","rails":"rails (7.2.2.1)","rails-dom-testing":"rails-dom-testing (2.2.0)","rails-html-sanitizer":"rails-html-sanitizer (1.6.2)","railties":"railties (7.2.2.1)","roadie":"roadie (5.2.1)","roadie-rails":"roadie-rails (3.3.0)","sanitize":"sanitize (6.1.3)","stimulus-rails":"stimulus-rails (1.3.4)","svg_optimizer":"svg_optimizer (0.3.0)","svg_sprite":"svg_sprite (1.0.3)","xpath":"xpath (3.2.0)"},"transitive_dependencies":["racc (~> 1.4)"]},{"name":"puma","total_dependencies":1,"first_level_dependencies":1,"top_level_dependencies":{},"transitive_dependencies":["nio4r (~> 2.0)"]},{"name":"commonmarker","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"csv","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"ffi","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{"listen":"listen (3.9.0)","rb-inotify":"rb-inotify (0.11.1)"},"transitive_dependencies":[]},{"name":"marcel","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actiontext":"actiontext (7.2.2.1)","activestorage":"activestorage (7.2.2.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":[]},{"name":"mini_mime","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{"actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","capybara":"capybara (3.40.0)","mail":"mail (2.8.1)","rails":"rails (7.2.2.1)"},"transitive_dependencies":[]},{"name":"net-ldap","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"rack","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{"actioncable":"actioncable (7.2.2.1)","actionmailbox":"actionmailbox (7.2.2.1)","actionmailer":"actionmailer (7.2.2.1)","actionpack":"actionpack (7.2.2.1)","actionpack-xml_parser":"actionpack-xml_parser (2.0.1)","actiontext":"actiontext (7.2.2.1)","activestorage":"activestorage (7.2.2.1)","capybara":"capybara (3.40.0)","importmap-rails":"importmap-rails (2.1.0)","propshaft":"propshaft (1.1.0)","rack-session":"rack-session (2.1.1)","rack-test":"rack-test (2.2.0)","rackup":"rackup (2.2.1)","rails":"rails (7.2.2.1)","railties":"railties (7.2.2.1)","roadie-rails":"roadie-rails (3.3.0)","rubocop-rails":"rubocop-rails (2.31.0)","stimulus-rails":"stimulus-rails (1.3.4)"},"transitive_dependencies":[]},{"name":"rotp","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"rouge","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"rubyzip","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{"selenium-webdriver":"selenium-webdriver (4.32.0)"},"transitive_dependencies":[]},{"name":"tzinfo-data","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]},{"name":"yard","total_dependencies":0,"first_level_dependencies":0,"top_level_dependencies":{},"transitive_dependencies":[]}]},{"name":"Models","files":"88","lines":"20110","loc":"14528","classes":"110","methods":"1532","m_over_c":"13","loc_over_m":"7"},{"name":"Validators","files":"1","lines":"29","loc":"10","classes":"1","methods":"1","m_over_c":"1","loc_over_m":"8"},{"name":"Javascripts","files":"117","lines":"6930","loc":"5362","classes":"0","methods":"446","m_over_c":"0","loc_over_m":"10"},{"name":"Jobs","files":"3","lines":"115","loc":"90","classes":"3","methods":"9","m_over_c":"3","loc_over_m":"8"},{"name":"Controllers","files":"57","lines":"9042","loc":"6746","classes":"60","methods":"554","m_over_c":"9","loc_over_m":"10"},{"name":"Helpers","files":"49","lines":"7068","loc":"5168","classes":"1","methods":"413","m_over_c":"413","loc_over_m":"10"},{"name":"Libraries","files":"134","lines":"18922","loc":"13178","classes":"128","methods":"1167","m_over_c":"9","loc_over_m":"9"},{"name":"Configuration","files":"17","lines":"1090","loc":"666","classes":"7","methods":"14","m_over_c":"2","loc_over_m":"45"},{"name":"Integration Tests","files":"98","lines":"10349","loc":"7237","classes":"104","methods":"297","m_over_c":"2","loc_over_m":"22"},{"name":"Test Support","files":"16","lines":"1637","loc":"1229","classes":"20","methods":"142","m_over_c":"7","loc_over_m":"6"},{"name":"Other Tests","files":"19","lines":"2339","loc":"1525","classes":"19","methods":"98","m_over_c":"5","loc_over_m":"13"},{"name":"Functional Tests","files":"65","lines":"35754","loc":"30234","classes":"65","methods":"2104","m_over_c":"32","loc_over_m":"12"},{"name":"Helper Tests","files":"27","lines":"5369","loc":"4090","classes":"28","methods":"302","m_over_c":"10","loc_over_m":"11"},{"name":"Unit Tests","files":"147","lines":"37173","loc":"28642","classes":"161","methods":"2778","m_over_c":"17","loc_over_m":"8"},{"name":"Job Tests","files":"2","lines":"142","loc":"94","classes":"2","methods":"2","m_over_c":"1","loc_over_m":"45"},{"name":"Code","files":"466","lines":"63306","loc":"45748","classes":"310","methods":"4136","m_over_c":"13","loc_over_m":"9","code_to_test_ratio":"1.6","total":true},{"name":"Tests","files":"374","lines":"92763","loc":"73051","classes":"399","methods":"5723","m_over_c":"14","loc_over_m":"10","code_to_test_ratio":"1.6","total":true},{"name":"Total","files":"840","lines":"156069","loc":"118799","classes":"709","methods":"9859","m_over_c":"13","loc_over_m":"10","code_to_test_ratio":"1.6","total":true}]
```

### Testing

In order to run the tests for this gem:

```bash
bundle exec rake test

# Running:

..

Fabulous run in 0.097903s, 20.4284 runs/s, 142.9987 assertions/s.

2 runs, 14 assertions, 0 failures, 0 errors, 0 skips
```

### TODO

* Option to print out by app directory (stats per engine)
* Add views (jbuilder, erb, haml) but don't count towards ratios
* Support JS for projects that have it in public (but not compiled)
* Add CSS but don't count towards ratios
* Output other metrics like number of tables and columns
* Different output formatters
