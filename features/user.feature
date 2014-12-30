Feature: User Accounts
    In order to allows multiple people to use my web application
    As a developer
    I want have my users create and manage their own accounts
    
Scenario: User Creation
    Given I am on the "new user" page
    When I create a new user
    Then I should see user creation successful page for the new user