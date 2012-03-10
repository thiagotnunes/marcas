Feature: Login
  In order to gain access to the system
  As a customer
  I want to be able to signup to the site and login

  Background:
    Given I am on the home page

  Scenario: Signup
    When I signup
    Then I should receive a notification to activate my user

  Scenario: Activating an user
    Given I signup
    When I activate my account
    Then my account should be active

  Scenario: Login
    Given I signup
    And I activate my account
    When I login
    Then I should be logged in

  Scenario: Forgot password
    Given I signup
    And I activate my account
    When I forgot my password
    Then I should receive reset password instructions in my email 
    And I should be able to reset my password to "newPassword"
    And I should be able to login with "newPassword"
    And I should be logged in
