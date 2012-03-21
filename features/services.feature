Feature: Services Management
  In order to make services available to customers
  As an administrator
  I want to manage all the services

  Background:
    Given an activated admin "admin"
    And I am on the home page
    And I am logged in as "admin"
    And an order type "Marca registrada" exists

  Scenario: No services should be displayed
    Given no service exists
    When I go to the list of services
    Then I should not see any services

  Scenario: List all services
    Given a service "Registro de anterioridade" with price "50.00" exists
    And a service "Registro de logotipo" with price "30.00" exists
    When I go to the list of services
    Then I should see "Registro de anterioridade"
    And I should see "R$ 50,00"
    And I should see "Registro de logotipo"
    And I should see "R$ 30,00"

  Scenario: Show a service
    Given a service "Registro de anterioridade" with price "100.00" exists
    When I go to the list of services
    And I click on "Registro de anterioridade"
    Then I should see "Registro de anterioridade"
    And I should see "R$ 100,00"

  Scenario: Create a service
    When I go to the list of services
    And I create a service "Registro de anterioridade" with price "100.00" and type "Marca registrada"
    Then I should see "Registro de anterioridade"

  Scenario: Change a service
    Given a service "Registro de anterioridade" with price "20.00" and type "Marca registrada" exists
    And an order type "Direitos autorais" exists
    When I go to the list of services
    And I edit the service "Registro de anterioridade" to "Registro de logotipo" with price "300.00" and type "Direitos autorais"
    Then I should see "Registro de logotipo"
    And I should see "R$ 300,00"
    And I should see "Direitos autorais"
    But I should not see "Registro de anterioridade"
    And I should not see "20,00"
    And I should not see "Marca registrada"

  Scenario: Destroy an service
    Given a service "Registro de anterioridade" with price "10.00" exists
    And a service "Registro de logotipo" with price "30.00" exists
    When I go to the list of services
    And I delete "Registro de anterioridade"
    Then I should not see "Registro de anterioridade"
    And I should not see "R$ 10,00"
    But I should see "Registro de logotipo"
    And I should see "R$ 30,00"
