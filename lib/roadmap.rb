module Roadmap
    def get_roadmap(roadmap_id)
        response = self.class.get(base_url("roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token })
        @json = JSON.generate(response)
        JSON.parse(@json)
    end
    
    def get_checkpoint(checkpoint_id)
        response = self.class.get(base_url("checkpoints/#{checkpoint_id}"), headers: {"content_type" => 'applicaiton/json', "authorization" => @auth_token })
        @json = JSON.generate(response)
        JSON.parse(@json)
    end
end
