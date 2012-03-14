Feature: Login
  In order to gain access to the system
  As a customer
  I want to be able to signup to the site and login

  Background:
    Given I am on the home page
    And an activated customer "john"

  Scenario: Signup
    When I create an user "alice"
    Then I should receive a notification to activate my user

  Scenario: Canceling signup
    Given no user exist
    And I am on the signup page
    When I cancel
    Then no user should exist
    And I should be on the home page

  Scenario: Activating an user
    Given I create an user "alice"
    When I activate my account
    Then I should receive a success activation message
    And the user "alice" should be active

  Scenario: Login
    When I login as "john"
    Then I should be logged in as "john"

  Scenario: Canceling login
    Given I am on the login page
    When I cancel
    Then I should not be logged in
    And I should be on the home page

  Scenario: Login with unactive user
    Given I create an user "alice"
    When I login as "alice"
    Then I should not be logged in

  Scenario: Logout
    Given I am logged in as "john"
    When I log out
    Then I should not be logged in

  Scenario: Forgot password
    Given I go to forgot password page
    And I request a password reset for user "john"
    When I reset my password to "newPassword"
    And I login as "john" with "newPassword"
    Then I should be logged in as "john"

  Scenario: Forgot password should invalidate old password
    Given I go to forgot password page
    And I request a password reset for user "john"
    When I reset my password to "newPassword"
    And I login as "john" with "password"
    Then I should not be logged in

  Scenario: Canceling forgot password
    Given I go to forgot password page
    When I cancel
    Then I should not have received any email
    And I should be on the home page

  Scenario: Change password
    Given I am logged in as "john"
    When I update my password to "newPassword"
    And I log out
    And I login as "john" with "newPassword"
    Then I should be logged in as "john"

  Scenario: Invalid current password when changing password should not logout
    Given I am logged in as "john"
    When I go to change password page
    And I enter an invalid current password
    Then I should receive an error
    But I should be logged in as "john"

