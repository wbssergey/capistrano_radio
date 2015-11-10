# capistrano-radio release 2
A capistrano plugin which allows you to choose one or more server to deploy via a text menu with extended DSL

Here's an example:

In you deploy config:

~~~ruby
server 'example1.com', user: "#{fetch(:deploy_user)}", roles: %w{web app}
server 'example2.com', user: "#{fetch(:deploy_user)}", roles: %w{web app}
~~~

when you run `cap deploy` or `cap deploy:start` or other deploy tasks, you will see a menu:

~~~sh
Please choose which server(s) to deploy:
  [1] example1.com
  [2] example2.com
  [3] all (default)
Please enter host_numbers (3):
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

Then you will see host selecting menu any time before deploying.

## Configurations

set these variables in your deploy config (commonly `deploy.rb`)

~~~ruby
      set :radio_data,                          'deploy1/radio_admin'
      set :radio_gemfile,                       '~/capistrano3_deployment'   
      set :radio_myrvm,                         '~/.myrvm'   
      set :radio_uploadfile,                    '~/radioadmin.sql'
      set :radio_mysqluser,                     'radio'
      set :radio_mysqlpwd,                      '' # ask   
~~~
# capistrano_radio
