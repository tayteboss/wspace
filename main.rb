require 'sinatra'

if settings.development?
  require 'sinatra/reloader'
  also_reload 'models/*'
  require 'pry'
end

require 'pg'
enable :sessions

require_relative 'models/model.rb'


get '/' do
  redirect '/login' unless logged_in?

  @todays_logs = find_todays_logs()
  @weeks_logs = find_past_week_logs()

  @all_users = find_all_users()

  erb :index
end


# USERS ---------------------------------------------

get '/login' do

  erb :login

end

post '/login' do

  email = params[:email]
  password = params[:password]

  user = find_user(email)

  if user != nil
    if BCrypt::Password.new( user["digested_password"]) == password
      session[:user_id] = user["id"]
      weather = todays_weather()
      session[:weather_symbol_code] = weather['weather_symbol_code']
      session[:min_temp] = weather['min_temp']
      session[:max_temp] = weather['max_temp']
    else 
      return erb :incorrect_login
  end
    else
      return erb :incorrect_login
  end

  redirect '/'

end

get '/create_user' do

  erb :signup

end

post '/create_user' do

  name = params[:name]
  email = params[:email]
  password = params[:password]
  location = params[:location]

  create_user(name, email, password, location)

  redirect '/success'

end

get '/profile_user/:id' do
  redirect '/login' unless logged_in?

  user = find_one_user(params[:id])

  weather = todays_weather()
  @weather_symbol_code = weather['weather_symbol_code']
  @min_temp = weather['min_temp']
  @max_temp = weather['max_temp']
  
  @indi_logs = count_individual_logs(user["id"]).first

  @user_name = user["name"]
  @user_email = user["email"]
  @user_id = user["id"]

  @users_logs = find_user_logs(@user_id)
  @all_users = find_all_users()

  erb :profile
  
end

get '/edit_user' do

  @user = find_one_user(session[:user_id])
  erb :edit_user

end

patch '/edit_user' do

  name = params[:name]
  email = params[:email]
  password = params[:password]
  location = params[:location]
  user_id = session[:user_id]

  edit_user(name, email, password, location, user_id)

  redirect '/'

end

delete '/logout_user' do
  redirect '/login' unless logged_in?

  session[:user_id] = nil
  redirect "/login"
end

get '/success' do

  erb :success

end

delete '/delete_user' do
  redirect '/login' unless logged_in?

  user_id = params[:user_id]
  delete_user(user_id)

  redirect '/login'

end

def logged_in?

  return !!current_user

end

def current_user

  find_one_user(session[:user_id])

end



# LOGS ---------------------------------------------

post '/create_log' do
  redirect '/login' unless logged_in?

  user = find_one_user(session[:user_id])
  user_id = user["id"]
  log = params[:log].gsub("'", "''")
  date = Time.now
  min_temp = params[:min_temp]
  max_temp = params[:max_temp]
  weather_symbol_code = params[:weather_symbol_code]

  create_log(log, date, user_id, min_temp, max_temp, weather_symbol_code)

  redirect '/'

end

delete '/delete_log' do
  redirect '/login' unless logged_in?

  delete_log(params[:id])
  user_id = params[:user_id]

  redirect '/' unless !!user_id

  redirect "/profile_user/#{user_id}"

end

patch '/update_log' do
  redirect '/login' unless logged_in?

  update_log(params[:id], params[:log])

  redirect '/profile_user'

end






