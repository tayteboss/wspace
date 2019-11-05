     
require 'sinatra'
require 'pg'
require 'bcrypt'

def run_sql(sql)

    conn = PG.connect( ENV['DATABASE_URL'] || {dbname: "wspace"} )
    records = conn.exec(sql)
    conn.close
    return records

end

# USERS ---------------------------------------------

def create_user(name, email, password, location)

    password_digest = BCrypt::Password.create(password)
    return run_sql("insert into users (email, name, digested_password, location) values ('#{email}', '#{name}', '#{password_digest}', '#{location}')")

end

def find_user(email)

    return run_sql("select * from users where email = '#{email}'").first

end

def find_one_user(id)

    return nil unless id
    return run_sql("select * from users where id = #{id}").first

end




# LOGS ---------------------------------------------

def create_log(log, date, user_id)

    weather = todays_weather()

    weather_symbol_code = weather['weather_symbol_code']
    min_temp = weather['min_temp']
    max_temp = weather['max_temp']

    return run_sql("insert into logs (log, date, weather, min_temp, max_temp, user_id)
        values ('#{log}', '#{date}', '#{weather_symbol_code}', '#{min_temp}', '#{max_temp}', '#{user_id}')")

end

def delete_log(log_id)

    log = find_one_log(log_id)
    return run_sql("delete from logs where id = #{log_id}")

end

def update_log(log_id, log_text)

    log = find_one_log(log_id)
    return run_sql("update logs set log = '#{log_text}' where id = '#{log_id}'")

end

def find_one_log(log_id)

    return run_sql("select * from logs where id = #{log_id}")

end

def find_user_logs(user_id)

    return run_sql("select * from logs where user_id = #{user_id}")

end




# OTHERS ---------------------------------------------

def todays_weather

    weather = {
        'weather_symbol_code' => rand(1..4),
        'min_temp' => rand(7..15),
        'max_temp' => rand(16..40)
    }

    return weather

end
