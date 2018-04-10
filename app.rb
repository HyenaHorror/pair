require 'sinatra'
# require 'sinatra/reloader'
require_relative 'pair.rb'
enable :sessions


get '/' do
  erb :index
end

post '/make_pairs' do
  pair_list = Array.new
  pair_list = pairing(params[:new_name])
  session[:pair_list] = pair_list #Must set to session variable for next step.
  redirect '/display_pairs'
end

get '/display_pairs' do
  erb :display_pairs, locals: {pair_list: session[:pair_list]}
end

post '/reroll' do
  reroll_indicies = Array.new
  reroll_pairs = Array.new
  if params[:reroll].class != NilClass
    reroll_indicies = params[:reroll].reverse.map(&:to_i) #Converts param strings into integers.


    reroll_indicies.each do |pair|
      #Take indicies from list and bulid new array. Reroll them. Then push back into original array.
      reroll_pairs << session[:pair_list][pair].flatten
      session[:pair_list].delete_at(pair) #remove current iteration from original list
    end

    reroll_pairs = pairing(reroll_pairs.flatten) #Rerolls new pairs

    reroll_pairs.each do |x|
      session[:pair_list] << x
    end
  end
  redirect '/rerolled'
end

get '/rerolled' do
  erb :display_pairs, locals: {pair_list:session[:pair_list]}
end

post '/startover' do
  redirect '/'
end

get '/helloworld' do
  erb :helloworld
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end
