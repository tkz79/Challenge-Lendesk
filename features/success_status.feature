Feature: The executable provides correct success status

  Scenario: When checking the options
    When I run `image_gps.rb --help`
    Then the exit status should be 0

  Scenario: When running with no params
    When I run `image_gps.rb`
    Then the exit status should be 0

  Scenario: When running with verbose option
    When I run `image_gps.rb -v`
    Then the exit status should be 0

  Scenario: When running with html option
    When I run `image_gps.rb -html`
    Then the exit status should be 0

  Scenario: When running in tmp/images folder
    When I run `image_gps.rb ../images`
    Then the exit status should be 0
