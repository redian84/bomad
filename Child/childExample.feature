# EXAMPLE OF A FEATURE FILE FOR AUTOMATED TESTING OF BOMAD USING GHERKIN

# Gherkin     -   Gherkin is a computer language, written in plain English, using keywords which are then interpreted by Cucumber tests
# Comments    -   A comment in Gherin is denoted by using the # symbol. Any text after this will be ignored by the tests
# Keywords    -   Gherkin keywords are:- Feature, Scenario, Background, Given, When, Then, And, But, Example(s), Scenario Outline
# User story  -   A user story describes what a particular feature should do, from the perspective of the user

Feature: Withdraw money from account
  As a child
  I want to withdraw money from my account
  So that I can spend the money

# Acceptance Criteria are like high level requirements / business rules. We base Acceptance Tests on ACs

  Acceptance Criteria
    - I see my available balance at login
    - I can only withdraw in £5 denominations
    - I cannot withdraw more than my balance

# Acceptance Tests represent instances of your Acceptance Criteria. An Acceptance Criteria may have multiple Acceptance Tests
# Good practice is to put Acceptance Tests in the order of our Acceptance Criteria

Background:
        Given I have logged into my account

Scenario: see my balance
        And my balance is £100
        When I check my balance
        Then see the following message "Your balance is £100"

Scenario: attempt to withdraw money in an incorrect denomination
        And my balance is £100
        When I try to withdraw £12
        Then I receive £0
        And see the following message "Please enter an amount in multiples of £5"

Scenario: attempt to withdraw more than my balance
        And my balance is £20
        When I try to withdraw £30
        Then I receive £0
        And see the folllowing message "You have insufficient funds"

Scenario: successfully withdraw money
        And my balance is £100
        When I try to withdraw £30
        Then I receive £30
        And see the following message "Your balance is £70"

@manual
Scenario: empty my account
        And my balance is £100
        When I try to withdraw £100
        Then I receive £100
        And see the following message "Your balance is £0"

# This Scenario tests edge cases using a data table
Scenario: withdrawing money from account
        And my balance is "<balance>"
        When I withdraw "<withdraw>"
        Then I receive "<receive>"
        And my remaining balance is shown as "<remaining>"
        And receive the following "<message>"

# A data table can help test lots of variances for the same Scenario
| balance | withdraw  | receive | remaining | message                                     |
| 100     | 31        | 0       | 100       | "Please enter an amount in multiples of 5"  |
| 100     | 30        | 30      | 70        | "Your balance is £70"                       |
| 100     | 29        | 0       | 100       | "Please enter an amount in multiples of 5"  |
| 100     | 110       | 0       | 100       | "You have insufficient funds"               |
