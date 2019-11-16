require 'selenium-webdriver'
require 'net/ssh'

Given(/^I will go to "([^"]*)"/) do |url|
  chromedriver_path = File.join(File.absolute_path('c:/Selenium', File.dirname(__FILE__)),"","chromedriver.exe")
  Selenium::WebDriver::Chrome.driver_path = chromedriver_path
  @driver = Selenium::WebDriver.for :chrome
  @driver.navigate.to url
end

When(/^I send text "([^"]*)"$/) do |text|
  element = @driver.find_element(:id, 'lst-ib').send_keys text, :enter
end

When(/^I saw the "([^"]*)" in the webpage$/) do |textVerification|
  begin
    @wait.until { @driver.find_element(:tag_name => "body").text.include?(textVerification)}
  rescue
    puts "Failure! text is not present on the page"
  end
  @driver.quit
end

