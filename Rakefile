require "bundler/setup"

require 'sqlite3'
require 'active_record'
require 'yaml'

namespace :db do

  desc "Migrate the db"
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details)
    #ActiveRecord::Migration.migrate("db/migrate/")
    ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration).migrate
  end

  desc "drop the db"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    sh "rm -f  #{connection_details['database']}"
  end
end

desc "Run fixtures"
task :fixtures do
  # Set env var
  config = YAML::load(File.open('config/database.yml'))
  weburi = config['weburi']
  sh "WEBURI=#{weburi} fixtures/quote.sh"
  sh "WEBURI=#{weburi} fixtures/link.sh"
end


desc "Run dev app"
task :app do
  sh "bundle exec ruby app/router.rb"
end
