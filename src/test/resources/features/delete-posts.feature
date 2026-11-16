@DELETE
Feature: Excluir posts na API pública JSONPlaceholder

  Background:
    * url baseUrl


  @SMOKE @REGRESSAO @CONTRATO
  Scenario: Excluir um post existente
    Given path 'posts', 1
    When method delete
    Then status 200
    And match response == { }


  @REGRESSAO @ENTRADA_ATIPICA @CONTRATO
  Scenario: Excluir um post com ID inexistente
    Given path 'posts', 9999
    When method delete
    Then status 200
    And match response == { }


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Excluir um post com ID zero
    Given path 'posts', 0
    When method delete
    Then status 200
    And match response == { }


  @REGRESSAO @LIMITE @CONTRATO
  Scenario: Excluir um post com ID negativo
    Given path 'posts', -1
    When method delete
    Then status 200
    And match response == { }


  @REGRESSAO @TIPO_DADO @CONTRATO
  Scenario: Excluir um post com ID textual
    Given path 'posts', 'abc'
    When method delete
    Then status 200
    And match response == { }


  @REGRESSAO @CAMPO_AUSENTE @CONTRATO
  Scenario: Excluir um post sem informar o ID
    Given path 'posts'
    When method delete
    Then status 404
    And match response == { }
