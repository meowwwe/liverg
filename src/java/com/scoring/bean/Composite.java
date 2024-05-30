/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

import java.util.List;

/**
 *
 * @author USER
 */
public class Composite {

    int compositeID;
    double finalScore;
    private List<Score> score;
    private List<Gymnast> gymnast;
    private List<Apparatus> Apparatus;
    private List<Team> team;

    public Composite(int compositeID, double finalScore, List<Score> score, List<Gymnast> gymnast, List<Apparatus> Apparatus, List<Team> team) {
        this.compositeID = compositeID;
        this.finalScore = finalScore;
        this.score = score;
        this.gymnast = gymnast;
        this.Apparatus = Apparatus;
        this.team = team;
    }

    public int getCompositeID() {
        return compositeID;
    }

    public void setCompositeID(int compositeID) {
        this.compositeID = compositeID;
    }

    public double getFinalScore() {
        return finalScore;
    }

    public void setFinalScore(double finalScore) {
        this.finalScore = finalScore;
    }

    public List<Score> getScore() {
        return score;
    }

    public void setScore(List<Score> score) {
        this.score = score;
    }

    public List<Gymnast> getGymnast() {
        return gymnast;
    }

    public void setGymnast(List<Gymnast> gymnast) {
        this.gymnast = gymnast;
    }

    public List<Apparatus> getApparatus() {
        return Apparatus;
    }

    public void setApparatus(List<Apparatus> Apparatus) {
        this.Apparatus = Apparatus;
    }

    public List<Team> getTeam() {
        return team;
    }

    public void setTeam(List<Team> team) {
        this.team = team;
    }

}
