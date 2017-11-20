module Messages
    def get_messages(page_id = nil)
        response = self.class.get(base_url("message_threads"), values: { "page" => page_id }, headers: {"content_type" => 'application/json', "authorization" => @auth_token })
        @json = JSON.generate(response)
        JSON.parse(@json)
    end
    

end