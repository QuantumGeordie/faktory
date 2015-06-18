require 'sinatra/base'

module Fakes
  class FakeBlank < Sinatra::Base
    @@counter = 0
    @@status  = 200
    @@key     = 'geordie'
    @@value   = 'counter'
    @magic = ''

    def self.set_counter(cnt)
      @@counter = cnt
    end

    def magic_instance_method
      ## This instance method must be accessed like "fake_blank.instance_variable_get(:@instance).magic_instance_method"
      @magic = 'use the magic'
    end

    get '/api/:key/:value' do
      @@counter += 1
      key   = @@key.upcase == 'BYPASS' ? params[:key] : @@key
      value = case @@value
                when 'bypass', 'BYPASS'
                  params[:value]
                when 'counter'
                  "count_#{@@counter}"
                else
                  @@value
              end

      content_type :json
      status @@status
      "{\"key\" : \"#{key}\", \"value\" : \"#{value}#{@magic}\"}"
    end

    get '/config/set_status/:status/?' do
      @@status = params[:status]
      content_type :json
      status @@status
      "status set to #{@@status}"
    end

    get '/config/set_key/:key' do
      @@key = params[:key]
      "key set to #{@@key}"
    end

    get '/config/set_value/:value' do
      @@value = params[:value]
      "value set to #{@@value}"
    end
  end
end
