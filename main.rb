require 'pry'
require 'sinatra'
require 'sinatra/reloader'
also_reload 'models/*'
require 'pg'
enable :sessions

require_relative 'models/model.rb'


get '/' do

  weather = todays_weather()
  @weather_symbol_code = weather['weather_symbol_code']
  @min_temp = weather['min_temp']
  @max_temp = weather['max_temp']

  @todays_logs = find_todays_logs()
  @weeks_logs = find_past_week_logs()

  @all_users = find_all_users()

  if logged_in?
    erb :index
    else
      erb :login
  end

end


# USERS ---------------------------------------------

get '/login' do # read login

  erb :login

end

post '/login' do # post login

  email = params[:email]
  password = params[:password]

  user = find_user(email)

  if user != nil
    if BCrypt::Password.new( user["digested_password"]) == password
      session[:user_id] = user["id"]
    else 
      return erb :incorrect_login
  end
    else
      return erb :incorrect_login
  end

  redirect '/'

end

get '/create_user' do # read signup

  erb :signup

end

post '/create_user' do # post signup

  name = params[:name]
  email = params[:email]
  password = params[:password]
  location = params[:location]

  create_user(name, email, password, location)

  redirect '/success'

end

get '/profile_user/:id' do # read profile

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

delete '/logout_user' do
  session[:user_id] = nil
  redirect "/login"
end

get '/success' do # success signup

  erb :success

end

delete '/delete_user' do

  user_id = params[:user_id]
  delete_user(user_id)

  redirect '/login_user'

end

def logged_in?

  return !!current_user

end

def current_user

  user = find_one_user(session[:user_id])

  @user_email = user["email"]
  @user_name = user["name"]

end



# LOGS ---------------------------------------------

post '/create_log' do # post log

  user = find_one_user(session[:user_id])
  user_id = user["id"]
  log = params[:log].gsub("'", "''")
  date = "#{Time.now.day}.#{Time.now.month}.#{Time.now.year}"
  min_temp = params[:min_temp]
  max_temp = params[:max_temp]
  weather_symbol_code = params[:weather_symbol_code]

  create_log(log, date, user_id, min_temp, max_temp, weather_symbol_code)

  redirect '/'

end

delete '/delete_log' do # delete log

  delete_log(params[:id])

  redirect '/'

end

patch '/update_log' do # update log

  update_log(params[:id], params[:log])

  redirect '/profile_user'

end






