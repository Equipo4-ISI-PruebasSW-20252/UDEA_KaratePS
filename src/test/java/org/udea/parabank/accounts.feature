@parabank_accounts
Feature: Account management in ParaBank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Retrieve all accounts for a valid customer
    Given path 'customers'
    And path '12212'
    And path 'accounts'
    When method GET
    Then status 200
    And match each response contains { id: '#number', balance: '#number', type: '#string' }

  @account_details
  Scenario: Retrieve details of a specific account
    Given path 'accounts'
    And path '13344'
    When method GET
    Then status 200
    And match response ==
    """
    {
      "id": '#number',
      "customerId": '#number',
      "type": '#string',
      "balance": '#number'
    }
    """