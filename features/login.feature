Feature: Login
  In order to gain access to the system
  As a customer
  I want to be able to signup to the site and login

  Background:
    Given I am on the home page

  Scenario: Signup
    When I signup
    Then I should receive a notification to activate my user

  Scenario: Canceling signup
    Given I am on the signup page
    When I cancel
    Then I should not be registered
    And I should be on the home page

  Scenario: Activating an user
    Given I signup
    When I activate my account
    Then my account should be active

  Scenario: Login
    Given I am an existing customer "john"
    When I login
    Then I should be logged in

  Scenario: Canceling login
    Given I am an existing customer "john"
    And I am on the login page
    When I cancel
    Then I should not be logged in
    And I should be on the home page

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
    And I forgot my password
    And I go to reset password page
    When I reset my password to "newPassword"
    And I login with "newPassword"
    Then I should be logged in

  Scenario: Forgot password should invalidate old password
    Given I am an existing customer "john"
    And I forgot my password
    And I go to reset password page
    When I reset my password to "newPassword"
    And I login with "password"
    Then I should not be logged in

  Scenario: Canceling forgot password
    Given I am on the forgot password page
    When I cancel
    Then I should not have received any email
    And I should be on the home page

  Scenario: Change password
    Given I am a logged in customer
    When I update my password to "newPassword"
    And I log out
    And I login with "newPassword"
    Then I should be logged in

  Scenario: Invalid current password when changing password should not logout
    Given I am a logged in customer
    When I am on the change password page
    And I miss my current password
    Then I should receive an error
    And I should be logged in

