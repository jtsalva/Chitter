require 'sinatra/base'

require_relative 'lib/config'
require_relative 'lib/store'
require_relative 'lib/user'
require_relative 'lib/peep'

CONFIG_PATH = '/Users/jaetimothysalva/projects/chitter/config.json'

config = Config.new(CONFIG_PATH)
config.init_prod_credentials

Store.init config.prod_project_id

class Chitter < Sinatra::Base
	enable :sessions

	get '/' do
		@user = session[:user]
		p @peeps = Peep.all
		erb :index
	end

	post '/new-peep' do
		user = session[:user]
		if user.nil?
			redirect '/sign-in'
		end

		new_peep = Peep.new(text: params[:text], author: user.username)
		Peep.add(new_peep)
		redirect '/'
	end

	get '/sign-in' do
		unless session[:user].nil?
			redirect '/'
		end
		erb :sign_in
	end

	post '/sign-in' do
		user = User.authenticate(params[:username], params[:password])
		if user
			session[:user] = user
			redirect '/'
		else
			redirect '/sign-in'
		end
	end

	get '/sign-out' do
		session[:user] = nil
		redirect '/'
	end

	get '/register' do
		erb :register
	end

	post '/register' do
		new_user = User.new(
			username: params[:username],
			name: params[:name],
			email: params[:email]
		)

		User.add(new_user)
		User.set_password(new_user, params[:password])

		session[:user] = new_user

		redirect '/'
	end
end