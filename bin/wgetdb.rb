#!/usr/bin/env ruby
require 'repository'
require 'commander/import'
require 'contexts.rb'
require 'repository/yaml_storage.rb'

program :version, '0.0' 
program :description, 'download resources to a dropbox account'
home=File::expand_path('~/.wgetdb')
Dir::mkdir(home) unless Dir::exists?(home)

account_storage = Repository::YAMLStorage.new(DropboxAccount,home+'/account.yaml') 
Repository::Storage.storage_for(DropboxAccount,account_storage)
resource_storage = Repository::YAMLStorage.new(Resource,home+'/resources.yaml') 
Repository::Storage.storage_for(Resource,resource_storage)

command :init do |c|
  c.syntax = 'wgetdb init [options]'
  c.summary = 'Setup the dropbox account used by this program.'
  c.description = ''
  c.example 'Setting application key and secret on the command line', 
            'wgetdb init --key YOUR_APP_KEY --secret YOUR_APP_SECRET'
  c.option '--key STRING', String, 'The application key'
  c.option '--secret STRING', String, 'The application secret'
  c.option '--browser STRING', String, 'The command to use visite the authorize link'
  c.action do |args, options|
    app_key = options.key || ask('APP_KEY: ')
    app_secret = options.secret || ask('APP_SECRET: ')
    browser = options.browser
    say "Connecting to your dropbox account. APP_KEY=#{app_key} APP_SECRET=#{app_secret}"
    context = LogIntoDropboxAccount.new(app_key, app_secret, lambda { |url|
      if browser
        system "#{browser} #{url}"
      else
        say "You have logged into your dropbox account. You need visite the following link to authorize the application: #{url}"
      end
      say("Once you have authorized the application, press enter to complete the initialization.")
     $stdin.gets
    })
    context.run
  end
end

command :put do |c|
  c.syntax= 'wget put RESOURCE'
  c.summary= 'Put the RESOURCE into the dropbox application folder'
  c.description = ''
  c.example 'Setting application key and secret on the command line', 
            'wgetdb init --key YOUR_APP_KEY --secret YOUR_APP_SECRET'
  c.action do |args|
    args.each do |arg|
      say "dowloading #{arg}..."
      context = DownloadResource.new(arg, lambda{|meta| puts meta.inspect})
      context.run
    end
  end
end
command :history do |c|
  c.syntax= 'wget history'
  c.summary= 'Output the complete list of previous operation'
  c.description='Write the detailed list of all previous operation on resources on the standard output'
  c.action do |args|
    context = ListResources.new
    resources = context.run
    resources.each do |resource|
      puts "#{resource.id}\t#{resource.path}\t#{resource.size}\t#{resource.uri}"
    end
  end
end
