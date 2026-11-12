Feature: Excluir posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Excluir um post existente
    Given path 'posts', 1
    When method delete
    Then status 200
