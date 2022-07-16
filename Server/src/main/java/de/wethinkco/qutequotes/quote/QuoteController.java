package de.wethinkco.qutequotes.quote;

import io.javalin.http.Context;
import io.javalin.http.HttpCode;

import java.sql.SQLException;

public class QuoteController {

    public static  void getAll(Context context) throws SQLException {
        context.json(QuoteService.getAll());
    }

    public static void getOne(Context context) throws SQLException {
        Integer id = context.pathParamAsClass("id", Integer.class).get();
        Quote quote = QuoteService.findById(id);
        context.json(quote);
    }

    public static void create(Context context) throws SQLException {
        QuoteRequest quoteRequest = context.bodyAsClass(QuoteRequest.class);
        Quote quote =
                QuoteService.save(
                        quoteRequest.getText(),
                        quoteRequest.getName()
                );
        context.header("Location", "/quote/" + quote.getId());
        context.status(HttpCode.CREATED);
        context.json(quote);
    }
}
