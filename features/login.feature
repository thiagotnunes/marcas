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

  Scenario: Login with unactive user
    Given I signup
    When I login
    Then I should not be logged in

  Scenario: Logout
    Given I am a logged in customer
    When I log out
    Then I should not be logged in

  Scenario: Forgot password
    Given I am an existing customer "john"
    When I forgot my password
    And I follow reset password url received by email 
    And I reset my password to "newPassword"
    And I login with "newPassword"
    Then I should be logged in

  Scenario: Resetting password and old password
    Given I am an existing customer "john"
    When I forgot my password
    And I follow reset password url received by email 
    And I reset my password to "newPassword"
    And I login with "password"
    Then I should not be logged in

  Scenario: Change password
    Given I am a logged in customer
    When I update my password to "newPassword"
    And I log out
    And I login with "newPassword"
    Then I should be logged in
