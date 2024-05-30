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
public class Judge {
 
 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";
 
 int judgeID, teamID;
 String judgeName, judgeNoIc, judgePOD;

 public Judge() {
 }

 public Judge(int judgeID, int teamID, String judgeName, String judgeNoIc, String judgePOD) {
  this.judgeID = judgeID;
  this.teamID = teamID;
  this.judgeName = judgeName;
  this.judgeNoIc = judgeNoIc;
  this.judgePOD = judgePOD;
 }

 public int getJudgeID() {
  return judgeID;
 }

 public int getTeamID() {
  return teamID;
 }

 public String getJudgeName() {
  return judgeName;
 }

 public String getJudgeNoIc() {
  return judgeNoIc;
 }

 public String getJudgePOD() {
  return judgePOD;
 }

 public void setJudgeID(int judgeID) {
  this.judgeID = judgeID;
 }

 public void setTeamID(int teamID) {
  this.teamID = teamID;
 }

 public void setJudgeName(String judgeName) {
  this.judgeName = judgeName;
 }

 public void setJudgeNoIc(String judgeNoIc) {
  this.judgeNoIc = judgeNoIc;
 }

 public void setJudgePOD(String judgePOD) {
  this.judgePOD = judgePOD;
 }

 public void addJudge(String judgeName, int judgeNoIc, String judgePOD) throws SQLException {

  String sql = "INSERT INTO JUDGE(judgeName,judgeNoIc,judgePOD) VALUES (?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, judgeName);
  pstm.setInt(2, judgeNoIc);
  pstm.setString(3, judgePOD);
  pstm.executeUpdate();
 }
}
