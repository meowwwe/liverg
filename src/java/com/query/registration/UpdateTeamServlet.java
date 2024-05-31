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

public class UpdateTeamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int oldCoachIC = Integer.parseInt(request.getParameter("oldCoachIC"));
        int updateCoachIC = Integer.parseInt(request.getParameter("updateCoachIC"));
        int updateFisioIC = Integer.parseInt(request.getParameter("updateFisioIC"));

        String updateCoachName = request.getParameter("updateCoachName");
        String updateCoachPOD = request.getParameter("updateCoachPOD");
        String updateFisioName = request.getParameter("updateFisioName");
        String updateFisioPOD = request.getParameter("updateFisioPOD");
        String updateTeamName = request.getParameter("updateTeamName");

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            con.setAutoCommit(false); // Start transaction

            // Check if the new coachIC exists
            String checkCoachQuery = "SELECT COUNT(*) FROM COACH WHERE coachIC = ?";
            pstm = con.prepareStatement(checkCoachQuery);
            pstm.setInt(1, updateCoachIC);
            rs = pstm.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count == 0) {
                // Insert a placeholder for the new coachIC if it doesn't exist
                String insertCoachQuery = "INSERT INTO COACH (coachIC) VALUES (?)";
                pstm = con.prepareStatement(insertCoachQuery);
                pstm.setInt(1, updateCoachIC);
                pstm.executeUpdate();
            }

            // Update the team details
            String queryTeam = "UPDATE TEAM SET teamName = ? WHERE coachIC = ?";
            pstm = con.prepareStatement(queryTeam);
            pstm.setString(1, updateTeamName);
            pstm.setInt(2, oldCoachIC);
            int rowsAffectedTeam = pstm.executeUpdate();

            // Update the coach and fisiotherapist details if coachIC is being updated
            int rowsAffectedCoach = 0;
            if (updateCoachIC != oldCoachIC || !updateCoachName.equals("") || !updateCoachPOD.equals("") || !updateFisioName.equals("") || !updateFisioPOD.equals("")) {
                String queryCoach = "UPDATE COACH SET coachIC = ?, fisioIC = ?, coachName = ?, coachPOD = ?, fisioName = ?, fisioPOD = ? WHERE coachIC = ?";
                pstm = con.prepareStatement(queryCoach);
                pstm.setInt(1, updateCoachIC);
                pstm.setInt(2, updateFisioIC);
                pstm.setString(3, updateCoachName);
                pstm.setString(4, updateCoachPOD);
                pstm.setString(5, updateFisioName);
                pstm.setString(6, updateFisioPOD);
                pstm.setInt(7, oldCoachIC);
                rowsAffectedCoach = pstm.executeUpdate();
            } else {
                // If coachIC is not being updated and no coach-related fields are changed, set rowsAffectedCoach to 1
                rowsAffectedCoach = 1;
            }

            if (rowsAffectedTeam > 0 && rowsAffectedCoach > 0) {
                // Commit transaction if all operations were successful
                con.commit();

                // Send JSON response indicating success
                JSONObject obj = new JSONObject();
                obj.put("success", true);
                obj.put("message", "Team updated successfully");
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(obj.toJSONString());
            } else {
                con.rollback();
                // Send JSON response indicating failure
                JSONObject obj = new JSONObject();
                obj.put("success", false);
                obj.put("message", "Failed to update team and/or coach");
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(obj.toJSONString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            // Send error JSON response
            JSONObject obj = new JSONObject();
            obj.put("success", false);
            obj.put("message", "Internal server error: " + e.getMessage());
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(obj.toJSONString());

            try {
                con.rollback(); // Rollback transaction in case of error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
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
