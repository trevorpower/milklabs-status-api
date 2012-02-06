require 'sinatra'
require 'mongo'

before do
  @mongo = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  uri = URI.parse(ENV['MONGOLAB_URI'])
  @states = @mongo.db(uri.path.gsub(/^\//, '')).collection('states')
  @state = @states.find_one || { 'open' => 'false' }
end

get '/' do
  haml :index
end

get '/json' do
  erb :json, :content_type => 'application/json'
end

get '/open' do
  @state['open'] = 'true'
end

get '/close' do
  @state['open'] = 'false'
end

after do
  @states.save @state
  @mongo.close
end
