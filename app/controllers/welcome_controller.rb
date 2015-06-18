class WelcomeController < ApplicationController
  require 'rest-client'

  def index
  end

  def blank_app
    key = rand(999).to_s
    val = (0...8).map { (65 + rand(26)).chr }.join

    @results = send_something(key, val)
  end

  private

  def send_something(key, value)
    send_string = "http://localhost:9292/api/#{key}/#{value}"

    begin
      RestClient.get(send_string, {"X-Requested-With" => "XMLHttpRequest"}).to_s
    rescue => e
      e.to_s
    end
  end
end
