Feature: Atualizar posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Atualizar um post existente
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "title": "Post atualizado com Karate",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response.id == 1
    And match response.title == 'Post atualizado com Karate'
    And match response.body == 'Conteúdo atualizado pelo teste automatizado.'
    And match response.userId == 1
