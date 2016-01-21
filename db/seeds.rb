# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')



# user password: "barcelona12"
User.create!(id: 1, email: "martinezcoder@gmail.com", password: "barcelona12",
            reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: nil,
            last_sign_in_at: nil, current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: "f7874983e42f05b706c04e1422e81545d08b77e79dd77396a117213066977f4a",
            confirmed_at: Time.now, confirmation_sent_at: Time.now, unconfirmed_email: nil, name: "Fran", last_name: "Martinez",
            country: "AF", created_at: Time.now, updated_at: Time.now)
