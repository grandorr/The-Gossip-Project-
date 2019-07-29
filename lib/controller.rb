 require 'bundler'
 require 'gossip'
 require 'comment'
 require 'pry'
 Bundler.require

 class ApplicationController < Sinatra::Base 
 	get '/' do
 		erb :index, locals: {gossips: Gossip.all}
 	end

	get '/gossips/new' do 
   	erb :new_gossip
  end

  post '/gossips/new/' do
  Gossip.new(params["gossip_author"],params["gossip_content"]).save
  redirect '/'
	end

	get '/gossips/:id' do

	   # matches "GET /gossips/foo" and "GET /gossips/bar"
	   # params['id'] is 'foo' or 'bar'
   erb :show, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i), comments: Commentaire.all(params["id"])}
	end

	get '/edit/gossip/:id' do
		erb :edit_gossip, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
	end


	post '/gossips/edit/:id' do 
		 Gossip.update(params['id'].to_i,params['gossip_author'], params['gossip_content'])
	redirect '/'
	end

	get '/create/commentaire/:id' do
		erb :create_comment, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
	end


  post '/gossips/comment/new/:id' do 
     Commentaire.new(params["comment"],params["id"],).save
     redirect '/'
   end
end





