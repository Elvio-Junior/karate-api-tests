Feature: Criar posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Criar um novo post
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API.",
        "userId": 1
      }
      """
    When method post
    Then status 201
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == 1
    And match response.id == '#number'
    And match response.body == '#string'
    And match response.userId == '#number'
