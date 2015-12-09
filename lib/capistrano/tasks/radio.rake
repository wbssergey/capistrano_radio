namespace :deploy do

  desc 'print environment variables'
  task :info do


  release_roles(:all).map do |h|
         #  sh=h.to_s.split(',')
      set :array_repo,  fetch(:array_repo).push(h.to_s) # sh[3]) #
         end

    puts "--" * 50
    puts "About to deploy, check your parameters~"
    puts "env:    #{fetch(:rails_env).to_s.bold}"
    puts "branch: #{fetch(:branch).to_s.bold}"
    puts "server: #{roles(:all).map(&:hostname).join("\n        ")}"
    puts "radio_data: #{fetch(:radio_data)}"
    puts "radio_gemfile: #{fetch(:radio_gemfile)}"
    puts "radio_myrvm:   #{fetch(:radio_myrvm)}"
    puts "radio_uploadfile: #{fetch(:radio_uploadfile)}"
    puts "radio_mysqluser: #{fetch(:radio_mysqluser)}"
    puts "radio_mysqlpwd: #{fetch(:radio_mysqlpwd)} ask"
    puts "array_repo, #{fetch(:array_repo).to_s.bold}"
#    puts "all_repo, #{fetch(:all_repo).to_s.bold}"
    puts "--" * 50

  desc <<-DESC
        Prompt a text based list menu for user to select. \
        Following changes will only be applied on selected servers.

        User will see menu like this:

        ~~~
        Please select target host(s):
          [1] my.example1.com
          [2] my.example2.com
          [3] all (default)
        Please enter host_numbers (3):
        ~~~
    DESC

    
# after selection done - truncate long role names to ssh <user@domain>
  release_roles(:all).map do |h|
           sh=h.to_s.split(',')
           h.hostname=sh[0]
         end

  end

  task :radio_menu do
    next if fetch(:show_radio_menu) == false

    Capistrano::Radio.new
    invoke 'deploy:info' unless fetch(:host_menu_show_info_after_select) == false
  end
end


Capistrano::Radio.set_default_config

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:radio_menu'
end
              
