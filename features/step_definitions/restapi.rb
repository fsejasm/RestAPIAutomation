Then(/^I will perform query in the page$/) do
  dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
  require File.join(dir, 'httparty')
  require 'pp'

  class StackExchange
    include HTTParty
    base_uri 'api.stackexchange.com'

    def initialize(service, page)
      @options = { query: { site: service, page: page } }
    end

    def get
      # Sample1
      @response = HTTParty.get("http://itunes.apple.com/search",
                              {query: {term: 'tame impala'}, format: :json})
      puts @response['results']
      puts @response['results'][0]['trackName']

      # Sample2
      @response2 = HTTParty.get("http://api.stackexchange.com/2.2/users?site=stackoverflow")
      puts @response2["items"][1]["badge_counts"]["bronze"]
    end

    def questions
      self.class.get("/2.2/questions", @options)
    end

    def users
      self.class.get("/2.2/users", @options)
    end
  end

  stack_exchange = StackExchange.new("stackoverflow", 1)
  pp stack_exchange.get
  pp stack_exchange.questions
  pp stack_exchange.users


end

Given(/^When I make a get in "([^"]*)"$/) do |route|
  @response = HTTParty.get("http://api.stackexchange.com/#{route}")
end

When(/^it should return a response with a (\d+) response code$/) do |code|
  expect(@response.code).to eql(code.to_i)
end

Then(/^it's body must contain the value "([^"]*)" within the "([^"]*)" for "([^"]*)" with "([^"]*)" done with "([^"]*)"$/) do |item, value, badge, bronze, expected|
  @resp = @response["items"][1]["badge_counts"]["bronze"].to_s
  # puts @response["items"][1]["badge_counts"]["bronze"]
  expect( @resp ).to eql(expected)
end