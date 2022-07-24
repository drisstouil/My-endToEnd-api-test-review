@endToEnd
Feature: endToEnd

  Scenario: EndTodEnd Review
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    * def generator = Java.type('tigers.api.review.data.DataGenerator')
    * def email = generator.getemail()
    * def firstName = generator.getfirstName()
    * def lastName = generator.getlastName()
    * def dob = generator.getDoB()
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
      "email": "#(email)",
      "title": "Mr.",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "student",
      "dateOfBirth": "#(dob)"
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    And print response
    Then status 201
    * def generator = Java.type('tigers.api.review.data.DataGenerator')
    * def addressType = generator.addressType()
    * def addressCity = generator.getCity()
    * def AddressZipCode = generator.getZip()
    And path "/api/accounts/add-account-address"
    And param primaryPersonId = response.id
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "addressType": "addressType",
      "addressLine1": "12 simo blvd",
      "city": "addressCity",
      "state": "va",
      "postalCode": "22204",
      "countryCode": "AddressZipCode",
      "current": true
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    * def generator = Java.type('tigers.api.review.data.DataGenerator')
    * def phoneNumber = generator.getphoneNumber()
    * def phoneExtention = generator.phoneExtension()
    And path "/api/accounts/add-account-phone"
    And param primaryPersonId = response.id
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      
      "phoneNumber": "phoneNumber",
      "phoneExtension": "phoneExtention",
      "phoneTime": "Morning",
      "phoneType": "Home"
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = response.id
    And request {"make": "benz","model": "4Matic","year": "2022","licensePlate": "wrp5492"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
