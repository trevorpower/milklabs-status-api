require 'sinatra'

def status_as_json(action)
  erb :json, :locals => { :action => action }
end
