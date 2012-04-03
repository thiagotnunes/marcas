Feature: Ordering a Trademark
  In order to request a new trademark
  As a customer
  I want to order a trademark

  Background:
    Given an activated customer "customer"
    And I am on the home page
    And I am logged in as "customer"
    And an order type "Marcas" exists
    And a service "service" with price "100" and type "Marcas" exists
    And a first order status "pending" exists

  Scenario: Create a trademark order
    When I go to the new trademark order page
    And I create an order trademark with the following attributes
      | name      | segment     | subsegment    | observations  | service |
      | Trademark | Segmento 1  | Subsegmento 1 | Obs.          | service |
    Then I should see "Trademark"
    And I should see "Segmento 1"
    And I should see "Subsegmento 1"
    And I should see "Obs."
    And I should see "service"
    And I should see "pending"
    And I should see a payment message

  Scenario: List my own trademark orders
    Given an activated customer "another"
    And the following trademark orders exist
      | name  | segment   | subsegment  | observations  | user      | service | order_status |
      | Trade | Segmento  | Subsegmento | Observacoes   | customer  | service   | pending |
      | Right | Law       | Sublaw      | Hurry         | customer  | service   | pending |
      | Not Mine | Law       | Sublaw      | Hurry         | another | service   | pending |
    When I go to the list of trademark orders 
    Then I should see "Trade"
    And I should see "Right"
    But I should not see "Not mine"

    @wip
  Scenario: Pay for a trademark order
    When I go to the new trademark order page
    And I create an order trademark with the following attributes
      | name      | segment     | subsegment    | observations  | service |
      | Trademark | Segmento 1  | Subsegmento 1 | Obs.          | service |
    And I pay for it
    Then I should see "Trademark"
    And I should see "payed" 
