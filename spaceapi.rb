require 'sinatra'
require 'mongo'

before do
  @mongo = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  uri = URI.parse(ENV['MONGOLAB_URI'])
  @states = @mongo.db(uri.path.gsub(/^\//, '')).collection('states')
  @state = @states.find_one || { 'status' => 'close' }
end

get '/' do
  @state['status']
end

get '/json' do
  @state['status']
end

get '/open' do
  @state['status'] = 'open'
end

get '/close' do
  @state['status'] = 'close'
end

after do
  @states.save @state
  @mongo.close
end
