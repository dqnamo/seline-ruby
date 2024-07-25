require "seline/version"
require 'net/http'
require 'uri'
require 'json'

module Seline
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def track(event_name, user_id: nil, properties: {})
      payload = {
        name: event_name,
        userId: user_id,
        properties: properties
      }.compact

      send_request('/s/e', payload)
    end

    def set_user(user_id, properties = {})
      payload = {
        userId: user_id,
        properties: properties
      }

      send_request('/s/su', payload)
    end

    private

    def send_request(endpoint, payload)
      raise 'Seline is not configured' if configuration.nil? || configuration.token.nil?

      uri = URI.join(configuration.api_host, endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      request.body = { token: configuration.token }.merge(payload).to_json

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "API request failed: #{response.code} #{response.message}"
      end

      JSON.parse(response.body)
    rescue => e
      puts "Error: #{e.message}"
      raise
    end
  end

  class Configuration
    attr_accessor :token, :api_host

    def initialize
      @api_host = 'https://api.seline.so'
    end
  end
end