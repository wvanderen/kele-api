require 'rubygems'
require 'httparty'
require 'json'

class Kele
    include HTTParty

    def initialize (email, password)

        response = self.class.post(base_url("sessions"),
        body:  {
            'email': email,
            'password': password
        })
        puts "Error: Invalid Credentials" if response.code == 401
        @auth_token = response["auth_token"]
        
        puts @auth_token
    end
    
    def get_me
        response = self.class.get(base_url("users/me"), headers: { "authorization" => @auth_token })
        @json = JSON.generate(response)
        JSON.parse(@json)
    end
        
    
    private
    
    def base_url(end_point)
        "https://www.bloc.io/api/v1/#{end_point}"
    end

end