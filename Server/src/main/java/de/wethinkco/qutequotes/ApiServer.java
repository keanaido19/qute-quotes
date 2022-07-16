package de.wethinkco.qutequotes;

import de.wethinkco.qutequotes.quote.QuoteController;
import io.javalin.Javalin;

import static io.javalin.apibuilder.ApiBuilder.*;

public class ApiServer {
    private final Javalin server;

    public ApiServer() {
        this.server = Javalin
                .create()
                .routes(
                        () -> {
                            path(
                                    "quote",
                                    () -> path(
                                            "{id}",
                                            () -> get(QuoteController::getOne)
                                    )
                            );
                            path(
                                    "quotes",
                                    () -> {
                                        get(QuoteController::getAll);
                                        post(QuoteController::create);
                                    }
                            );
                        }
                );
    }

    public Javalin start() {
        return this.server.start(5000);
    }

    public Javalin stop() {
        return this.server.stop();
    }

    public static void main(String[] args) {
        ApiServer apiServer = new ApiServer();
        apiServer.start();
    }
}
