//
//  ContentView.swift
//  rockPaperScissors
//
//  Created by Subhrajyoti Chakraborty on 22/05/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    @State private var score = 0
    @State private var appMove = ""
    @State private var userMove = ""
    @State private var winOrLoose = false
    @State private var showAppMove = false
    @State private var showAlert = false
    @State private var gameCounter = 1
    @State private var displayScoreStr = ""
    
    func createAppState() {
        appMove = moves.randomElement() ?? "Rock"
        winOrLoose = Bool.random()
        if gameCounter > 10 {
            showAppMove = false
        }
    }
    
    func getScore() {
        switch appMove {
            case "Rock":
                displayScoreStr =  getResultFeedBack(for: 1)
                break
            case "Paper":
                displayScoreStr =  getResultFeedBack(for: 2)
                break
            case "Scissors":
                displayScoreStr =  getResultFeedBack(for: 3)
                break
            default:
                displayScoreStr = "Wrong"
                break
        }
    }
    
    func getResultFeedBack(for index: Int) -> String {
        let correctIndex = (index + 1) > moves.count ? 0 : index
        let correctAnswer = moves[correctIndex]
        if userMove == moves[index - 1] {
            return "Draw.."
        } else {
            if !winOrLoose && userMove == correctAnswer {
                score += 1
                return "Correct"
            } else if !winOrLoose && userMove != correctAnswer {
                score -= 1
                return "Wrong"
            } else if winOrLoose && userMove != correctAnswer {
                score += 1
                return "Correct"
            } else {
                score -= 1
                return "Wrong"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            VStack{
                if !showAppMove {
                    Button(action: {
                        self.createAppState()
                        self.showAppMove = true
                        self.gameCounter = 1
                    }){
                        Text("Click the button to start the game")
                            .padding()
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.blue, lineWidth: 1))
                    }
                }
                if showAppMove {
                    Text("App Select \(appMove) and want to \(winOrLoose ? "win" : "loose")")
                }
            }
            VStack{
                if showAppMove {
                    HStack(spacing: 40) {
                        ForEach(0..<3) { number in
                            Button(action: {
                                print("Tap \(self.moves[number])")
                                self.userMove = self.moves[number]
                                self.showAlert = true
                                self.getScore()
                            }) {
                                Text("\(self.moves[number])")
                            }
                            .padding()
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.blue, lineWidth: 1))
                            .alert(isPresented: self.$showAlert) {
                                Alert(title: Text("You select \(self.userMove)"), message: Text("\(self.gameCounter  >= 10 ? "\(self.displayScoreStr) and total score is \(self.score)" : self.displayScoreStr)"), dismissButton: .default(Text("\(self.gameCounter  >= 10 ? "End" : "Continue")")) {
                                    if self.gameCounter  <= 10 {
                                        self.gameCounter += 1
                                        self.createAppState()
                                    }
                                    })
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
