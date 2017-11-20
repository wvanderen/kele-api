require 'rubygems'
require 'httparty'
require 'json'
require './lib/roadmap.rb'
require './lib/messages.rb'

class Kele
    include HTTParty
    include Roadmap
    include Messages

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
    
    def get_mentor_availability(mentor_id)
        response = self.class.get(base_url("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token })
        @json = JSON.generate(response)
        JSON.parse(@json)
    end
    
    def create_message(sender, recipient_id, subject, text)
        response = self.class.post(base_url("messages"), body: {"user_id": sender, "recipient_id": recipient_id, "subject": subject, "stripped-text": text}, headers: { "authorization" => @auth_token })
        puts response

    end

    private
    
    def base_url(end_point)
        "https://www.bloc.io/api/v1/#{end_point}"
    end

end