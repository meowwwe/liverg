package com.query.registration;

import com.connection.DBConnect;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;

@MultipartConfig(maxFileSize = 16177215) // 16MB
public class UpdateGymnastServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateGymnastServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;

        JSONObject obj = new JSONObject();

        try {
            con = db.getConnection();
            
            int updateGymnastID = Integer.parseInt(request.getParameter("updateGymnastID"));
            String updateGymnastIC = request.getParameter("updateGymnastIC");
            int updateGymnastTeam = Integer.parseInt(request.getParameter("updateGymnastTeam"));
            int updateGymnastApparatusID = Integer.parseInt(request.getParameter("updateGymnastApparatusID"));
            String updateGymnastName = request.getParameter("updateGymnastName");
            String updateGymnastSchool = request.getParameter("updateGymnastSchool");
            String updateGymnastCategory = request.getParameter("updateGymnastCategory");
            Part filePart = request.getPart("updateGymnastPic");

            // Construct new filename based on user's name and IC number
            String filename = updateGymnastName.replaceAll("\\s+", "") + "_" + updateGymnastIC;
            String newFileName = null; // Initialize newFileName

            if (filePart != null && filePart.getSize() > 0) { // Check if file is uploaded
                // Check if file is an image
                String contentType = filePart.getContentType();
                if (contentType == null || !contentType.startsWith("image")) {
                    throw new IllegalArgumentException("Only image files are allowed.");
                }

                String imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";
                int lastDotIndex = imageFileName.lastIndexOf('.');
                if (lastDotIndex != -1) {
                    fileExtension = imageFileName.substring(lastDotIndex);
                }
                newFileName = filename + fileExtension;

                // Process the new file upload
                String uploadDir = getServletContext().getRealPath("/../../web/registration/uploads/");
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists() && !uploadDirFile.mkdirs()) {
                    throw new IOException("Failed to create directory: " + uploadDir);
                }

                // Construct the full path of the existing file
                String existingFileName = null;
                String selectQuery = "SELECT gymnastIcPic FROM GYMNAST WHERE gymnastID = ?";
                pstm = con.prepareStatement(selectQuery);
                pstm.setInt(1, updateGymnastID);
                rs = pstm.executeQuery();

                if (rs.next()) {
                    existingFileName = rs.getString("gymnastIcPic");
                }
                rs.close();
                pstm.close();

                // Delete the existing file from the server
                if (existingFileName != null && !existingFileName.isEmpty()) {
                    File existingFile = new File(uploadDir + File.separator + existingFileName);
                    if (existingFile.exists() && existingFile.delete()) {
                        LOGGER.log(Level.INFO, "Deleted old file: " + existingFileName);
                    } else {
                        LOGGER.log(Level.WARNING, "Failed to delete the existing file: " + existingFileName);
                    }
                }

                // Upload new file
                String uploadPath = uploadDir + File.separator + newFileName;
                try (FileOutputStream fos = new FileOutputStream(uploadPath); InputStream is = filePart.getInputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }
            }

            // Update the database with the new file path (if uploaded)
            String updateQuery;
            if (newFileName != null) { // Check if new file is uploaded
                updateQuery = "UPDATE GYMNAST G JOIN GYMNAST_APP GA ON G.GYMNASTID = GA.GYMNASTID SET gymnastName = ?, gymnastIC = ?, gymnastIcPic = ?, gymnastSchool = ?, gymnastCategory = ?, apparatusID = ?, teamID = ? WHERE G.gymnastID = ?";
            } else {
                updateQuery = "UPDATE GYMNAST G JOIN GYMNAST_APP GA ON G.GYMNASTID = GA.GYMNASTID SET gymnastName = ?, gymnastIC = ?, gymnastSchool = ?, gymnastCategory = ?, apparatusID = ?, teamID = ? WHERE G.gymnastID = ?";
            }
            pstm = con.prepareStatement(updateQuery);
            pstm.setString(1, updateGymnastName);
            pstm.setString(2, updateGymnastIC);
            if (newFileName != null) { // Check if new file is uploaded
                pstm.setString(3, newFileName); // Set the new file name
                pstm.setString(4, updateGymnastSchool);
                pstm.setString(5, updateGymnastCategory);
                pstm.setInt(6, updateGymnastApparatusID);
                pstm.setInt(7, updateGymnastTeam);
                pstm.setInt(8, updateGymnastID);
            } else {
                pstm.setString(3, updateGymnastSchool);
                pstm.setString(4, updateGymnastCategory);
                pstm.setInt(5, updateGymnastApparatusID);
                pstm.setInt(6, updateGymnastTeam);
                pstm.setInt(7, updateGymnastID);
            }

            int rowsAffected = pstm.executeUpdate();

            if (rowsAffected > 0) {
                obj.put("success", true);
                obj.put("message", "Gymnast updated successfully");
            } else {
                obj.put("success", false);
                obj.put("message", "Failed to update gymnast");
            }

            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print(obj.toJSONString());
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL error: ", e);
            obj.put("success", false);
            obj.put("message", "SQL error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print(obj.toJSONString());
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "IO error: ", e);
            obj.put("success", false);
            obj.put("message", "IO error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            try (PrintWriter out = response.getWriter()) {
                out.print(obj.toJSONString());
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
                LOGGER.log(Level.SEVERE, "SQL error on close: ", ex);
            }
        }
    }
}
