Feature: Trademark order management
  In order fullfill the register a customer trademark
  As an administrator
  I want to manage all the trademark orders

  Background:
    Given an activated admin "admin"
    And I am on the home page
    And I am logged in as "admin"
    And the following trademark orders exist
      | name  | segment   | subsegment  | observations  |
      | Trade | Segmento  | Subsegmento | Observacoes   |
      | Right | Law       | Sublaw      | Hurry         |

  Scenario: List all the trademark orders
    When I go to the list of trademark orders
    Then I should see "Trade"
    And I should see "Segmento"
    And I should see "Subsegmento"
    And I should see "Right"
    And I should see "Law"
    And I should see "Sublaw"
    But I should not see "Observacoes"
    And I should not see "Hurry"

  Scenario: Show a trademark order
    When I go to the list of trademark orders
    And I click on "Right"
    Then I should see "Right"
    And I should see "Law"
    And I should see "Sublaw"
    And I should see "Hurry"

  Scenario: No trademark order should be displayed
    Given no trademark order exists
    When I go to the list of trademark orders
    Then I should not see any trademark orders
