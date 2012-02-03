Feature: Election

  @javascript
  Scenario: Unpublish election
    Given I am a logged admin
    And There is a published election
    And I am on the elections page
    When I click on "Publié" button
    Then I shoud see "Non publié" on the page
    And The election shoud be unpublished
