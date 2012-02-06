require 'sinatra'
require 'mongo'

before do
  @mongo = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  uri = URI.parse(ENV['MONGOLAB_URI'])
  @states = @mongo.db(uri.path.gsub(/^\//, '')).collection('states')
  @state = @states.find_one || { 'open' => 'false' }
end

get '/' do
  haml :index, :locals => { :state => @state }
end

get '/json' do
  erb :json, :locals => { :state => @state }, :content_type => 'application/json'
end

get '/open' do
  @state['open'] = 'open'
end

get '/close' do
  @state['open'] = 'close'
end

after do
  @states.save @state
  @mongo.close
end
