# EXAMPLE OF A FEATURE FILE FOR AUTOMATED TESTING OF BOMAD USING GHERKIN

# Gherkin     -   Gherkin is a computer language, written in plain English, using keywords which are then interpreted by Cucumber tests
# Comments    -   A comment in Gherin is denoted by using the # symbol. Any text after this will be ignored by the tests
# Keywords    -   Gherkin keywords are:- Feature, Scenario, Background, Given, When, Then, And, But, Example(s), Scenario Outline
# User story  -   A user story describes what a particular feature should do, from the perspective of the user, described in plain English

# This describes our Feature
Feature: Withdraw money from account
# Here we describe our User story
  As a child who wants to withdraw my allowance
  I want to see how much I can withdraw
  So that I don't go overdrawn

# Our Acceptance Criteria will help us write our tests. Good practice is to put our tests in the order of our Acceptance Criteria
  Acceptance Criteria
    - I will see my available balance
    - I am only allowed to withdraw in £5 denominations
    - I cannot withdraw more than my balance
    - I will receive an alert when I have less than £10 in my account
    - I will be prompted if I try to withdraw an amount below £5

# This gives consistent context for each test Scenario
Background:
        Given I have logged into my account
        When my account detail is shown
        Then I can see my available balance
        And how much I can withdraw

# These Scenarios outline our tests
Scenario: withdrawing money from account with incorrect denominations
        Given my balance is £100
        When I withdraw £12
        Then I receive 0
        And receive notification "Please enter an amount in multiples of £5"

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

# This Scenario tests edge cases using a data table
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
