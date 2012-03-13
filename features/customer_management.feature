Feature: Customer management
  In order to follow up with usage of the system
  As a administrator
  I want to manage all the customer

  Background:
    Given I am a logged in administrator

  Scenario: List all the customers
    Given a customer "thiago" exists
    And a customer "carol" exists
    And a administrator "tarik" exists
    When I go to the list of customers
    Then I should see "thiago"
    And I should see "carol"
    But I should not see "tarik"

  Scenario: Destroy a customer
    Given a customer "thiago" exists
    And a customer "carol" exists
    When I go to the list of customers
    And I delete "thiago"
    Then I should not see "thiago"
    But I should see "carol"

  Scenario: No customer should be displayed
    Given no customer exists
    When I go to the list of customers
    Then I should see "No customers available."
