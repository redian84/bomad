# PLACEHOLDER FOR PARENT TESTS 

# EXAMPLE OF A FEATURE FILE FOR AUTOMATED TESTING OF BOMAD USING GHERKIN

# This is our user story
Feature: Withdraw money from account
  As a child who needs to access my allowance
  I want to withraw cash from my account
  So that I can buy items

# Our Acceptance Criteria will help us write our tests
  Acceptance Criteria
    - I will see my available balance
    - I am only allowed to withdraw in £5 denominations
    - I cannot withdraw more than my balance
    - I will receive an alert when I have less than £10 in my account
    - I will be prompted if I try to withdraw an amount below £5

Scenario: withdrawing money from an account with sufficient funds
        Given my balance is £100
        When I withdraw £30
        Then I receive £30
        And receive notification "Your balance is £70"

Scenario: withdrawing money from an account with insufficient funds
        Given my balance is £20
        When I withdraw £30
        Then I receive 0
        And receive notification "You have insufficient funds"

# This Scenario tests edge cases through separate steps
Scenario: withdrawing money from account
        Given my balance is £100
        When I withdraw £12
        Then I receive no money
        And receive notification "Please enter an amount in multiples of £5"

        Given my balance is £100
        When I withdraw £29
        Then I receive no money
        And receive notification "Please enter an amount in multiples of £5"›


# This gives consistent context for each test Scenario
Background:
        Given I have logged into my account

# This Scenario tests edge cases
Scenario: withdrawing money from account
        Given my balance is "<balance>"
        When I withdraw "<withdraw>"
        Then I receive "<receive>"
        And my remaining balance is shown as "<remaining>"
        And receive a notification "<alert>"

# A data table can help test lots of variances for the same Scenario
        | balance | withdraw  | receive | remaining | notification |
        | 100     | 31        | 0       | 100       | "Please enter an amount in multiples of 5"  |
        | 100     | 30        | 30      | 70        | "Your balance is £70"                       |
        | 100     | 29        | 0       | 100       | "Please enter an amount in multiples of 5"  |
        | 100     | 110       | 0       | 100       | "You have insufficient funds"               |
