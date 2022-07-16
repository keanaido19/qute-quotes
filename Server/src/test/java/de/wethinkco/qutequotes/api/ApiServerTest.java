package de.wethinkco.qutequotes.api;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcPooledConnectionSource;
import com.j256.ormlite.logger.Level;
import com.j256.ormlite.logger.Logger;
import de.wethinkco.qutequotes.dbconnect.QuoteService;
import de.wethinkco.qutequotes.quote.Quote;
import kong.unirest.HttpResponse;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;
import kong.unirest.UnirestException;
import kong.unirest.json.JSONArray;
import kong.unirest.json.JSONObject;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ApiServerTest {
    private static ApiServer server;

    @BeforeAll
    public static void startServer() {
        server = new ApiServer();
        server.start();
    }

    @AfterAll
    public static void stopServer() {
        try{

            Connection connection =
                    DriverManager.getConnection("jdbc:sqlite:Quote.sqlite");

            connection.createStatement().executeUpdate(
                    "DELETE FROM Quote WHERE id = 4"
            );

        } catch (SQLException ignored) {
        }

        server.stop();
    }

    @Test
    @DisplayName("GET /quote/{id}")
    public void getOneQuote() throws UnirestException {
        HttpResponse<JsonNode> response =
                Unirest.get("http://localhost:5000/quote/1").asJson();

        assertEquals(200, response.getStatus());
        assertEquals(
                "application/json",
                response.getHeaders().getFirst("Content-Type")
        );

        JSONObject jsonObject = response.getBody().getObject();
        assertEquals(
                "There is no snooze button on a " +
                        "cat who wants breakfast.",
                jsonObject.get("text")
        );
        assertEquals("Unknown", jsonObject.get("name"));
    }

    @Test
    @DisplayName("GET /quotes")
    void getAllQuotes() throws UnirestException {
        HttpResponse<JsonNode> response =
                Unirest.get("http://localhost:5000/quotes").asJson();
        assertEquals(200, response.getStatus());
        assertEquals(
                "application/json",
                response.getHeaders().getFirst("Content-Type")
        );

        JSONArray jsonArray = response.getBody().getArray();
        assertTrue(jsonArray.length() > 1);
    }

    @Test
    @DisplayName("POST /quotes")
    void create() throws UnirestException {
        QuoteRequest quoteRequest = new QuoteRequest();
        quoteRequest.setText("Meow");
        quoteRequest.setName("The Cat");

        HttpResponse<JsonNode> response =
                Unirest.post("http://localhost:5000/quotes")
                .header("Content-Type", "application/json")
                .body(quoteRequest)
                .asJson();

        assertEquals(201, response.getStatus());
        assertEquals(
                "/quote/4",
                response.getHeaders().getFirst("Location")
        );

        response = Unirest.get("http://localhost:5000/quote/4").asJson();
        assertEquals(200, response.getStatus());
    }

}