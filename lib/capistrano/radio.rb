

module Capistrano

  class Radio

    include ::Capistrano::DSL

    def self.set_default_config
      set :host_menu_prompt_msg,                'Please choose which server(s) to deploy:'
      set :host_menu_default_selection,         :all # or :first, 1
      set :host_menu_caption_of_all,            'all'
      set :host_menu_caption_of_default,        '(default)'
      set :host_menu_invalid_range_msg,         'Please provide a number in (1..%d)'
      set :host_menu_invalid_multi_choose_msg,  'Do you mean to choose all servers?'
      set :radio_data,                          'deploy1/radio_admin'
      set :radio_gemfile,                       '~/capistrano3_deployment'   
      set :radio_myrvm,                         '~/.myrvm'   
      set :radio_uploadfile,                    '~/radioadmin.sql'
      set :radio_mysqluser,                     'radio'
      set :radio_mysqlpwd,                      '' # ask
      set :array_repo,                          'git1,git2'   
    end

    def initialize
      if deploy_hosts.size > 1
        prompt_menu default: fetch(:host_menu_default_selection)
      end
    end
    def hello
      puts "hello"
    end  
    def prompt_menu default: :all
      puts fetch(:host_menu_prompt_msg)

      default     = input_for(default)
      default_cap = fetch(:host_menu_caption_of_default)

      (deploy_hosts + [fetch(:host_menu_caption_of_all)]).each_with_index do |host, i|
        shost=host.split(':')
        cap = if i == default - 1
                "[%d] %s %s" % [i+1, host, default_cap]
              else
                "[%d] %-25s %s" % [i+1, shost[0], shost[1]]
              end
        puts "  " << cap
      end

      ask :host_numbers, default.to_s
      set_hosts
    end

    private

      def input_for selection
        case selection
        when :all
          max_selection
        when 0
          1
        when Fixnum
          selection
        else
          1
        end
      end

      def max_selection
        deploy_hosts.size + 1
      end

      def deploy_hosts
        release_roles(:all)
      end

      def selection_for_all
        max_selection
      end

      def set_hosts
        ids = fetch(:host_numbers).split(/\s*,\s*/).map(&:to_i).uniq
        unless ids.all? {|i| (1..max_selection).include? i}
          puts fetch(:host_menu_invalid_range_msg) % max_selection
          exit 1
        end

        if ids.size > 1 && ids.include?(selection_for_all)
          puts fetch(:host_menu_invalid_multi_choose_msg)
          exit 1
        end

        unless ids.include?(selection_for_all)
          set_host_filter ids.map {|i| deploy_hosts[i-1].hostname}
        end
      end

      def set_host_filter hosts
        if defined? Capistrano::Configuration::Servers::HostFilter
          set :filter, hosts: hosts
        else
          # hack for Capistrano v3.3+
          Capistrano::Configuration.env.send(:servers).send(:servers).select! do |srv|
            hosts.include?(srv.hostname)
          end
        end
=begin
        def add_roles(roles)
           Array(roles).each { |role| add_role(role) }
           self
         end

       alias roles= add_roles

       def add_role(role)
         roles.add role.to_sym
         self
       end
        def set_repos
          rps=Array.new();
        end
=end          
      end

  end
end

load File.expand_path('../tasks/radio.rake', __FILE__)

