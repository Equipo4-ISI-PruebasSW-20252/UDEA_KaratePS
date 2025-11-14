@parabank_transfer
Feature: Transfer funds between accounts in ParaBank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fakerObj = new faker()
    * def val_fromAccountId = '12456'
    * def val_toAccountId = '12345'
    * def val_amount = fakerObj.number().numberBetween(1, 200)
    * def val_fromAccountId_error = fakerObj.number().randomNumber(5, true)
    * def val_toAccountId_error = fakerObj.number().randomNumber(5, true)
    * def negative_amount = -30
  # * def high_amount = 10000000

  Scenario: Successful Transfer
    Given path 'transfer'
    And param fromAccountId = val_fromAccountId
    And param toAccountId = val_toAccountId
    And param amount = val_amount
    When method POST
    Then status 200
    And match response == "Successfully transferred $"+ val_amount+" from account #"+val_fromAccountId+" to account #"+val_toAccountId

  @transfer_invalid_amount
  Scenario: Transfer fails when amount is invalid (negative)
    Given path 'transfer'
    And param fromAccountId = val_fromAccountId
    And param toAccountId = val_toAccountId
    And param amount = negative_amount
    When method POST
    Then status 200
    And match response == "Successfully transferred $"+ negative_amount+" from account #"+val_fromAccountId+" to account #"+val_toAccountId

  @transfer_invalid_account
  Scenario: Transfer fails when account invalid
    Given path 'transfer'
    And param fromAccountId = val_fromAccountId_error
    And param toAccountId = val_toAccountId_error
    And param amount = val_amount
    When method POST
    Then status 400
    And match response == "Could not find account number " + val_fromAccountId_error + " and/or " + val_toAccountId_error