package com.query.registration;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

public class UpdateClerkServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        int clerkID = Integer.parseInt(request.getParameter("updateClerkID"));
        String username = request.getParameter("updateClerkName");
        String password = request.getParameter("updateClerkPassword");
        String name = request.getParameter("updateName");

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            
            String query = "UPDATE CLERK SET clerkUsername = ?, clerkPassword = ?, clerkName = ? WHERE clerkID = ?";
            pstm = con.prepareStatement(query);
            pstm.setString(1, username);
            pstm.setString(2, password);
            pstm.setString(3, name);
            pstm.setInt(4, clerkID);
            int rowsAffected = pstm.executeUpdate();

            // Send JSON response indicating success or failure
            JSONObject obj = new JSONObject();
            if (rowsAffected > 0) {
                obj.put("success", true);
                obj.put("message", "Clerk updated successfully");
            } else {
                obj.put("success", false);
                obj.put("message", "Failed to update clerk");
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(obj.toJSONString());
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
