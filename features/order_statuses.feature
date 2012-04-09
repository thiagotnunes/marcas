Feature: Order Statuses Management
  In order to follow up with client's orders
  As an administrator
  I want to manage all the order statuses

  Background:
    Given an activated admin "admin"
    And I am on the home page
    And I am logged in as "admin"

  Scenario: No order status should be displayed
    Given no order status exists
    When I go to the list of order statuses
    Then I should not see any order statuses

  Scenario: List all order statuses
    Given an order status "Aguardando pagamento" exists
    And an order status "Pagamento efetuado" exists
    When I go to the list of order statuses
    Then I should see "Aguardando pagamento"
    And I should see "Pagamento efetuado"

  Scenario: Show an order status
    Given an order status "Aguardando pagamento" exists
    When I go to the list of order statuses
    And I click on "Aguardando pagamento"
    Then I should see "Aguardando pagamento"

  Scenario: Create an order status
    When I go to the list of order statuses
    And I create a order status "Aguardando pagamento", activated "Manual"
    Then I should see "Aguardando pagamento"
    And I should see "Manual"

  Scenario: Change an order status
    Given an order status "Aguardando pagamento" exists
    When I go to the list of order statuses
    And I edit the order status "Aguardando pagamento" to "Pagamento efetuado" with lifecycle "Durante pagamento"
    Then I should see "Pagamento efetuado"
    And I should see "Durante pagamento"
    And I should not see "Aguardando pagamento"
    And I should not see "Manual"

  Scenario: Destroy an order status
    Given an order status "Aguardando pagamento" exists
    And an order status "Pagamento efetuado" exists
    When I go to the list of order statuses
    And I delete "Aguardando pagamento"
    Then I should not see "Aguardando pagamento"
    But I should see "Pagamento efetuado"
