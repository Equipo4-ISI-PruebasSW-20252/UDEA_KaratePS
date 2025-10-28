@parabank_transfer
Feature: Transfer funds between accounts in ParaBank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Successful transfer between valid accounts
    Given path 'transfer'
    And param fromAccountId = '13344'
    And param toAccountId = '13344'
    And param amount = '10'
    When method POST
    Then status 200
    And match response ==
    """
    {
      "message": '#string',
      "transferAmount": '#number'
    }
    """

  @transfer_invalid_amount
  Scenario: Transfer fails when amount is invalid (negative)
    Given path 'transfer'
    And param fromAccountId = '13344'
    And param toAccountId = '13344'
    And param amount = '-10'
    When method POST
    Then status 400
    And match response == 'Invalid amount'

  @transfer_invalid_account
  Scenario: Transfer fails when account does not exist
    Given path 'transfer'
    And param fromAccountId = '99999'
    And param toAccountId = '13344'
    And param amount = '50'
    When method POST
    Then status 400
    And match response contains 'Could not find account'