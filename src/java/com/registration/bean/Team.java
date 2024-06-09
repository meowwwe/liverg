/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registration.bean;

import com.connection.DBConnect;
import java.sql.*;

/**
 *
 * @author Meow
 */
public class Team {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 //Variable Declaration
 int teamID;
 String teamName, coachIC;

 public Team() {
 }

 public Team(int teamID, String coachIC, String teamName) {
  this.teamID = teamID;
  this.coachIC = coachIC;
  this.teamName = teamName;
 }

 public int getTeamID() {
  return teamID;
 }

 public String getCoachIC() {
  return coachIC;
 }

 public String getTeamName() {
  return teamName;
 }

 public void setTeamID(int teamID) {
  this.teamID = teamID;
 }

 public void setCoachIC(String coachIC) {
  this.coachIC = coachIC;
 }

 public void setTeamName(String teamName) {
  this.teamName = teamName;
 }

 public void addTeam(String coachIC, String teamName) throws SQLException {

  String sql = "INSERT INTO TEAM(teamName,coachIC) VALUES (?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, teamName);
  pstm.setString(2, coachIC);
  pstm.executeUpdate();
 }
}
