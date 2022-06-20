//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Taha Bozdemir on 20.06.2022.
//
import SwiftUI
struct Choice:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
            .padding(10)
            .background(.orange)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
extension View{
    func choiceStyle() -> some View{
        modifier(Choice())
    }
}
struct ContentView: View {
    let choices:[String] = ["Rock","Paper","Scissors"]
    @State private var opponentsChoice:String = ""
    @State private var scoreAlert:String = ""
    @State private var score:Int = 0
    @State private var opponentsScore:Int = 0
    @State private var showingScore:Bool = false
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.orange, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack{
                Text("Rock-Paper-Scissors")
                    .font(.custom("AmericanTypeWriter", size: 30).weight(.bold))
                    .foregroundColor(.white)
                    .padding(.top,30)
                
                Spacer()
                Text("Your Score: \(score)")
                    .font(.custom("AmericanTypeWriter", size: 25))
                Text("Openent's Score: \(opponentsScore)")
                    .font(.custom("AmericanTypeWriter", size: 25))
                Spacer()
                HStack(spacing:35){
                    
                    Button{
                        makeChoise(choise: choices[0])
                        remainingGame()
                    } label: {
                        Text("🪨")
                            .choiceStyle()
                    }
                    Button{
                        makeChoise(choise: choices[1])
                        remainingGame()
                    } label: {
                        Text("📃")
                            .choiceStyle()
                    }
                    Button {
                        makeChoise(choise: choices[2])
                        remainingGame()
                    } label: {
                        Text("✂️")
                            .choiceStyle()
                    }
                    
                }
                .padding(.bottom,30)
                
            }
        }
        .alert(scoreAlert, isPresented: $showingScore) {
            Button("Continue"){}
        } message: {
            Text("The \(opponentsChoice) was chosen by the opponent.")
        }
    }
    func makeChoise(choise:String){
        opponentsChoice = choices[Int.random(in: 0...2)]
        if choise == "Rock"{
            
            switch opponentsChoice{
            case "Paper":
                scoreAlert = "You Lose"
                opponentsScore += 1
            case "Scissors":
                scoreAlert = "You Win"
                score += 1
                
            case "Rock":
                scoreAlert = "Draw"
            default:
                scoreAlert = "Something went wrong."
            }
        }
        else if choise == "Paper"{
            switch opponentsChoice{
            case "Paper":
                scoreAlert = "Draw"
            case "Scissors":
                scoreAlert = "You Lose"
                opponentsScore += 1
            case "Rock":
                scoreAlert = "You Win"
                score += 1
                
            default:
                scoreAlert = "Something went wrong."
            }
        }
        
        else if choise == "Scissors"{
            switch opponentsChoice{
            case "Paper":
                scoreAlert = "You Win"
                score += 1
            case "Scissors":
                scoreAlert = "Draw"
            case "Rock":
                scoreAlert = "You Lose"
                opponentsScore += 1
            default:
                scoreAlert = "Something went wrong."
            }
        }
        showingScore = true
    }
    func remainingGame(){
        if opponentsScore == 3 || score == 3 {
            if(opponentsScore == 3){
                scoreAlert = "The opponent won the game."
            }
            else if(score == 3){
                scoreAlert = "You won the game."
            }
            score = 0
            opponentsScore = 0
            showingScore = true
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
