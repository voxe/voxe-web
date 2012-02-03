Feature: BACKOFFICE Create new elections

  Background:
    Given I am a logged admin

  @javascript
  Scenario:
    Given I am on the elections page
    When I fill the "electionName" text field with "election test"
    And I click on "Ajouter" button
    Then I shoud see "election test" on the page
    Then An election with the name "election test" should be registred
