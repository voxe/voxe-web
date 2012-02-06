Feature: BACKOFFICE Rename election

  Background:
    Given I am a logged admin

  @javascript
  Scenario:
    Given There is a election with the name "name 1"
    And I am on the elections page
    When I click on "Renommer" button
    And I fill the "electionName" text field with "name 2"
    And I click on "Renommer !" button
    Then I shoud see "name 2" on the page
    And An election with the name "name 2" should be registred
