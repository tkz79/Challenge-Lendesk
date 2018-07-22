Feature: The executable creates files

  Scenario: When seeking csv output
    When I run `image_gps.rb ../images`
    Then a csv output file should exist

  Scenario: When seeking html output
    When I run `image_gps.rb -html ../images`
    Then a html output file should exist
