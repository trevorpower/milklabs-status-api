require 'sinatra'
require 's3'

def publish(name, content)
  service = S3::Service.new(
    :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
  )
  bucket = service.buckets.find('milklabs-status')
  new_status = bucket.objects.build(name)  
  new_status.content_type = 'application/json'
  new_status.access_control_allow_origin = '*'
  new_status.content_type = 'application/json'
  new_status.cache_control = 'no-cache'
  new_status.content = content
  new_status.save
end
