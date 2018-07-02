require "./simpleSlack/*"
require "http/client"
require "json"

# TODO: Write documentation for `SimpleSlack`

module SimpleSlack
  enum NotifyLevel
    NONE
    GOOD
    WARNING
    DANGER
  end

  class Notifier
    @@NotifyLevelStr = ["", "good", "warning", "danger"]

    def initialize(@incomming_hook_url : String)
    end

    def send(channel, username, msg, icon, notify_level : (NotifyLevel | String) = NotifyLevel::NONE)
      json = create_message_json(channel, username, msg, icon, notify_level)
      p "payload=#{json}"
      headers = HTTP::Headers.new
      headers["Content-type"] = "application/x-www-form-urlencoded"
      p HTTP::Client.post(@incomming_hook_url, body: "payload=#{json}", headers: headers)
    end

    def create_message_json(channel, username, msg, icon, notify_level : (NotifyLevel | String) = NotifyLevel::NONE)
      hash = Hash(String, String).new
      hash["channel"] = channel
      hash["username"] = username
      hash["text"] = msg
      hash["icon_emoji"] = icon

      if notify_level.is_a?(NotifyLevel) && notify_level != NotifyLevel::NONE
        hash["color"] = @@NotifyLevelStr[notify_level.value]
      end

      if notify_level.is_a?(String) && notify_level != ""
        hash["color"] = notify_level
      end

      hash.to_json
    end
  end
end
