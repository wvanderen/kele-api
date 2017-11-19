require 'rubygems'
require 'httparty'

class Kele
    include HTTParty

    def initialize (email, password)

        response = self.class.post(base_url("sessions"),
        body:  {
            'email': email,
            'password': password
        })
        puts "Error: Invalid Credentials" if response.code == 401
        @auth = response["auth_token"]
        
        puts @auth
    end
    
    private
    
    def base_url(end_point)
        "https://www.bloc.io/api/v1/#{end_point}"
    end

end