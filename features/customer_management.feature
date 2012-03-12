Feature: Customer management
  In order to follow up with usage of the system
  As a administrator
  I want to manage all the customer

  Background:
    Given I am a logged in administrator

  @focus
  Scenario: List all the customer
    Given a customer "thiago" exists
    And a customer "carol" exists
    And a administrator "tarik" exists
    When I go to the list of customers
    Then I should see "thiago"
    And I should see "carol"
    And I should not see "tarik"
