require "http/client"

module SimpleSlack

  class PrivateChannelHistory
    @token : String
    @base_url = "https://slack.com/api/groups.history"

    def initialize(token : String)
      @token = token
    end

    def get_message(channel_id : String, count = 1000, from = 0, to = Time.new.to_unix_ms / 1000)
      url = "#{@base_url}?token=#{@token}&channel=#{channel_id}&count=#{count}&oldest=#{from}&latest=#{to}&pretty=1"
      response = HTTP::Client.get(url)
      raise "failed statusCode #{response.status_code} slack PrivateChannelHistory api" unless response.status_code == 200
      JSON.parse(response.body)
    end
  end

  class ChannelHistory
    @token : String
    @base_url = "https://slack.com/api/channels.history"

    def initialize(token : String)
      @token = token
    end

    def get_message(channel_id : String, count = 1000, from = 0, to = Time.new.to_unix_ms / 1000)
      url = "#{@base_url}?token=#{@token}&channel=#{channel_id}&count=#{count}&oldest=#{from}&latest=#{to}&pretty=1"
      response = HTTP::Client.get(url)
      raise "failed statusCode #{response.status_code} slack channelHistory api" unless response.status_code == 200
      JSON.parse(response.body)
    end
  end
end
