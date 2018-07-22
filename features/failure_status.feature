Feature: The executable provides correct failure status

  Scenario: When using an unsupported option
    When I run `image_gps.rb --unsupported`
    Then the exit status should be 1

  Scenario: When providing too many args
    When I run `image_gps.rb arg1 arg2`
    Then the exit status should be 2

  Scenario: When called from a not writable folder
    Given a folder that is not writeable
    When I cd to "non_writeable"
    And I run `image_gps.rb`
    Then the exit status should be 3

  Scenario: When called on an not readable folder
    Given a folder that is not readable
    When I run `image_gps.rb non_readable`
    Then the exit status should be 4

  Scenario: When called on a non existent folder
    When I run `image_gps.rb non_existent`
    Then the exit status should be 4
