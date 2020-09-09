# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'omniauth'
require 'omniauth/strategies/indieauth'

module Demo
  # The demo application.
  class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    enable :sessions

    use OmniAuth::Builder do
      provider :indieauth
    end

    get '/' do
      erb :index
    end

    get '/login' do
      erb :login
    end

    post '/login' do
      me = URI.encode_www_form_component(params[:me])
      redirect to("/auth/indieauth?me=#{me}")
    end

    get '/logout' do
      session[:me] = nil
      redirect to('/')
    end

    get '/auth/indieauth/callback' do
      auth = request.env['omniauth.auth']
      session[:me] = auth['uid']
      session[:profile] = auth['info']
      redirect to('/')
    end
  end
end
