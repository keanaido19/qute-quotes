package de.wethinkco.qutequotes.api;

import io.javalin.Javalin;
import io.javalin.plugin.openapi.OpenApiOptions;
import io.javalin.plugin.openapi.OpenApiPlugin;
import io.javalin.plugin.openapi.ui.ReDocOptions;
import io.javalin.plugin.openapi.ui.SwaggerOptions;
import io.swagger.v3.oas.models.info.Info;
import org.slf4j.simple.SimpleLogger;

import static io.javalin.apibuilder.ApiBuilder.*;

public class ApiServer {
    private final Javalin server;

    public ApiServer() {
        System.setProperty(SimpleLogger.DEFAULT_LOG_LEVEL_KEY, "ERROR");
        this.server = Javalin
                .create(
                        config -> {
                            config.registerPlugin(getConfiguredOpenApiPlugin());
                            config.defaultContentType = "application/json";
                        }
                )
                .routes(() -> {
                            path("quote",
                                    () -> path("{id}",
                                            () -> get(QuoteController::getOne)
                                    )
                            );
                            path("quotes",
                                    () -> {
                                        get(QuoteController::getAll);
                                        post(QuoteController::create);
                                    }
                            );
                        }
                );
    }

    public Javalin start() {
        System.out.println(
                "Welcome to Qute Quotes Server!\n" +
                        "Server is listening on...\n" +
                        "\tAddress\t\t:\thttp://localhost:5000/\n" +
                        "\tReDocs\t\t:\thttp://localhost:5000/redoc\n" +
                        "\tSwagger UI\t:\thttp://localhost:5000/" +
                        "swagger-ui"
        );
        return this.server.start(5000);
    }

    public Javalin stop() {
        return this.server.stop();
    }

    private static OpenApiPlugin getConfiguredOpenApiPlugin() {
        Info info =
                new Info()
                        .version("1.0")
                        .title("Qute Quotes API")
                        .description(
                                "This API provides endpoints to get and " +
                                        "create quotes."
                        );

        OpenApiOptions options = new OpenApiOptions(info)
                .activateAnnotationScanningFor(
                        "de.wethinkco.qutequotes.api"
                )
                .path("/swagger-docs")
                .swagger(new SwaggerOptions("/swagger-ui"))
                .reDoc(new ReDocOptions("/redoc"));
        return new OpenApiPlugin(options);
    }

    public static void main(String[] args) {
        ApiServer apiServer = new ApiServer();
        apiServer.start();
    }
}
