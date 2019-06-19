require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/urban_jungle.db')
require_all 'lib'
