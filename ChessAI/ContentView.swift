import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ChessBoard = ChessModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 320, height: 320) // 8 * 40 (since each cell is 40x40)
            
            VStack(spacing: 0) {
                ForEach((0..<8).reversed(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { column in
                            Button(action: {
                                ChessBoard.handleTap(row: row, column: column)
                                print("\(row), \(column)")
                            }) {
                                ZStack {
                                
                                    Rectangle()
                                        .fill((row + column) % 2 == 0 ? Color(red: 183/255, green: 192/255, blue: 216/255) : Color(red: 232/255, green: 237/255, blue: 249/255))
                                        .frame(width: 40, height: 40)
                                    
                                    // Highlight available moves
                                    if let selectedPiece = ChessBoard.selectedPiece {
                                        if selectedPiece.availableMoves(in: ChessBoard.board).contains(where: { $0 == (row, column) }) {
                                            Rectangle()
                                                .fill(Color.yellow.opacity(0.3))
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                    
                                    if let piece = ChessBoard.board[row][column] {
                                        piece.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .padding(5) // Adjust padding as needed
                                            .background(Color.clear) // Ensure background is clear
                                    }
                                }
                            }
                            .buttonStyle(NoEffectButtonStyle()) // Custom button style to remove all effects
                        }
                    }
                }
            }
        }
        .padding(.bottom)
        Button(action: {
            ChessBoard.resetGame()
        }) {
            Text("RESET ↻")
                .frame(width: 200, height: 50)
                .background(.white)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .heavy))
                .clipShape(Capsule())
        }
    }
    
    
    
}

struct NoEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
#Preview {
    ContentView()
}
