require 'sinatra'
require './publish'
require './status_json'

get /(open|close)/ do |action|
  publish('json', status_as_json(action))
  status_as_json(action)
end
