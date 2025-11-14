@parabank_billpay
Feature: Payment failed due to insufficient funds

    Background:
        * url baseUrl
        * header Accept = 'application/json'
        * def fakerObj = new faker()

        * def fromAccountId = 13122

        * def fromAccountId = '12345'
        * def insufficientAmount = fakerObj.number().numberBetween(100000, 900000)
        * def negative_amount = fakerObj.number().numberBetween(-200, -1)

    Scenario: Payment failed due to insufficient funds
        Given path 'billpay'
        And param accountId = fromAccountId
        And param amount = insufficientAmount
        And request
            """
            {
                "name": "Pago de prueba",
                "address": {
                    "street": "direccion de prueba",
                    "city": "Medellin",
                    "state": "Antioquia",
                    "zipCode": "5002"
                },
                "phoneNumber": "3333333333333",
                "accountNumber": "13344"
            }
            """
        When method POST
        Then match [400, 422] contains responseStatus
        And match response contains 'insufficient' || response contains 'insufficient funds'

        * print 'Status recibido:', responseStatus
        * print 'Respuesta recibida:', response
