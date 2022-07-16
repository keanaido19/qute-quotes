package de.wethinkco.qutequotes.dbconnect;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcPooledConnectionSource;
import com.j256.ormlite.logger.Level;
import com.j256.ormlite.logger.Logger;
import com.j256.ormlite.table.TableUtils;
import de.wethinkco.qutequotes.quote.Quote;

import java.sql.SQLException;
import java.util.List;

public class QuoteService {
    private static final JdbcPooledConnectionSource connectionSource;
    private static final Dao<Quote, Integer> quoteDao;

    static {
        try {
            Logger.setGlobalLogLevel(Level.ERROR);

            connectionSource =
                    new JdbcPooledConnectionSource(
                            "jdbc:sqlite:Quote.sqlite"
                    );

            quoteDao = DaoManager.createDao(connectionSource, Quote.class);

            TableUtils.createTableIfNotExists(connectionSource, Quote.class);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<Quote> getAll() throws SQLException {
        return quoteDao.queryForAll();
    }

    public static Quote save(String text, String name) throws SQLException {
        Quote quote = new Quote();
        quote.setText(text);
        quote.setName(name);
        quoteDao.create(quote);
        quoteDao.update(quote);
        return quote;
    }

    public static Quote findById(Integer id) throws SQLException {
        return quoteDao.queryForId(id);
    }
}
