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
    @State private var textAnswer = ""
    @State private var multiplicationTable: Int = 1
    @State private var numberOfQuestion = 5
    @State private var answer: Int = 0
    @State private var score = 0
    @State private var answerCorrect: Bool = false
    
    @FocusState private var isFocused: Bool
    
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
                
                Spacer()
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center ,spacing: 15) {
                        Text(askQuestion(firstNumber: (multiplicationTable + 2), secondNumber: generateRandomNumber()))
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
                            withAnimation {
                                answerCorrect = true
                            }
                            isFocused = false
                        }, label: {
                            Text("Verif")
                        })
                        .buttonStyle(.borderedProminent)
                        

                    }
                    .frame(width: 200, height: 250)
                    .background(LinearGradient(colors: [.pink, .purple, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                }
                
//                Section("Questions") {
//                    ForEach(0..<numberOfQuestion, id: \.self) { number in
//                        HStack {
//                            Spacer()
//                            Text(askQuestion(firstNumber: (multiplicationTable + 2), secondNumber: generateRandomNumber()))
//                                .frame(maxWidth: 50)
//                            Spacer()
//                            Text("=")
//                            Spacer()
//                            TextField("Your answer", value: $answer, format: .number)
//                                .frame(width: 50)
//                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.numberPad)
//                            Spacer()
//                            isAnswerCorrect(answer: answer, firstNumber: (multiplicationTable + 2), secondNunber: generateRandomNumber()) ? Image(systemName: "checkmark") : Image(systemName: "xmark.app")
//                        }
//                    }
//                }
            }
            .listStyle(.plain)
            .toolbar {
                Button("Start game", action: startGame)
            }
            .onAppear(perform: startGame)
            
            
            Text("\(score)")
        }
    }
    
    func startGame() {
        score = 0
    }
    
    func isAnswerCorrect() {
        if answer == ((multiplicationTable + 2) * generateRandomNumber()) {
            score += 1
            textAnswer = "Correct"
            // answerCorrect = true
        } else {
            textAnswer = "Wrong"
        }
    }
    
    func generateRandomNumber() -> Int {
        return Int.random(in: 0...12)
    }
    
    func askQuestion(firstNumber: Int, secondNumber: Int) -> String {
        return "\(firstNumber) x \(secondNumber) "
    }
}

#Preview {
    ContentView()
}
