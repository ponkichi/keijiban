require 'sinatra'
require 'erb'
require 'rubygems'
require 'sequel'
require 'sinatra/reloader'

db_path = File.dirname(__FILE__) + "/keijiban.db"
DB = Sequel.sqlite(db_path)

DB.create_table :items do
  primary_key :id
  String :message
end

items = DB[:items]

get '/' do
  @messages = items.map(:message)
  erb :layout
end

post '/' do
  items.insert(:message =>params[:message])
  @messages = items.map(:message)
  erb :layout
end
