require 'rubygems'
require 'sinatra'
require 'hominid'

configure do
  # API Key Stuff
  set :mailchimp_api_key, "f36ec720a12f3f66a04878caa5badc25-us6" #It's okay for this key to be on Github, stalkers.
  set :mailchimp_list_name, "Test"
end

get '/' do
 erb :index
end

get '/gigya' do
 erb :gigya
end

get '/gigyaView' do
 erb :gigyaView
end

#Subcribe to MailChimp "Test" list @TrueniTo
post '/signup' do
  email = params[:email]
  #Realiza la acción de abajo al menos que el email esté vacio.
  unless email.nil? || email.strip.empty?
    mailchimp = Hominid::API.new(settings.mailchimp_api_key)
    list_id = mailchimp.find_list_id_by_name(settings.mailchimp_list_name)
    raise "No se pudo sacar el ID de la lista por el nombre." unless list_id
    mailchimp.list_subscribe(list_id, email, {}, 'html', false, true, true, false)
  end
  "NICE"
end

#Unsubscribe to MailChimp "Test" list @TrueniTo
#post '/unsubscribe' do
#  email = params[:email]
#    mailchimp = Hominid::API.new(settings.mailchimp_api_key)
#    list_id = mailchimp.find_list_id_by_name(settings.mailchimp_list_name)
#    listUnsubscribe("f36ec720a12f3f66a04878caa5badc25-us6", list_id, email, false, false, false)
#  "Unsubscribe"
#end
