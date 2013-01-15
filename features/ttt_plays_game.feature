Feature: ttt plays a game

  As a player
  I want to play a ttt game
  until the game is over

  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I move until it's a draw or someone wins
    And I should see "Player 1 is the winner!"
