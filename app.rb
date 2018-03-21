require 'sinatra'
require 'sinatra/reloader'
enable :sessions

get '/' do
  erb :index
end

post '/add_name' do
  session[:name_array] = Array.new
  session[:name_array]<< params[:new_name]
  redirect '/add_more'
end

get '/add_more' do
  name_list = session[:name_array]

  erb :add_more, locals: {name_list:name_list}
end