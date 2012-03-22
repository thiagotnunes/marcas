Feature: Ordering a Trademark
  In order to request a new trademark
  As a customer
  I want to order a trademark

  Background:
    Given an activated customer "customer"
    And I am on the home page
    And I am logged in as "customer"

  Scenario: Create a trademark order
    When I go to the new trademark order page
    And I create an order trademark with the following attributes
      | name      | segment     | subsegment    | observations  |
      | Trademark | Segmento 1  | Subsegmento 1 | Obs.          |
    Then I should see "Trademark"
    And I should see "Segmento 1"
    And I should see "Subsegmento 1"
    And I should see "Obs."
