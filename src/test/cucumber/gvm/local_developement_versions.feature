Feature: Local Development Versions

  Background:
    Given the internet is reachable

  Scenario: Install a new local development version
    Given the candidate "groovy" version "2.1-SNAPSHOT" does not exist
    And I have a local candidate "groovy" version "2.1-SNAPSHOT" at "/tmp/groovy-core"
    When I enter "gvm install groovy 2.1-SNAPSHOT /tmp/groovy-core"
    Then I see "Linking groovy 2.1-SNAPSHOT to /tmp/groovy-core"
    And the candidate "groovy" version "2.1-SNAPSHOT" is linked to "/tmp/groovy-core"

  Scenario: Install a new local development version with an invalid label
    Given the candidate "groovy" version "my/silly/label" does not exist
    And I have a local candidate "groovy" version "my/silly/label" at "/tmp/groovy-core"
    When I enter "gvm install groovy 2.1-SNAPSHOT /tmp/groovy-core"
    Then I see "Linking groovy 2.1-SNAPSHOT to /tmp/groovy-core"
    And the candidate "groovy" version "2.1-SNAPSHOT" is linked to "/tmp/groovy-core"

  Scenario: Attempt installing a local development version that already exists
    Given the candidate "groovy" version "2.1-SNAPSHOT" does not exist
    And the candidate "groovy" version "2.1-SNAPSHOT" is already linked to "/tmp/groovy-core"
    When I enter "gvm install groovy 2.1-SNAPSHOT /tmp/groovy-core"
    Then I see "Stop! groovy 2.1-SNAPSHOT is already installed."
    And the candidate "groovy" version "2.1-SNAPSHOT" is linked to "/tmp/groovy-core"

  Scenario: Uninstall a local development version
    Given the candidate "groovy" version "2.1-SNAPSHOT" is already linked to "/tmp/groovy-core"
    When I enter "gvm uninstall groovy 2.1-SNAPSHOT"
    Then I see "Uninstalling groovy 2.1-SNAPSHOT"
    And the candidate "groovy" version "2.1-SNAPSHOT" is not installed

  Scenario: Attempt uninstalling a local development version that is not installed
    Given the candidate "groovy" version "2.1-SNAPSHOT" is not installed
    When I enter "gvm uninstall groovy 2.1-SNAPSHOT"
    Then I see "groovy 2.1-SNAPSHOT is not installed."

  Scenario: Make the local development version the default for the candidate
    Given the candidate "groovy" version "2.0.6" is already installed and default
    And the candidate "groovy" version "2.1-SNAPSHOT" is already linked to "/tmp/groovy-core"
    When I enter "gvm default groovy 2.1-SNAPSHOT"
    Then I see "Default groovy version set to 2.1-SNAPSHOT"
    And the candidate "groovy" version "2.1-SNAPSHOT" should be the default

  Scenario: Use a local development version
    Given the candidate "groovy" version "2.0.6" is already installed and default
    And the candidate "groovy" version "2.1-SNAPSHOT" is already linked to "/tmp/groovy-core"
    When I enter "gvm use groovy 2.1-SNAPSHOT"
    Then I see "Using groovy version 2.1-SNAPSHOT in this shell"
    And the candidate "groovy" version "2.1-SNAPSHOT" should be in use

  Scenario: Switch from a local version to a standard one in isolated mode
    Given isolated mode is active
    Given the candidate "groovy" version "2.0.5" is already installed and default
    And the candidate "groovy" version "dev" is already linked to "/tmp/groovy-core"
    When I enter "gvm use groovy dev"
    Then I see "Using groovy version dev in this shell"
    When I enter "gvm use groovy 2.0.5"
    Then I see "Using groovy version 2.0.5 in this shell"
    When I enter "gvm current groovy"
    Then I see "Using groovy version 2.0.5"

  Scenario: Switch from a local version to a standard one
    Given isolated mode is not active
    Given the candidate "groovy" version "2.0.5" is already installed and default
    And the candidate "groovy" version "dev" is already linked to "/tmp/groovy-core"
    When I enter "gvm use groovy dev"
    Then I see "Using groovy version dev in this shell"
    When I enter "gvm use groovy 2.0.5"
    Then I see "Using groovy version 2.0.5 in this shell"
    When I enter "gvm current groovy"
    Then I see "Using groovy version 2.0.5"
