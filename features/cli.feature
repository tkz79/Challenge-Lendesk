Feature: The executable has a good command-line interface
  Scenario: Checking that the options are documented
    When I run `image_gps.rb --help`
    Then the output should contain:
    """
    Usage: image_gps.rb [options] [/target/folder/path]

    Options are:
        -html                            Output HTML file
        -v, --verbose                    Run verbosely
    """

  Scenario: Prints messages in verbose mode
    When I run `image_gps.rb -v`
    Then the output should contain:
    """
    Setting directory to scan
    """

  Scenario: Handles unsupported options gracefully
    When I run `image_gps.rb -unsupported`
    Then the output should contain:
    """
    invalid option: -unsupported
    """

  Scenario: Handles too many parameters gracefully
    When I run `image_gps.rb /home /var`
    Then the output should contain:
    """
    Unable to set root directory
    Too many arguments passed
    """

  Scenario: Handles non existent folders gracefully
    When I run `image_gps.rb non_existent`
    Then the output should contain:
    """
    Unable to scan this directory
    No such file or directory
    """

  Scenario: Handles non writeable folders gracefully
    Given a folder that is not writeable
    When I cd to "non_writeable"
    And I run `image_gps.rb`
    Then the output should contain:
    """
    Unable to initialize the output file
    Make sure you have write permission to your pwd
    """

  Scenario: Handles not readable folders gracefully
    Given a folder that is not readable
    When I run `image_gps.rb non_readable`
    Then the output should contain:
    """
    Unable to scan this directory
    Permission denied
    """
