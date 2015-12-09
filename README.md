# capistrano-radio release legacy
A capistrano plugin which allows you to choose one or more applcation to deploy via a text menu with extended DSL

Here's an example:

In you deploy config:

~~~ruby
role :myred1, %w{r@b.strangemic.net,rogersradio,RUBY}
role :myred2, %w{r@b.strangemic.net,gamecentrelive,GAME}

role :mygreen1, %w{deploy1@c.strangemic.net,stats.sportsnet,WP}
role :mygreen2, %w{root@c.strangemic.net,texture,WP}
role :mygreen3, %w{deploy1@c.strangemic.net,rogersradio,RUBY}
role :mygreen4, %w{deploy1@c.strangemic.net,gamecentrelive,GAME}

role :myblue1, %w{ec2-user@1.2.3.4,texture,WP}
role :myblue2, %w{ec2-user@1.2.3.4,rogersradio,RUBY}
role :myblue3, %w{ec2-user@1.2.3.4,gamecentrelive,GAME}
~~~

when you run `cap deploy` or `cap deploy:start` or other deploy tasks, you will see a menu:

~~~sh
jump# cap train deploy
Please choose which server(s) to deploy:
  [1] RUBY      r               b.strangemic.net rogersradio
  [2] GAME      r               b.strangemic.net gamecentrelive
  [3] WP        deploy1         c.strangemic.net stats.sportsnet
  [4] WP        r               c.strangemic.net texture
  [5] RUBY      deploy1         c.strangemic.net rogersradio
  [6] GAME      deploy1         c.strangemic.net gamecentrelive
  [7] WP        ec2-user        1.2.3.4    texture
  [8] RUBY      ec2-user        1.2.3.4    rogersradio
  [9] GAME      ec2-user        1.2.3.4    gamecentrelive
  [10]                           apply all (dangerous) 
Please enter host_numbers (-1): 
~~~

you can answer with:

* `1` for choosing server `example1.com`,
* `2` for `example2.com`,
* `3` or `1,2` for both.

## Installation

~~~sh
gem install capistrano-radio, github: 'wbssergey/capistrano_radio'
~~~

or put this in your `Gemfile` then run `bundle install`:

~~~ruby
gem 'capistrano-radio', require: false
~~~

After the gem is installed, put this in your `Capfile`:

~~~ruby
require 'capistrano/radio' 
~~~

