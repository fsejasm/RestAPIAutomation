Feature: API testing
  Scenario: Small sample for demo the Request and Response
    Given When I make a get in "/2.2/users?site=stackoverflow"
    When it should return a response with a 200 response code
    Then it's body must contain the value "items" within the "1" for "badge_counts" with "bronze" done with "3556"

  Scenario: Small sample for demo the Request and Response
    Given When I make a post in "v2/auth?username=my&password=password"
    When it should return a response with a 404 response code