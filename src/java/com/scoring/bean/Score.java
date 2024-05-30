/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Score {
    int scoreID,judgeID;
    double scoreD,scoreA,scoreE,technicalDeduction;

    public Score(double scoreD, double scoreA, double scoreE, double technicalDeduction) {
        this.scoreD = scoreD;
        this.scoreA = scoreA;
        this.scoreE = scoreE;
        this.technicalDeduction = technicalDeduction;
    }
    
    
}
