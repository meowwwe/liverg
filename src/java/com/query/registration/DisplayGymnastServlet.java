package com.query.registration;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

public class DisplayGymnastServlet extends HttpServlet {

 @Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
  // Retrieve clerkID from request parameter
  int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));

  // Database Connection
  DBConnect db = new DBConnect();
  Connection con = db.getConnection();
  PreparedStatement pstm = null;
  ResultSet rs = null;

  try {
   // Prepare query to select clerk information
   String query = "SELECT * FROM GYMNAST WHERE gymnastID = ?";
   pstm = con.prepareStatement(query);
   pstm.setInt(1, gymnastID);
   rs = pstm.executeQuery();

   // Check if gymnast information was found
   if (rs.next()) {
    int retrievedGymnastID = rs.getInt("gymnastID");
    String gymnastName = rs.getString("gymnastName");
    String gymnastIC = rs.getString("gymnastIC");
    String gymnastSchool = rs.getString("gymnastSchool");
    String gymnastCategory = rs.getString("gymnastCategory");
    String gymnastICPic = rs.getString("gymnastICPic");

    JSONObject obj = new JSONObject();
    obj.put("gymnastID", retrievedGymnastID);
    obj.put("gymnastName", gymnastName);
    obj.put("gymnastIC", gymnastIC);
    obj.put("gymnastSchool", gymnastSchool);
    obj.put("gymnastCategory", gymnastCategory);
    obj.put("gymnastICPic", gymnastICPic);

    response.setContentType("application/json");

    PrintWriter out = response.getWriter();
    out.print(obj.toString());
   } else {
    // Clerk not found, send appropriate response
    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
   }
  } catch (SQLException e) {
   e.printStackTrace();
   response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
  } finally {
   // Close resources
   try {
    if (rs != null) {
     rs.close();
    }
    if (pstm != null) {
     pstm.close();
    }
    if (con != null) {
     con.close();
    }
   } catch (SQLException ex) {
    ex.printStackTrace();
   }
  }
 }
}
