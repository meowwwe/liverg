/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registration.bean;

import com.connection.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Meow
 */
public class Staff {

    //Database Connection
    DBConnect db = new DBConnect();
    Connection con = db.getConnection();
    //PreparedStatement
    PreparedStatement pstm;
    //ResultQuery
    ResultSet rs;
    String userRole = "";

    int staffID, clerkID;
    String staffUsername, staffPassword;

    public Staff() {
    }

    public Staff(int staffID, int clerkID, String staffUsername, String staffPassword) {
        this.staffID = staffID;
        this.clerkID = clerkID;
        this.staffUsername = staffUsername;
        this.staffPassword = staffPassword;
    }

    public Staff(int staffID) {
        this.staffID = staffID;
    }

    public int getStaffID() {
        return staffID;
    }

    public int getClerkID() {
        return clerkID;
    }

    public String getStaffUsername() {
        return staffUsername;
    }

    public String getStaffPassword() {
        return staffPassword;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public void setClerkID(int clerkID) {
        this.clerkID = clerkID;
    }

    public void setStaffUsername(String staffUsername) {
        this.staffUsername = staffUsername;
    }

    public void setStaffPassword(String staffPassword) {
        this.staffPassword = staffPassword;
    }

    //Staff Login Query
    public boolean staffLogin(String username, String password) throws SQLException {
        pstm = con.prepareStatement("SELECT staffID,staffPassword FROM STAFF WHERE staffUsername = ? AND staffPassword = ?");
        pstm.setString(1, username);
        pstm.setString(2, password);
        rs = pstm.executeQuery();

        boolean loggedIn = rs.next();
        if (loggedIn) {
            userRole = "staff";
        }
        return loggedIn;
    }

    public int StoreStaffID(String username, String password) throws SQLException {
        pstm = con.prepareStatement("SELECT staffID FROM STAFF WHERE staffUsername = ? AND staffPassword = ?");
        pstm.setString(1, username);
        pstm.setString(2, password);
        rs = pstm.executeQuery();

        if (rs.next()) {
            return rs.getInt("staffID");
        } else {
            return -1;
        }
    }

}
