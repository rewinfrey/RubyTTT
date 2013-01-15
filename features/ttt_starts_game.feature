Feature: ttt starts a game

  As a human player
  I want to start a ttt game
  So that I can beat the computer

  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "Welcome to TTT!"
    And I should see "Enter player 1 side (x or o):"
