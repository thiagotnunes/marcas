Feature: Order Types Management
  In order to group certain kinds of services 
  As an administrator
  I want to manage all the order types

  Background:
    Given an activated admin "admin"
    And I am on the home page
    And I am logged in as "admin"

  Scenario: No order types should be displayed
    Given no order type exists
    When I go to the list of order types
    Then I should not see any order types

  Scenario: List all order types
    Given an order type "Marca registrada" exists
    And an order type "Diretos autorais" exists
    When I go to the list of order types
    Then I should see "Marca registrada"
    And I should see "Diretos autorais"

  Scenario: Show an order type
    Given an order type "Marca registrada" exists
    When I go to the list of order types
    And I click on "Marca registrada"
    Then I should see "Marca registrada"

  Scenario: Create an order type
    When I go to the list of order types
    And I create a order type "Marca registrada"
    Then I should see "Marca registrad"

  Scenario: Change an order type
    Given an order type "Marca registrada" exists
    When I go to the list of order types
    And I edit the order type "Marca registrada" to "Direitos autorais"
    Then I should see "Direitos autorais"
    And I should not see "Marca registrada"

  Scenario: Destroy an order type
    Given an order type "Marca registrada" exists
    And an order type "Direitos autorais" exists
    When I go to the list of order types
    And I delete "Marca registrada"
    Then I should not see "Marca registrada"
    But I should see "Direitos autorais"
