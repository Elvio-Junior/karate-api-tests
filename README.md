# Karate API Tests

## Sobre o projeto

Projeto de automação de testes de API REST utilizando Karate Framework, com cenários escritos em Gherkin e execução por meio do Maven.

O objetivo é validar os principais comportamentos das operações HTTP GET, POST, PUT e DELETE da API pública [JSONPlaceholder](https://jsonplaceholder.typicode.com/).

## Tecnologias utilizadas

- Java 21
- Apache Maven 3.10.0
- Karate Framework 2.1.4
- JUnit 5.10.1
- Gherkin
- JavaScript
- PowerShell
- Git e GitHub

## Estrutura do projeto

```text
karate-api-tests/
├── environments/
│   ├── .env.dev
│   ├── .env.hml
│   └── .env.prod
├── scripts/
│   └── run-tests.ps1
├── src/
│   └── test/
│       ├── java/
│       │   └── runners/
│       │       └── ApiTest.java
│       └── resources/
│           ├── karate-config.js
│           └── features/
│               ├── get-posts.feature
│               ├── post-posts.feature
│               ├── put-posts.feature
│               └── delete-posts.feature
├── .env.example
├── .gitignore
└── pom.xml
```

## Organização dos testes

| Arquivo | Operação | Descrição |
|---|---|---|
| `get-posts.feature` | GET | Consulta e listagem de posts, consulta por ID e filtros. |
| `post-posts.feature` | POST | Criação de posts e validação de diferentes entradas. |
| `put-posts.feature` | PUT | Atualização de posts e validação de diferentes entradas. |
| `delete-posts.feature` | DELETE | Exclusão de posts e verificação das respostas da API. |

## Tags dos cenários

As tags são utilizadas para categorizar, organizar e facilitar a seleção dos cenários de testes conforme a operação HTTP, estratégia de teste e tipo de validação.

### Tags por operação HTTP

| Tag | Finalidade |
|---|---|
| `@GET` | Cenários de consulta de recursos. |
| `@POST` | Cenários de criação de recursos. |
| `@PUT` | Cenários de atualização de recursos. |
| `@DELETE` | Cenários de exclusão de recursos. |

### Tags por estratégia e finalidade

| Tag | Finalidade |
|---|---|
| `@SMOKE` | Testes essenciais para verificar funcionalidades principais da API. |
| `@REGRESSAO` | Testes destinados a verificar se alterações não comprometeram funcionalidades existentes. |
| `@CONTRATO` | Validação da estrutura, dos tipos de dados e dos campos esperados nas requisições e respostas. |

### Tags por tipo de cenário

| Tag | Finalidade |
|---|---|
| `@LISTAGEM` | Cenários de consulta e listagem de coleções de recursos. |
| `@CONSULTA_ID` | Cenários de consulta de recursos por identificador. |
| `@FILTRO` | Cenários de consulta utilizando parâmetros de filtragem. |
| `@NEGATIVO` | Cenários que verificam o comportamento da API diante de condições inválidas ou resultados não encontrados. |
| `@ENTRADA_ATIPICA` | Cenários que utilizam entradas fora do padrão habitual, mas que podem ser aceitas pela API. |
| `@LIMITE` | Cenários que verificam valores extremos, mínimos, máximos ou fora dos limites esperados. |
| `@TIPO_DADO` | Cenários que verificam o comportamento da API diante de tipos de dados diferentes dos esperados. |
| `@CAMPO_AUSENTE` | Cenários que verificam requisições com campos obrigatórios ou opcionais não informados. |
| `@PAYLOAD_VAZIO` | Cenários que verificam o comportamento da API ao receber um corpo de requisição vazio. |

Exemplo de utilização:

```gherkin
@SMOKE @REGRESSAO @LISTAGEM @CONTRATO
Scenario: Listar todos os posts
```

## Configuração de ambientes

O projeto utiliza arquivos de ambiente para separar a URL base da API conforme o ambiente selecionado.

Arquivos disponíveis:

- `environments/.env.dev`
- `environments/.env.hml`
- `environments/.env.prod`

Exemplo de configuração:

```properties
API_BASE_URL=https://jsonplaceholder.typicode.com
```

O arquivo `karate-config.js` recupera a variável `API_BASE_URL` e disponibiliza a configuração `baseUrl` para os arquivos `.feature`.

> Os três arquivos utilizam a mesma URL da JSONPlaceholder como exemplo. Portanto, representam a estrutura de segregação de ambientes, não três ambientes reais independentes.

## Como executar os testes

Para executar os testes, é necessário ter Java e Maven instalados e configurados no PATH do sistema.

### Executar todos os testes

```powershell
mvn clean test "-Dkarate.env=dev"
```

### Executar testes por tags

O projeto utiliza a propriedade `karate.tags` para selecionar os cenários que serão executados.

**Importante:** para que os comandos por tag funcionem, o `ApiTest.java` deve recuperar a propriedade `karate.tags` e aplicá-la ao Runner por meio de `.tags()`.

Exemplo de implementação no Runner:

```java
String tags = System.getProperty("karate.tags");

var runner = Runner
        .path("src/test/resources/features")
        .karateEnv(ambiente)
        .outputHtmlReport(true)
        .outputDir("target/karate-reports");

if (tags != null && !tags.isBlank()) {
    runner.tags(tags);
}

SuiteResult resultado = runner.parallel(1);
```

### Comandos Maven úteis

| Comando | Finalidade |
|---|---|
| `mvn clean` | Remove os arquivos gerados na execução anterior. |
| `mvn test` | Executa os testes. |
| `mvn clean test` | Limpa os arquivos anteriores e executa os testes. |
| `mvn clean test "-Dkarate.env=dev"` | Executa todos os testes no ambiente DEV. |
| `mvn clean test "-Dkarate.env=hml"` | Executa todos os testes no ambiente HML. |
| `mvn clean test "-Dkarate.env=prod"` | Executa todos os testes no ambiente PROD. |
| `mvn dependency:tree` | Exibe a árvore de dependências do projeto. |

#### Execução por operação HTTP

```powershell
# Executar somente testes GET
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@GET"

# Executar somente testes POST
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@POST"

# Executar somente testes PUT
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@PUT"

# Executar somente testes DELETE
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@DELETE"
```

#### Execução por estratégia de teste

```powershell
# Executar testes Smoke
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@SMOKE"

# Executar testes de Regressão
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@REGRESSAO"

# Executar validações de contrato
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@CONTRATO"
```

#### Execução por tipo de cenário

```powershell
# Listagem
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@LISTAGEM"

# Consulta por ID
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@CONSULTA_ID"

# Filtros
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@FILTRO"

# Cenários negativos
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@NEGATIVO"

# Entradas atípicas
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@ENTRADA_ATIPICA"

# Limites
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@LIMITE"

# Tipos de dados
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@TIPO_DADO"

# Campos ausentes
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@CAMPO_AUSENTE"

# Payload vazio
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@PAYLOAD_VAZIO"
```

#### Combinação de tags

É possível combinar tags para restringir ainda mais a seleção dos cenários.

```powershell
# Testes GET de Smoke
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@GET and @SMOKE"

# Testes de contrato das operações POST
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@POST and @CONTRATO"

# Testes de regressão ou Smoke
mvn clean test "-Dkarate.env=dev" "-Dkarate.tags=@SMOKE or @REGRESSAO"
```

- `and`: seleciona cenários que possuem todas as tags informadas.
- `or`: seleciona cenários que possuem pelo menos uma das tags informadas.

A seleção considera as tags efetivamente atribuídas aos cenários nos arquivos `.feature`.

## Script de execução PowerShell

O projeto possui o script `scripts/run-tests.ps1`, responsável por carregar as variáveis do arquivo de ambiente e executar os testes.

Exemplo:

```powershell
.\scripts\run-tests.ps1 -Environment dev
```

Também é possível selecionar os ambientes `hml` e `prod`:

```powershell
.\scripts\run-tests.ps1 -Environment hml
.\scripts\run-tests.ps1 -Environment prod
```

## Relatórios

Após a execução, os relatórios são gerados nos seguintes diretórios:

- `target/karate-reports/`
- `target/surefire-reports/`

O relatório HTML do Karate apresenta os resultados dos cenários, as requisições, as respostas e eventuais falhas.

## Estratégias de testes aplicadas

- Testes funcionais de API.
- Testes positivos e negativos.
- Testes de regressão.
- Testes Smoke.
- Validação de contrato.
- Validação de códigos HTTP.
- Validação de estrutura e tipos de dados JSON.
- Verificação de campos presentes e ausentes.
- Testes de limites e entradas atípicas.
- Validação de filtros e consultas por identificador.
- Verificação do tempo de resposta conforme o critério definido para o exercício.

## Observação sobre a API

A JSONPlaceholder é uma API pública de simulação. Operações de criação, atualização e exclusão retornam respostas simuladas e não representam persistência real dos dados.

Os cenários documentam o comportamento observado nessa API e não devem ser interpretados como validação de regras de negócio de um sistema de produção.

## Autor

**Elvio Jardini Junior**