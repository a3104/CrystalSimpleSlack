require "http/client"

module SimpleSlack
  class ChannelList
    @token : String
    @base_url = "https://slack.com/api/channels.list"
    @body : JSON::Any
    @channel_id_hash : Hash(String, String)

    def initialize(token : String)
      @token = token
      response = HTTP::Client.get("#{@base_url}?token=#{@token}")
      raise "failed statusCode #{response.status_code} slack list api" unless response.status_code.to_s == "200"
      @body = JSON.parse(response.body)
      @channel_id_hash = @body["channels"].as_a.map { |channel| [channel["name"].as_s, channel["id"].as_s] }.to_h
    end

    def get_id_by_name?(channel_name)
      @channel_id_hash[channel_name]?
    end
  end
end
