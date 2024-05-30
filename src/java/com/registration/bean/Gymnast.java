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

/**
 *
 * @author Meow
 */
public class Gymnast {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 int gymnastID, gymnastIC, clerkID, teamID;
 String gymnastICPic, gymnastName, gymnastSchool, gymnastCategory;

 public Gymnast() {
 }

 public Gymnast(int gymnastID, int gymnastIC, String gymnastICPic, String gymnastName, String gymnastSchool, String gymnastCategory, int clerkID, int teamID) {
  this.gymnastID = gymnastID;
  this.gymnastIC = gymnastIC;
  this.gymnastICPic = gymnastICPic;
  this.gymnastName = gymnastName;
  this.gymnastSchool = gymnastSchool;
  this.gymnastCategory = gymnastCategory;
  this.clerkID = clerkID;
  this.teamID = teamID;
 }

 public int getGymnastID() {
  return gymnastID;
 }

 public void setGymnastID(int gymnastID) {
  this.gymnastID = gymnastID;
 }

 public int getGymnastIC() {
  return gymnastIC;
 }

 public void setGymnastIC(int gymnastIC) {
  this.gymnastIC = gymnastIC;
 }

 public int getClerkID() {
  return clerkID;
 }

 public void setClerkID(int clerkID) {
  this.clerkID = clerkID;
 }

 public int getTeamID() {
  return teamID;
 }

 public void setTeamID(int teamID) {
  this.teamID = teamID;
 }

 public String getGymnastICPic() {
  return gymnastICPic;
 }

 public void setGymnastICPic(String gymnastICPic) {
  this.gymnastICPic = gymnastICPic;
 }

 public String getGymnastName() {
  return gymnastName;
 }

 public void setGymnastName(String gymnastName) {
  this.gymnastName = gymnastName;
 }

 public String getGymnastSchool() {
  return gymnastSchool;
 }

 public void setGymnastSchool(String gymnastSchool) {
  this.gymnastSchool = gymnastSchool;
 }

 public String getGymnastCategory() {
  return gymnastCategory;
 }

 public void setGymnastCategory(String gymnastCategory) {
  this.gymnastCategory = gymnastCategory;
 }

 public void addGymnast(String gymnastName, int gymnastIC, String gymnastICPic, String gymnastSchool, String gymnastCategory) throws SQLException {

  String sql = "INSERT INTO GYMNAST(gymnastName,gymnastIC,gymnastICPic,gymnastSchool,gymnastCategory) VALUES (?,?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, gymnastName);
  pstm.setInt(2, gymnastIC);
  pstm.setString(3, gymnastICPic);
  pstm.setString(4, gymnastSchool);
  pstm.setString(5, gymnastCategory);
  pstm.executeUpdate();
 }

}
