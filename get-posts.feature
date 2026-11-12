Feature: Consultar posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Listar todos os posts
    Given path 'posts'
    When method get
    Then status 200
    And match response != []
    And match response == '#[]'
    And match each response contains { userId: '#number', id: '#number', title: '#string', body: '#string' }

  Scenario: Consultar um post existente
    Given path 'posts', 1
    When method get
    Then status 200
    And match response.id == 1
    And match response.userId == '#number'
    And match response.title == '#string'
    And match response.body == '#string'
