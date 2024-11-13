import SwiftUI

struct ContentView: View {
    @State private var playerScore = 0
    @State private var cpuScore = 0
    @State private var playerChoice: String? = nil
    @State private var cpuChoice: String = ""
    @State private var showingResult = false
    @State private var resultMessage = ""
    
    let choices = ["rock", "paper", "scissors"]
    
    var body: some View {
        ZStack {
            Image("Background") 
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("Player")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Image(playerChoice ?? "placeholder")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Score: \(playerScore)")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("CPU")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Image(cpuChoice)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Score: \(cpuScore)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
                    ForEach(choices, id: \.self) { choice in
                        Button(action: {
                            playerTapped(choice)
                        }) {
                            Image(choice)
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingResult) {
                Alert(
                    title: Text("Result"),
                    message: Text(resultMessage),
                    dismissButton: .default(Text("OK")) {
                        resetRound()
                    }
                )
            }
        }
    }
    
    func playerTapped(_ choice: String) {
        playerChoice = choice
        cpuChoice = choices.randomElement() ?? "rock"
        determineWinner()
    }
    
    func determineWinner() {
        if playerChoice == cpuChoice {
            resultMessage = "It's a tie!"
        } else if (playerChoice == "rock" && cpuChoice == "scissors") ||
                  (playerChoice == "scissors" && cpuChoice == "paper") ||
                  (playerChoice == "paper" && cpuChoice == "rock") {
            resultMessage = "You win this round!"
            playerScore += 1
        } else {
            resultMessage = "CPU wins this round!"
            cpuScore += 1
        }
        showingResult = true
    }
    
    func resetRound() {
        playerChoice = nil
        cpuChoice = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
