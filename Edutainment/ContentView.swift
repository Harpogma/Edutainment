//
//  ContentView.swift
//  Edutainment
//
//  Created by Gregory Daguerre on 26.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    let possibleNumberOfQuestion = [5, 10, 20]
    
    // MARK: State variables
    @State private var question: String
    @State private var multiplicationTable: Int = 1
    @State private var numberOfQuestion = 5
    @State private var answer: Int = 0
    @State private var score = 0
    @State private var answerCorrect: Bool
    @State private var gameIsOn: Bool = false
    @State private var questionCount = 1
    
    @FocusState private var isFocused: Bool
    
    public init() {
        self.question = ""
        self.answerCorrect = false
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Practice table") {
                    Picker("Choose your table", selection: $multiplicationTable) {
                        ForEach(2..<13) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                
                }
                Section("Number of question") {
                    Picker("Select a value", selection: $numberOfQuestion) {
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("20").tag(20)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
            }
            .listStyle(.plain)
            VStack {
                if !gameIsOn {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                gameIsOn.toggle()
                                self.question = generateQuestion()
                            }
                        } label: {
                            Text("Start game")
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                } else {
                    VStack {
                        Text("Question n° \(questionCount)")
                        
                        HStack {
                            Spacer()
                            
                            VStack(alignment: .center ,spacing: 15) {
                                Text(question)
                                    .font(.title)
                                Text("=")
                                    .font(.title)
                                HStack {
                                    TextField("Your answer", value: $answer, format: .number)
                                        .background(Color.white)
                                        .frame(width: 40)
                                        .cornerRadius(10)
                                        .keyboardType(.decimalPad)
                                        .focused($isFocused)
                                    answerCorrect ? Image(systemName: "checkmark") : Image(systemName: "xmark.app")
                                }
                                Button(action: {
                                    self.isAnswerCorrect()
                                    self.isFocused = false
                                    self.questionCount += 1
                                }, label: {
                                    Text("Check answer")
                                })
                                .buttonStyle(.borderedProminent)
                                
                            }
                            .frame(width: 200, height: 250)
                            .background(LinearGradient(colors: [.black, .yellow, .yellow, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(.rect(cornerRadius: 20))
                            
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            Text("Your score: \(score)")
        }
    }
    
    func isAnswerCorrect() {
        if answer == ((multiplicationTable + 2) * generateRandomNumber()) {
            score += 1
            answerCorrect = true
        } else {
            answerCorrect = false
        }
    }
    
    func generateRandomNumber() -> Int {
        return Int.random(in: 0...12)
    }
    
    func generateQuestion() -> String {
        return "\(multiplicationTable + 2) x \(generateRandomNumber())"
    }
}

#Preview {
    ContentView()
}
