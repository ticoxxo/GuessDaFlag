//
//  ContentView.swift
//  GuessDaFlag
//
//  Created by Alberto Almeida on 06/10/23.
//

import SwiftUI

struct Count: Identifiable {
    var id: String { String(reset) }
    var reset: Bool=false
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showinScore = false
    @State private var scoreTitle = ""
    @State private var messageScore = ""
    @State private var scoreCount = 0
    @State private var questionCount = 1
    @State private var showReset: Count?
    
    var body: some View {
        
            ZStack {
                RadialGradient(stops: [
                    .init(color: .blue, location: 0.3),
                    .init(color: .red, location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 700)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Guess the flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                    VStack(spacing: 15) {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                                print("Clicked \(countries[number])")
                            } label: {
                                FlagImage(country: countries[number])
                            }
                            .alert(scoreTitle, isPresented: $showinScore) {
                                Button("Continue", action: askQuestion)
                            } message: {
                                Text(messageScore)
                            }
                        }
                    }
                    Spacer()
                    Text("Question \(questionCount)/8")
                        .foregroundStyle(.secondary)
                    Text("Score \(scoreCount)")
                        .foregroundStyle(.secondary)
                        .font(.title.bold())
                    Spacer()
                }.padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }.alert(item: $showReset) { show in
                Alert(title: Text("Se termino el juego!"),
                      message: Text(checkResults()),
                      dismissButton: .default(Text("Continue"), action: resetGame)
                )
            }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            messageScore = "Correct!!"
            scoreCount = scoreCount + 1
        } else {
            scoreTitle = "Wrong"
            messageScore = "Wrong! That's the flag of \(countries[number])"
        }
        showinScore = true
    }
    
    func askQuestion() {
        if(questionCount > 3) {
            showReset = Count(reset: true)
            
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount = questionCount + 1
    }
    
    func resetGame(){
        questionCount = 0
        scoreCount = 0
    }
    
    func checkResults() ->  AttributedString {
        var res : String = ""
        
        if(scoreCount > 3) {
            res = "Congrats!!! You scored: \(scoreCount) points"
        } else {
            res = "Buuuuuuu"
        }
        
        return try! AttributedString(markdown: res)
    }
    
}

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country).renderingMode(.original)
            .shadow(radius: 5)
    }
    
}

#Preview {
    ContentView()
}
