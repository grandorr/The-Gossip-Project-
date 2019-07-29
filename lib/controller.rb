 require 'bundler'
 require 'gossip'
 require 'comment'
 require 'pry'
 Bundler.require

 class ApplicationController < Sinatra::Base 
 	get '/' do  # Page d'acceuil ( / ) #
 		erb :index, locals: {gossips: Gossip.all}
 	end

	get '/gossips/new' do 
   	erb :new_gossip  # Vas sur la page new_gossip #
  end

  post '/gossips/new/' do
  Gossip.new(params["gossip_author"],params["gossip_content"]).save  # Enregistre le nouveau gossip dans le CSV
  redirect '/'
	end

	get '/gossips/:id' do     # Vas sur la page show en fonction de l'id du gossip # 
   erb :show, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i), comments: Commentaire.all(params["id"])}   
	end

	get '/edit/gossip/:id' do  # Vas sur la page edit_gossip en fonction de l'id du gossip #
		erb :edit_gossip, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
	end


	post '/gossips/edit/:id' do  # Met a jour le CSV en modifiant un Gossip ( autheur, contenue )
		 Gossip.update(params['id'].to_i,params['gossip_author'], params['gossip_content'])
	redirect '/'
	end

	get '/create/commentaire/:id' do   # Vas sur la page create_comment en fonction de l'id du gossip #
		erb :create_comment, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
	end


  post '/gossips/comment/new/:id' do   # Crée un commentaire et l'enregistre dans un fichier CSV #
     Commentaire.new(params["comment"],params["id"],).save
     redirect '/'
   end
end





