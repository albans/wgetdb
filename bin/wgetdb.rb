#!/usr/bin/env ruby

require 'commander/import'
require 'contexts.rb'
program :version, '0.0' 
program :description, 'download resources to a dropbox account'
 
command :init do |c|
  c.syntax = 'wgetdb init [options]'
  c.summary = 'Setup the dropbox account used by this program.'
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Wgetdb::Commands::Init
    ask('APP_KEY: ')
  end
end

