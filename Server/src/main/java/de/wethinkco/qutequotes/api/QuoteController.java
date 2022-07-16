package de.wethinkco.qutequotes.api;

import de.wethinkco.qutequotes.dbconnect.QuoteService;
import de.wethinkco.qutequotes.quote.Quote;
import io.javalin.http.*;
import io.javalin.plugin.openapi.annotations.*;

public class QuoteController {

    @OpenApi(
            summary = "Get all quotes.",
            operationId = "getAllQuotes",
            path = "/quotes",
            method = HttpMethod.GET,
            tags = {"Quote"},
            responses = {
                    @OpenApiResponse(
                            status = "200",
                            content = {
                                    @OpenApiContent(
                                            from = Quote[].class
                                    )
                            }
                    ),
                    @OpenApiResponse(
                            status = "500",
                            content = {
                                    @OpenApiContent(
                                            from = ErrorResponse.class
                                    )
                            }
                    )
            }

    )
    public static  void getAll(Context context) {
        try {
            context.json(QuoteService.getAll());
        } catch (Exception e) {
            throw new InternalServerErrorResponse();
        }
    }

    @OpenApi(
            summary = "Get a quote by ID.",
            operationId = "getQuoteByID",
            path = "/quote/{id}",
            method = HttpMethod.GET,
            pathParams = {
                    @OpenApiParam(
                            name = "id",
                            type = Integer.class,
                            description = "The quote ID"
                    )
            },
            tags = {"Quote"},
            responses = {
                    @OpenApiResponse(
                            status = "200",
                            content = {
                                    @OpenApiContent(
                                            from = Quote.class
                                    )
                            }
                    ),
                    @OpenApiResponse(
                            status = "404",
                            content = {
                                    @OpenApiContent(
                                            from = ErrorResponse.class
                                    )
                            }
                    )
            }

    )
    public static void getOne(Context context) {
        try {
            Integer id = context.pathParamAsClass("id", Integer.class).get();
            Quote quote = QuoteService.findById(id);
            context.json(quote);
        } catch (Exception e) {
            throw new NotFoundResponse();
        }
    }

    @OpenApi(
            summary = "Create a quote.",
            operationId = "createQuote",
            path = "/quotes",
            method = HttpMethod.POST,
            tags = {"Quote"},
            requestBody = @OpenApiRequestBody(
                    content = {
                            @OpenApiContent(from = QuoteRequest.class)
                    }
            ),
            responses = {
                    @OpenApiResponse(
                            status = "200",
                            content = {
                                    @OpenApiContent(
                                            from = Quote.class
                                    )
                            }
                    ),
                    @OpenApiResponse(
                            status = "400",
                            content = {
                                    @OpenApiContent(
                                            from = ErrorResponse.class
                                    )
                            }
                    )
            }

    )
    public static void create(Context context) {
        try {
            QuoteRequest quoteRequest = context.bodyAsClass(QuoteRequest.class);
            Quote quote =
                    QuoteService.save(
                            quoteRequest.getText(),
                            quoteRequest.getName()
                    );
            context.header("Location", "/quote/" + quote.getId());
            context.status(HttpCode.CREATED);
            context.json(quote);
        } catch (Exception e) {
            throw new BadRequestResponse();
        }
    }
}
