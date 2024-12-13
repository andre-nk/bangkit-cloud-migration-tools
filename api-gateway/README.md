# About Flexible Configuration

https://www.krakend.io/docs/configuration/flexible-config/

The environment variables of the flexible configuration are:

* `FC_ENABLE=1`: Activates Flexible Configuration. You can use 1 or any other value (but 0 won’t turn it off!). The file passed with the --config flag is the base template and contains the references to any other templates.
* `FC_PARTIALS=path/to/partials`: The path to the partials directory. Partial files are pieces of text that DON’T EVALUATE, and they are inserted in the placeholder “as is”.
* `FC_TEMPLATES=path/to/templates`: The path to the templates directory. These are evaluated using the Go templating system.
* `FC_SETTINGS=path/to/settings`: The path to the settings directory. Settings are JSON files that you can use to fill values in the templates, much similar to env files in other applications, but richer as you can use multiple files, structures, and nesting.
* `FC_OUT=file`.json: Saves the resulting configuration after rendering the template, useful for debugging, not required for runtime.

## Contents:

* `krakend.tmpl`: the base file, including calls to the variables, iteration over available endpoints and some code snippets.
* `Dockerfile`: A docker definition to build an immutable container with KrakenD
docker-compose.yml an example docker compose definition file to be able to execute KrakenD enabling Flexible Configuration.
* `config/partials/*`: some code snippets referenced from base file
* `config/templates/*`: a template referenced from base file
* `config/settings/{dev|prod}/endpoint.json`: a collection of endpoints
* `config/settings/{dev|prod}/service.json`: basic configuration parameters for the service