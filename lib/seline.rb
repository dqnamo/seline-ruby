require "seline/version"
require 'net/http'
require 'uri'
require 'json'
require 'byebug'

module Seline
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def track(event: nil, user_id: nil, properties: {})
      # If event of user_id is nil, raise an error
      raise 'Event must be provided' if event.nil?
      raise 'User ID must be provided' if user_id.nil?

      payload = {
        name: event,
        userId: user_id
      }.compact

      send_request('/s/e', payload)
    end

    def set_user(user_id: nil, email: nil, properties: {})
      raise 'User ID must be provided' if user_id.nil?
      raise 'Email must be provided' if email.nil?
      # raise 'Properties must be provided' if properties.nil?

      payload = {
        fields: properties.merge({
          'userId': user_id,
          'email': email
        })
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
        error_body = JSON.parse(response.body) rescue nil
        error_message = error_body && error_body['error'] ? error_body['error'] : response.message
        raise "API request failed: #{response.code} #{error_message}\nPayload: #{payload.inspect}"
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