package com.registration.servlet;

import com.registration.bean.Gymnast;
import java.io.*;
import java.util.logging.*;
import java.nio.file.Paths;
import jakarta.servlet.http.*;
import org.json.simple.*;
import jakarta.servlet.ServletException;
import java.sql.SQLException;
import jakarta.servlet.annotation.MultipartConfig;

@MultipartConfig
public class AddGymnastServlet extends HttpServlet {

 private static final long serialVersionUID = 1L;
 private static final Logger logger = Logger.getLogger(AddGymnastServlet.class.getName());

 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

  PrintWriter out = response.getWriter();
  JSONArray list = new JSONArray();
  JSONObject obj = new JSONObject();

  String msg = "";

  try {
   // Retrieve and log parameters
   String gymnastName = request.getParameter("gymnastName");
   String gymnastICStr = request.getParameter("gymnastIC");
   String gymnastCategory = request.getParameter("gymnastCategory");
   String gymnastSchool = request.getParameter("gymnastSchool");
   Part filePart = request.getPart("gymnastPic");

   logger.log(Level.INFO, "gymnastName: {0}", gymnastName);
   logger.log(Level.INFO, "gymnastICStr: {0}", gymnastICStr);
   logger.log(Level.INFO, "gymnastCategory: {0}", gymnastCategory);
   logger.log(Level.INFO, "gymnastSchool: {0}", gymnastSchool);
   logger.log(Level.INFO, "filePart: {0}", filePart);

   // Validate parameters
   if (gymnastName == null || gymnastICStr == null || gymnastCategory == null || gymnastSchool == null || filePart == null) {
    throw new IllegalArgumentException("Missing required form parameters.");
   }

   // Check if file is an image
   String contentType = filePart.getContentType();
   if (contentType == null || !contentType.startsWith("image")) {
    throw new IllegalArgumentException("Only image files are allowed.");
   }

   // Convert gymnastICStr to integer
   int gymnastIC;
   try {
    gymnastIC = Integer.parseInt(gymnastICStr);
    logger.log(Level.INFO, "Converted gymnastIC: {0}", gymnastIC);
   } catch (NumberFormatException e) {
    throw new IllegalArgumentException("Invalid gymnast IC format.", e);
   }

   // Process the file upload
   String imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
   // Construct new filename based on user's name and IC number
   String filename = gymnastName.replaceAll("\\s+", "") + "_" + gymnastIC;
   String fileExtension = "";
   int lastDotIndex = imageFileName.lastIndexOf('.');
   if (lastDotIndex != -1) {
    fileExtension = imageFileName.substring(lastDotIndex);
   }
   String newFileName = filename + fileExtension;

   logger.log(Level.INFO, "New file name: {0}", newFileName);

   String uploadDir = getServletContext().getRealPath("/../../web/registration/uploads/");
   File uploadDirFile = new File(uploadDir);
   if (!uploadDirFile.exists()) {
    if (!uploadDirFile.mkdirs()) {
     throw new IOException("Failed to create directory: " + uploadDir);
    }
   }
   String uploadPath = uploadDir + File.separator + newFileName;

   logger.log(Level.INFO, "Upload Path: {0}", uploadPath);

   // Upload file
   try (FileOutputStream fos = new FileOutputStream(uploadPath); InputStream is = filePart.getInputStream()) {

    byte[] buffer = new byte[1024];
    int bytesRead;
    while ((bytesRead = is.read(buffer)) != -1) {
     fos.write(buffer, 0, bytesRead);
    }
    logger.log(Level.INFO, "File uploaded successfully to: {0}", uploadPath);
   }

   // Add gymnast to the database
   Gymnast gymnast = new Gymnast();
   try {
    gymnast.addGymnast(gymnastName, gymnastIC, newFileName, gymnastSchool, gymnastCategory);
    msg = "1";  // Success
    logger.log(Level.INFO, "Gymnast added successfully.");
   } catch (SQLException ex) {
    msg = "2";  // Database error
    logger.log(Level.SEVERE, "Database error", ex);
   }

  } catch (IllegalArgumentException e) {
   msg = "3";  // Invalid or missing parameters
   logger.log(Level.WARNING, "Invalid or missing parameters", e);
  } catch (IOException e) {
   msg = "4";  // File upload error
   logger.log(Level.SEVERE, "File upload error", e);
  } catch (Exception e) {
   msg = "5";  // Other error
   logger.log(Level.SEVERE, "An unexpected error occurred", e);
  }

  // Send JSON response
  obj.put("msg", msg);
  list.add(obj);
  out.println(list.toJSONString());
 }
}
