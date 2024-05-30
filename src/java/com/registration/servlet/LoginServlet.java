package com.registration.servlet;

import com.registration.bean.Clerk;
import com.registration.bean.Staff;
import com.registration.bean.headJudge;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/* @AUTHOR MUHAMMAD IRFAN */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        JSONArray list = new JSONArray();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        JSONObject obj = new JSONObject();

        Clerk clerk = new Clerk();
        Staff staff = new Staff();
        headJudge headjudge = new headJudge();

        String msg = "";
        String userRole = "";

        try {
            int staffID = staff.StoreStaffID(username, password);

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("password", password);

            if (staff.staffLogin(username, password)) {
                msg = "1";
                userRole = "staff";
                session.setAttribute("staffID", staffID);
                obj.put("staffID", staffID);
                
            } else if (clerk.clerkLogin(username, password)) {
                msg = "2";
                userRole = "clerk";
            } else if (headjudge.headjudgeLogin(username, password)) {
                msg = "3";
                userRole = "headjudge";
            } else {
                userRole = "";
            }
            session.setAttribute("userRole", userRole);

            obj.put("msg", msg);
            list.add(obj);
            out.println(list.toJSONString());

        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}