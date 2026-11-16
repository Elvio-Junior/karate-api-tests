
function fn() {

    var ambiente = karate.env || 'dev';

    var config = {
        ambiente: ambiente
    };

    var baseUrl = karate.sysenv('API_BASE_URL');

    if (!baseUrl) {
        throw 'Variável API_BASE_URL não configurada.';
    }

    config.baseUrl = baseUrl;

    karate.log('Ambiente:', ambiente);
    karate.log('Base URL:', config.baseUrl);

    return config;
}
