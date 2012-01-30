require 'sinatra'
require 'json'

get '/json' do
  content_type :json 
  {
    :api => '0.11',
    :space => 'miLKlabs',
    :logo => 'http://status.mlkl.bz/logo.png',
    :icon => {
      :open => 'http://status.mlkl.bz/open.png',
      :closed => 'http://status.mlkl.bz/closed.png'
    },
    :url => 'http://milklabs.ie'
  }.to_json
end
