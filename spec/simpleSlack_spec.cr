require "./spec_helper"

include SimpleSlack

describe SimpleSlack do
  # TODO: Write tests

  slack = SimpleSlack::Notifier.new("")

  it "test of create_jeson" do
    slack.create_message_json("#test", "tester", "test", ":ghost").should eq %{{"channel":"#test","username":"tester","text":"test","icon_emoji":":ghost"}}
    slack.create_message_json("#test", "tester", "test", ":ghost", NotifyLevel::GOOD).should eq %{{"channel":"#test","username":"tester","text":"test","icon_emoji":":ghost","color":"good"}}
    slack.create_message_json("#test", "tester", "test", ":ghost", "#ff0000").should eq %{{"channel":"#test","username":"tester","text":"test","icon_emoji":":ghost","color":"#ff0000"}}
  end
end
