// This program demonstrates how to handle errors in MySQL JDBC programs.
// - The exception handler for connection setup and for the query shows how to
//   get Exception information, plus any additional SQLException information.
// - The query processor shows how to print information for any SQLWarnings
//   (nonfatal errors) that occur.

//#@ _FRAG_
// Error.java - demonstrate MySQL error-handling

import java.sql.*;

public class Error
{
  public static void main (String[] args)
  {
    Connection conn = null;
    String url = "jdbc:mysql://localhost/cookbook";
    String userName = "cbuser";
    String password = "cbpass";

    try
    {
      Class.forName ("com.mysql.jdbc.Driver").newInstance ();
      conn = DriverManager.getConnection (url, userName, password);
      System.out.println ("Connected");
      tryQuery (conn);    // issue a query
    }
    catch (Exception e)
    {
      System.err.println ("Cannot connect to server");
      System.err.println (e);
      if (e instanceof SQLException)  // JDBC-specific exception?
      {
        // print general message, plus any database-specific message
        // (e must be cast from Exception to SQLException to
        // access the SQLException-specific methods)
        System.err.println ("SQLException: " + e.getMessage ());
        System.err.println ("SQLState: "
                            + ((SQLException) e).getSQLState ());
        System.err.println ("VendorCode: "
                            + ((SQLException) e).getErrorCode ());
      }
    }
    finally
    {
      if (conn != null)
      {
        try
        {
          conn.close ();
          System.out.println ("Disconnected");
        }
        catch (SQLException e)
        {
          // print general message, plus any database-specific message
          System.err.println ("SQLException: " + e.getMessage ());
          System.err.println ("SQLState: " + e.getSQLState ());
          System.err.println ("VendorCode: " + e.getErrorCode ());
        }
      }
    }
  }

  public static void tryQuery (Connection conn)
  {
    try
    {
      // issue a simple query
      Statement s = conn.createStatement ();
      s.execute ("USE cookbook");
      s.close ();

      // print any accumulated warnings
      SQLWarning w = conn.getWarnings ();
      while (w != null)
      {
        System.err.println ("SQLWarning: " + w.getMessage ());
        System.err.println ("SQLState: " + w.getSQLState ());
        System.err.println ("VendorCode: " + w.getErrorCode ());
        w = w.getNextWarning ();
      }
    }
    catch (SQLException e)
    {
      // print general message, plus any database-specific message
      System.err.println ("SQLException: " + e.getMessage ());
      System.err.println ("SQLState: " + e.getSQLState ());
      System.err.println ("VendorCode: " + e.getErrorCode ());
    }
  }
}
//#@ _FRAG_
