require 'sinatra'
# require 'sinatra/reloader'
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
  pair_list = pairing(*session[:name_array]) # TODO: Revise this shitty section.
  session[:pair_list] = pair_list #Must set to session variable for next step.
  erb :display_pairs, locals: {pair_list:pair_list}
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

    reroll_pairs = pairing(*reroll_pairs.flatten) #Rerolls new pairs

    reroll_pairs.each do |x|
      session[:pair_list] << x
    end
  end
  erb :display_pairs, locals: {pair_list:session[:pair_list]}
end

post '/startover' do
  redirect '/'
end
