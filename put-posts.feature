@PUT
Feature: Atualizar posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'


  @SMOKE @REGRESSAO @CONTRATO
  Scenario: Atualizar um post com título diferente
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
    And match response ==
      """
      {
        id: '#number',
        title: '#string',
        body: '#string',
        userId: '#number'
      }
      """
    
  @REGRESSAO @CONTRATO
  Scenario: Atualizar um post com body extenso
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "title": "Post atualizado com body extenso",
        "body": "Este cenário tem como objetivo validar a atualização de um post com um conteúdo extenso. O texto contém várias frases para verificar se a API recebe e retorna corretamente todas as informações enviadas. Também buscamos identificar possíveis problemas relacionados ao tamanho do conteúdo, truncamento de caracteres ou alteração dos dados durante o processamento. A utilização de textos maiores contribui para ampliar a cobertura dos testes de API e verificar o comportamento do serviço diante de diferentes volumes de informação.",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response.id == 1
    And match response.title == 'Post atualizado com body extenso'
    And match response.body == 'Este cenário tem como objetivo validar a atualização de um post com um conteúdo extenso. O texto contém várias frases para verificar se a API recebe e retorna corretamente todas as informações enviadas. Também buscamos identificar possíveis problemas relacionados ao tamanho do conteúdo, truncamento de caracteres ou alteração dos dados durante o processamento. A utilização de textos maiores contribui para ampliar a cobertura dos testes de API e verificar o comportamento do serviço diante de diferentes volumes de informação.'
    And match response.userId == 1
    And match response ==
      """
      {
        id: '#number',
        title: '#string',
        body: '#string',
        userId: '#number'
      }
      """


  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Atualizar um post com título vazio
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "title": "",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        title: '',
        body: '#string',
        userId: '#number'
      }
      """

  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Atualizar um post com body vazio
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "title": "Post atualizado com body vazio",
        "body": "",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        title: '#string',
        body: '',
        userId: '#number'
      }
      """

  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Atualizar um post sem título
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response.id == 1
    And match response.title == '#notpresent'
    And match response.body == 'Conteúdo atualizado pelo teste automatizado.'
    And match response.userId == 1
    And match response ==
      """
      {
        id: '#number',
        title: '#notpresent',
        body: '#string',
        userId: '#number'
      }
      """

  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Atualizar um post sem body
    Given path 'posts', 1
    And request
      """
      {
        "id": 1,
        "title": "Post atualizado sem body",
        "userId": 1
      }
      """
    When method put
    Then status 200
    And match response.id == 1
    And match response.title == 'Post atualizado sem body'
    And match response.body == '#notpresent'
    And match response.userId == 1
    And match response ==
      """
      {
        id: '#number',
        title: '#string',
        body: '#notpresent',
        userId: '#number'
      }
      """

  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Atualizar um post com ID inexistente
    Given path 'posts', 99999
    And request
      """
      {
        "id": 99999,
        "title": "Post atualizado com ID inexistente",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 404
    And match response == { }


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Atualizar um post com ID zero
    Given path 'posts', 0
    And request
      """
      {
        "id": 0,
        "title": "Post atualizado com ID zero",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 404
    And match response == { }


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Atualizar um post com ID negativo
    Given path 'posts', -1
    And request
      """
      {
        "id": -1,
        "title": "Post atualizado com ID negativo",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 404
    And match response == { }


  @REGRESSAO @TIPO_DADO @CONTRATO
  Scenario: Atualizar um post com ID textual
    Given path 'posts', "abc"
    And request
      """
      {
        "id": "abc",
        "title": "Post atualizado com ID textual",
        "body": "Conteúdo atualizado pelo teste automatizado.",
        "userId": 1
      }
      """
    When method put
    Then status 404
    And match response == { }
