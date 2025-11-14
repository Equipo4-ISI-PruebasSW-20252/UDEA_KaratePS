@parabank_loan
Feature: Request loans in ParaBank

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fakerObj = new faker()
    * def val_customerId = '12212'
    * def val_fromAccountId = '13344'
    * def val_amount = fakerObj.number().numberBetween(100, 10000)
    * def val_downPayment = fakerObj.number().numberBetween(10, 500)


  Scenario: Successful loan request
    Given path 'loan'
    And param customerId = val_customerId
    And param amount = val_amount
    And param downPayment = val_downPayment
    And param fromAccountId = val_fromAccountId
    When method POST
    Then status 200
    And match response contains 'loanResponse'

  @loan_invalid
  Scenario: Loan request fails when downPayment exceeds amount
    Given path 'loan'
    And param customerId = val_customerId
    And param amount = 100
    And param downPayment = 500
    And param fromAccountId = val_fromAccountId
    When method POST
    Then status 400
    And match response contains 'Invalid loan request