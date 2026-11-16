@POST
Feature: Criar posts na API pública JSONPlaceholder

  Background:
    * url baseUrl

  @SMOKE @REGRESSAO @CONTRATO
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
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == 1
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CONTRATO
  Scenario: Criar um post com título diferente
    Given path 'posts'
    And request
      """
      {
        "title": "Automação de testes com Karate DSL",
        "body": "Validando a criação de posts com diferentes títulos.",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Automação de testes com Karate DSL'
    And match response.body == 'Validando a criação de posts com diferentes títulos.'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CONTRATO
  Scenario: Criar um post com body extenso
    Given path 'posts'
    And request
      """
      {
        "title": "Automação de testes com Karate DSL",
        "body": "Este cenário tem como objetivo validar a criação de um post com um conteúdo extenso. O texto contém várias frases para verificar se a API recebe e retorna corretamente todas as informações enviadas. Também buscamos identificar possíveis problemas relacionados ao tamanho do conteúdo, truncamento de caracteres ou alteração dos dados durante o processamento. A utilização de textos maiores contribui para ampliar a cobertura dos testes de API e verificar o comportamento do serviço diante de diferentes volumes de informação.",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Automação de testes com Karate DSL'
    And match response.body == 'Este cenário tem como objetivo validar a criação de um post com um conteúdo extenso. O texto contém várias frases para verificar se a API recebe e retorna corretamente todas as informações enviadas. Também buscamos identificar possíveis problemas relacionados ao tamanho do conteúdo, truncamento de caracteres ou alteração dos dados durante o processamento. A utilização de textos maiores contribui para ampliar a cobertura dos testes de API e verificar o comportamento do serviço diante de diferentes volumes de informação.'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CONTRATO
  Scenario: Criar um post com caracteres especiais
    Given path 'posts'
    And request
      """
      {
        "title": "Automação de testes com Karate DSL",
        "body": "Validando a criação de posts com caracteres especiais @#$%&*",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Automação de testes com Karate DSL'
    And match response.body == 'Validando a criação de posts com caracteres especiais @#$%&*'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Criar um post com título vazio
    Given path 'posts'
    And request
      """
      {
        "title": "",
        "body": "Validando a criação de posts com título vazio",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == ''
    And match response.body == 'Validando a criação de posts com título vazio'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Criar um post com body vazio
    Given path 'posts'
    And request
      """
      {
        "title": "Automação de testes com Karate DSL",
        "body": "",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Automação de testes com Karate DSL'
    And match response.body == ''
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Criar um post sem título
    Given path 'posts'
    And request
      """
      {
        "body": "Validando a criação de posts com título vazio",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == '#notpresent'
    And match response.body == 'Validando a criação de posts com título vazio'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Criar um post sem body
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "userId": 2
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == '#notpresent'
    And match response.userId == 2
    And match header Content-Type contains 'application/json'


  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Criar um post sem userId
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API."
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == '#notpresent'
    And match header Content-Type contains 'application/json'


  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Criar um post com userId sem correspondência conhecida
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API.",
        "userId": 1111
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == 1111
    And match header Content-Type contains 'application/json'


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Criar um post com userId zero
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API.",
        "userId": 0
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == 0
    And match header Content-Type contains 'application/json'


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Criar um post com userId negativo
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API.",
        "userId": -1
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == -1
    And match header Content-Type contains 'application/json'


  @REGRESSAO @TIPO_DADO @CONTRATO
  Scenario: Criar um post com userId textual
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": "Post criado durante a execução dos testes de API.",
        "userId": "abc"
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#string',
        userId: '#string',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 'Post criado durante a execução dos testes de API.'
    And match response.userId == "abc"
    And match header Content-Type contains 'application/json'


  @REGRESSAO @TIPO_DADO @CONTRATO
  Scenario: Criar um post com body numérico
    Given path 'posts'
    And request
      """
      {
        "title": "Teste automatizado com Karate",
        "body": 123,
        "userId": 1
      }
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        title: '#string',
        body: '#number',
        userId: '#number',
        id: '#number'
      }
      """
    And match response.title == 'Teste automatizado com Karate'
    And match response.body == 123
    And match response.userId == 1
    And match header Content-Type contains 'application/json'


  @REGRESSAO @PAYLOAD_VAZIO @CONTRATO
  Scenario: Criar um post com payload vazio
    Given path 'posts'
    And request
      """
      {}
      """
    When method post
    Then status 201
    And match response ==
      """
      {
        id: '#number'
      }
      """
    And match header Content-Type contains 'application/json'
