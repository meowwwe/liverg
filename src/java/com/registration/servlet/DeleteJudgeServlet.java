package com.registration.servlet;

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

public class DeleteJudgeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get the clerk ID from request parameters
        int judgeID = Integer.parseInt(request.getParameter("judgeID"));

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            // Prepare and execute delete query
            String query = "DELETE FROM JUDGE WHERE judgeID = ?";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, judgeID);
            int rowsAffected = pstm.executeUpdate();

            // Send response indicating success or failure
            PrintWriter out = response.getWriter();
            if (rowsAffected > 0) {
                out.println("JUDGE deleted successfully");
            } else {
                out.println("Failed to delete JUDGE");
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
