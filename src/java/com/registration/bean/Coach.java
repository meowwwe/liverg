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
public class Coach {
 //Database Connection

 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 int coachIC, fisioIC;
 String coachName, coachPOD, fisioName, fisioPOD;

 public Coach() {
 }

 public Coach(int coachIC, int fisioIC, String coachName, String coachPOD, String fisioName, String fisioPOD) {
  this.coachIC = coachIC;
  this.fisioIC = fisioIC;
  this.coachName = coachName;
  this.coachPOD = coachPOD;
  this.fisioName = fisioName;
  this.fisioPOD = fisioPOD;
 }

 public String getUserRole() {
  return userRole;
 }

 public int getCoachIC() {
  return coachIC;
 }

 public int getFisioIC() {
  return fisioIC;
 }

 public String getCoachName() {
  return coachName;
 }

 public String getCoachPOD() {
  return coachPOD;
 }

 public String getFisioName() {
  return fisioName;
 }

 public String getFisioPOD() {
  return fisioPOD;
 }

 public void setUserRole(String userRole) {
  this.userRole = userRole;
 }

 public void setCoachIC(int coachIC) {
  this.coachIC = coachIC;
 }

 public void setFisioIC(int fisioIC) {
  this.fisioIC = fisioIC;
 }

 public void setCoachName(String coachName) {
  this.coachName = coachName;
 }

 public void setCoachPOD(String coachPOD) {
  this.coachPOD = coachPOD;
 }

 public void setFisioName(String fisioName) {
  this.fisioName = fisioName;
 }

 public void setFisioPOD(String fisioPOD) {
  this.fisioPOD = fisioPOD;
 }

 public void addCoach(int coachIC, int fisioIC, String coachName, String coachPOD, String fisioName, String fisioPOD) throws SQLException {

  String sql = "INSERT INTO COACH(coachIC,fisioIC,coachName,coachPOD,fisioName,fisioPOD) VALUES (?,?,?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setInt(1, coachIC);
  pstm.setInt(2, fisioIC);
  pstm.setString(3, coachName);
  pstm.setString(4, coachPOD);
  pstm.setString(5, fisioName);
  pstm.setString(6, fisioPOD);
  pstm.executeUpdate();
 }
}
