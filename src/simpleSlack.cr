require "./simpleSlack/*"
require "http/client"
require "json"
require "uri"

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
      headers = HTTP::Headers.new
      headers["Content-type"] = "application/x-www-form-urlencoded"
      HTTP::Client.post(@incomming_hook_url, body: "payload=#{json}", headers: headers)
    end

    def create_message_json(channel, username, msg, icon, notify_level : (NotifyLevel | String) = NotifyLevel::NONE)
      hash = Hash(String, (String | Array(Hash(String, String)))).new
      hash["channel"] = channel
      hash["username"] = username

      if notify_level.is_a?(NotifyLevel) && notify_level != NotifyLevel::NONE
        hash["attachments"] = [{"color" => @@NotifyLevelStr[notify_level.value], "title" => username, "pretext" => username, "text" => URI.escape(msg), "author_icon" => icon}]
        return hash.to_json
      end

      if notify_level.is_a?(String) && notify_level != ""
        hash["attachments"] = [{"color" => notify_level, "title" => username, "pretext" => username, "text" => URI.escape(msg), "author_icon" => icon}]
        return hash.to_json
      end

      hash["text"] = URI.escape(msg)
      hash["icon_emoji"] = icon

      return p hash.to_json
    end
  end
end
