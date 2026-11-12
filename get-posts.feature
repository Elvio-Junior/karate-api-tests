
@GET
Feature: Consultar posts na API pública JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def tempoMaximoResposta = 500


  @SMOKE @REGRESSAO @LISTAGEM @CONTRATO
  Scenario: Listar todos os posts
    Given path 'posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match each response contains { userId: '#number', id: '#number', title: '#string', body: '#string' }
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @SMOKE @REGRESSAO @CONSULTA_ID @CONTRATO
  Scenario: Consultar um post id existente
    Given path 'posts', 1
    When method get
    Then status 200
    And match response ==
    """
    {
      userId: '#number',
      id: '#number',
      title: '#string',
      body: '#string'
    }
    """
    And match response.userId == 1
    And match response.id == 1
    And match response.title == 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit'
    And match response.body == 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'

    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @CONSULTA_ID
  Scenario: Consultar um post id inexistente
    Given path 'posts', 999
    When method get
    Then status 404
    And match response == {}
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta

  @REGRESSAO @NEGATIVO @LIMITE @CONSULTA_ID
  Scenario: Consultar um post de id 0
    Given path 'posts', 0
    When method get
    Then status 404
    And match response == {}
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @LIMITE @CONSULTA_ID @CONTRATO
  Scenario: Consultar um post id 100
    Given path 'posts', 100
    When method get
    Then status 200
    And match response ==
    """
    {
      userId: '#number',
      id: '#number',
      title: '#string',
      body: '#string'
    }
    """
    And match response.userId == 10
    And match response.id == 100
    And match response.title == 'at nam consequatur ea labore ea harum'
    And match response.body == 'cupiditate quo est a modi nesciunt soluta\nipsa voluptas error itaque dicta in\nautem qui minus magnam et distinctio eum\naccusamus ratione error aut'

    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @LIMITE @CONSULTA_ID
  Scenario: Consultar um post id 101
    Given path 'posts', 101
    When method get
    Then status 404
    And match response == {}
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @LIMITE @CONSULTA_ID
  Scenario: Consultar um post de id negativo
    Given path 'posts', -1
    When method get
    Then status 404
    And match response == {}
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @TIPO_DADO @CONSULTA_ID
  Scenario: Consultar um post de id caracter
    Given path 'posts', 'aa'
    When method get
    Then status 404
    And match response == {}
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @SMOKE @REGRESSAO @FILTRO @CONTRATO
  Scenario: Consultar posts por userId existente
    Given path 'posts'
    And param userId = 1
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response contains { userId: '#number', id: '#number', title: '#string', body: '#string' }
    And match each response contains { userId: 1 }
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @FILTRO
  Scenario: Consultar posts de um userId inexistente
    Given path 'posts'
    And param userId = 999
    When method get
    Then status 200
    And match response == '#[]'
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @LIMITE @FILTRO
  Scenario: Consultar posts de um userId zero
    Given path 'posts'
    And param userId = 0
    When method get
    Then status 200
    And match response == '#[]'
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @FILTRO @LIMITE @CONTRATO
  Scenario: Consultar posts de um userId 10
    Given path 'posts'
    And param userId = 10
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response contains { userId: '#number', id: '#number', title: '#string', body: '#string' }
    And match each response contains { userId: 10 }
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @LIMITE @FILTRO
  Scenario: Consultar posts de um userId 11
    Given path 'posts'
    And param userId = 11
    When method get
    Then status 200
    And match response == '#[]'
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta


  @REGRESSAO @NEGATIVO @LIMITE @FILTRO
  Scenario: Consultar posts de um userId negativo
    Given path 'posts'
    And param userId = -1
    When method get
    Then status 200
    And match response == '#[]'
    And match header Content-Type contains 'application/json'
    And assert responseTime < tempoMaximoResposta
