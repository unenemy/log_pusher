require "rubygems"
require "filewatch/tail"
require "net/http"
require "active_support"

class Watcher
  def initialize(filename)
    Thread.new do
      t = FileWatch::Tail.new
      t.tail(filename)
      t.subscribe do |path, line|
        message = {:channel => "/messages/new", :data => line}
        uri = URI.parse("http://localhost:9292/faye")
        Net::HTTP.post_form(uri, :message => message.to_json) if line.present?
      end
    end
  end
end