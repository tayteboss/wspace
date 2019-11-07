require 'pg'
require_relative '../models/model'

userName = [
    {:name => 'Tayte Boss', :email => 'tayte@email.com'},
    {:name => 'Chai Ng', :email => 'chai@email.com'},
    {:name => 'Kait Walsh', :email => 'kait@email.com'},
    {:name => 'Emile Desfontaines', :email => 'emile@email.com'},
    {:name => 'Kasun Maldeni', :email => 'kasun@email.com'},
    {:name => 'Nikki Ricks', :email => 'nikki@email.com'},
]
password = 'password'
location = ['Melbourne', 'Sydney', 'Tasmania', 'Gold Coast', 'Perth']

userName.each do |user|
    create_user("#{user[:name]}", "#{user[:email]}", 'password', "#{location.sample}")
end




logs = [
    'Pitchfork plaid williamsburg lumbersexual milkshake umami thundercats messenger bag tacos.',
    'narwhal tattooed crucifix direct trade single-origin coffee umami master cleanse hammock 8-bit.',
    'Crucifix distillery aesthetic offal drinking vinegar gentrify migas cloud bread sartorial meditation.',
    'Fanny pack fam aesthetic, VHS man braid hashtag glossier listicle ethical taxidermy distillery keytar.',
    'Stumptown sustainable vinyl, small batch raw denim leggings before they sold out cornhole tilde pinterest jean shorts.',
    'Aesthetic chia neutra, leggings chartreuse master cleanse vegan taxidermy readymade pop-up meh.',
    'Gluten-free 3 wolf moon meditation, ethical migas meggings portland live-edge shoreditch locavore ramps occupy irony.',
]

20.times do 

    weather = {
        'weather_symbol_code' => rand(1..4),
        'min_temp' => rand(7..15),
        'max_temp' => rand(16..40),
        # 'date' => "#{rand(1..29)}:#{rand(1..10)}:#{Time.now.year}"
        'date' => "#{Time.now.day}:#{Time.now.month}:#{Time.now.year}"
    }
    
    weather_symbol_code = weather["weather_symbol_code"]
    min_temp = weather["min_temp"]
    max_temp = weather["max_temp"]
    date = weather["date"]
    log = logs.sample
    rand_user_id = random_user().first["id"]

    create_log(log, date, rand_user_id, min_temp, max_temp, weather_symbol_code)
    
end