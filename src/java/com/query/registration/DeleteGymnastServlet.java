package com.query.registration;

import com.connection.DBConnect;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

public class DeleteGymnastServlet extends HttpServlet {

 @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
  // Get the gymnast ID from request parameters
  int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));

  // Database Connection
  DBConnect db = new DBConnect();
  Connection con = db.getConnection();
  PreparedStatement pstm = null;

  try {
   // Retrieve the filename associated with the gymnast
   String fileName = null;
   String selectQuery = "SELECT gymnastIcPic FROM GYMNAST WHERE gymnastID = ?";
   pstm = con.prepareStatement(selectQuery);
   pstm.setInt(1, gymnastID);
   ResultSet rs = pstm.executeQuery();
   if (rs.next()) {
    fileName = rs.getString("gymnastIcPic");
   }
   rs.close();
   pstm.close();

   // Delete the file from the folder
   if (fileName != null) {
    String uploadDir = getServletContext().getRealPath("/../../web/registration/uploads/");
    String filePath = uploadDir + File.separator + fileName;
    Files.deleteIfExists(Paths.get(filePath));
   }

   // Prepare and execute delete query
   String query = "DELETE FROM GYMNAST WHERE gymnastID = ?";
   pstm = con.prepareStatement(query);
   pstm.setInt(1, gymnastID);
   int rowsAffected = pstm.executeUpdate();

   // Send response indicating success or failure
   PrintWriter out = response.getWriter();
   if (rowsAffected > 0) {
    out.println("Gymnast deleted successfully");
   } else {
    out.println("Failed to delete Gymnast");
   }

  } catch (SQLException e) {
   e.printStackTrace();
   response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
  } finally {
   // Close resources
   try {
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
