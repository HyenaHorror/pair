require 'sinatra'
require 'sinatra/reloader'
require_relative 'pair.rb'
enable :sessions


get '/' do
  session[:name_array] = Array.new
  erb :index
end

post '/add_name' do
  session[:name_array].push params[:new_name]
  redirect '/add_more'
end

get '/add_more' do
  name_list = session[:name_array]
  erb :add_more, locals: {name_list:name_list}
end

post '/make_pairs' do
  pair_list = pairing(*session[:name_array])
  erb :display_pairs, locals: {pair_list:pair_list}
end
