/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao.scoring;

import com.scoring.bean.Apparatus;
import com.scoring.bean.Composite;
import com.scoring.bean.Gymnast;
import com.scoring.bean.Score;
import com.scoring.bean.Team;
import com.connection.DBConnect;
import com.query.scoring.QueryLiveScore;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class LiveScoreDAO extends QueryLiveScore {

    DBConnect db = new DBConnect();

    public String getAllLiveScore() {
        return "\"SELECT g.gymnastName, t.teamName, a.apparatusName, \\n\" +\n"
                + "\"  scoreD + scoreA + scoreE - technicalDeduction AS totalScore,  -- Calculate total score\\n\" +\n"
                + "\"  scoreD, scoreA, scoreE, technicalDeduction  -- Individual scores and deduction\\n\" +\n"
                + "\"FROM GYMNAST g  -- Assuming gymnast name is in the GYMNAST table\\n\" +\n"
                + "\"INNER JOIN TEAM t ON g.teamID = t.teamID  -- Join gymnast with their team\\n\" +\n"
                + "\"INNER JOIN GYMNAST_APP ga ON g.gymnastID = ga.gymnastID  -- Connect gymnasts with their apparatuses\\n\" +\n"
                + "\"INNER JOIN APPARATUS a ON ga.apparatusID = a.apparatusID  -- Identify the apparatus\\n\" +\n"
                + "\"INNER JOIN COMPOSITE c ON ga.gymnastID = c.gymnastID AND ga.apparatusID = c.apparatusID \\n\" +\n"
                + "\"  -- Link gymnast-apparatus to COMPOSITE table\\n\" +\n"
                + "\"INNER JOIN SCORE s ON c.scoreID = s.scoreID  -- Link score details\\n\" +\n"
                + "\"GROUP BY g.gymnastName, t.teamName, a.apparatusName  -- Include teamName in GROUP BY\\n\" +\n"
                + "\"ORDER BY g.gymnastName, t.teamName, a.apparatusName;\";";
    }

    public String getLiveScoreByTeamName() {
        return "SELECT g.gymnastName, t.teamName, a.apparatusName, scoreD + scoreA + scoreE - technicalDeduction AS totalScore,\n"
                + "scoreD, scoreA, scoreE, technicalDeduction FROM GYMNAST g INNER JOIN TEAM t ON g.teamID = t.teamID \n"
                + "INNER JOIN GYMNAST_APP ga ON g.gymnastID = ga.gymnastID  \n"
                + "INNER JOIN APPARATUS a ON ga.apparatusID = a.apparatusID  \n"
                + "INNER JOIN COMPOSITE c ON ga.gymnastID = c.gymnastID AND ga.apparatusID = c.apparatusID\n"
                + " INNER JOIN SCORE s ON c.scoreID = s.scoreID \n"
                + " WHERE t.teamName = ?\n"
                + " ORDER BY g.gymnastName, t.teamName, a.apparatusName;";
    }
    
    
    public String getAllTeam(){
        return "SELECT * FROM team";
    }
    
    public String getAllGymnast(){
    return "SELECT * FROM gymnast";
    }
    
    public String getLiveScoreByTeamNameAndGymnastName(){
    return "SELECT g.gymnastName, t.teamName, a.apparatusName, scoreD + scoreA + scoreE - technicalDeduction AS totalScore,\n"
                + "scoreD, scoreA, scoreE, technicalDeduction FROM GYMNAST g INNER JOIN TEAM t ON g.teamID = t.teamID \n"
                + "INNER JOIN GYMNAST_APP ga ON g.gymnastID = ga.gymnastID  \n"
                + "INNER JOIN APPARATUS a ON ga.apparatusID = a.apparatusID  \n"
                + "INNER JOIN COMPOSITE c ON ga.gymnastID = c.gymnastID AND ga.apparatusID = c.apparatusID\n"
                + " INNER JOIN SCORE s ON c.scoreID = s.scoreID \n"
                + " WHERE t.teamName = ? AND g.gymnastName = ? \n"
                + " ORDER BY g.gymnastName, t.teamName, a.apparatusName;";
    }

    public List<Composite> getAllDataLiveScore() {

        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllLiveScore())) {
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                String gymnastName = rs.getString("gymnastName");
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");
                double totalScore = rs.getDouble("totalScore");
                double scoreD = rs.getDouble("scoreD");
                double scoreA = rs.getDouble("scoreA");
                double scoreE = rs.getDouble("scoreE");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD, scoreA, scoreE, technicalDeduction));
                gymnast.add(new Gymnast(gymnastName));
                apparatus.add(new Apparatus(apparatusName));
                team.add(new Team(teamName));

                liveScoreData.add(new Composite(compositeID, totalScore, score, gymnast, apparatus, team));

            }
        } catch (SQLException e) {
            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByName(String teamName) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByTeamName())) {

            pst.setString(1, teamName);
            ResultSet rs = pst.executeQuery();
            
            while(rs.next()){
                     int compositeID = rs.getInt("compositeID");
                String gymnastName = rs.getString("gymnastName");
                String apparatusName = rs.getString("apparatusName");
                double totalScore = rs.getDouble("totalScore");
                double scoreD = rs.getDouble("scoreD");
                double scoreA = rs.getDouble("scoreA");
                double scoreE = rs.getDouble("scoreE");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD, scoreA, scoreE, technicalDeduction));
                gymnast.add(new Gymnast(gymnastName));
                apparatus.add(new Apparatus(apparatusName));
                team.add(new Team(teamName));

                liveScoreData.add(new Composite(compositeID, totalScore, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    
       public List<Composite> getAllDataLiveScoreByTeamAndGymnast(String teamName,String gymnastName) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByTeamName())) {

            pst.setString(1, teamName);
            pst.setString(2, gymnastName);
            ResultSet rs = pst.executeQuery();
            
            while(rs.next()){
                     int compositeID = rs.getInt("compositeID");
                String apparatusName = rs.getString("apparatusName");
                double totalScore = rs.getDouble("totalScore");
                double scoreD = rs.getDouble("scoreD");
                double scoreA = rs.getDouble("scoreA");
                double scoreE = rs.getDouble("scoreE");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD, scoreA, scoreE, technicalDeduction));
                gymnast.add(new Gymnast(gymnastName));
                apparatus.add(new Apparatus(apparatusName));
                team.add(new Team(teamName));

                liveScoreData.add(new Composite(compositeID, totalScore, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    
      public List <Gymnast> listAllGymnast(){
          List <Gymnast> gyms = new ArrayList<>();
          
          try(Connection con = db.getConnection();
                  PreparedStatement pst = con.prepareStatement(getAllGymnast())){
              ResultSet rs = pst.executeQuery();
              
              while(rs.next()){
                  String name = rs.getString("gymnastName");
                  
                  gyms.add( new Gymnast(name));
              }
              
              
          }catch(SQLException e){
              printSQLException(e);
          }
          return gyms;
      }
      
          public List <Team> listAllTeam(){
          List <Team> team = new ArrayList<>();
          
          try(Connection con = db.getConnection();
                  PreparedStatement pst = con.prepareStatement(getAllGymnast())){
              ResultSet rs = pst.executeQuery();
              
              while(rs.next()){
                  String name = rs.getString("teamName");
                  
                  team.add( new Team(name));
              }
              
              
          }catch(SQLException e){
              printSQLException(e);
          }
          return team;
      }
          
          

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());

                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
