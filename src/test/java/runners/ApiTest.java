
package runners;

import io.karatelabs.core.Runner;
import io.karatelabs.core.SuiteResult;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;

class ApiTest {

    @Test
    void executarTestesDeApi() {

        String ambiente = System.getProperty("karate.env", "dev");

        SuiteResult resultado = Runner
                .path("src/test/resources/features")
                .karateEnv(ambiente)
                .outputHtmlReport(true)
                .outputDir("target/karate-reports")
                .parallel(1);

        assertFalse(
                resultado.isFailed(),
                "Existem cenários de API com falha."
        );
    }
}
