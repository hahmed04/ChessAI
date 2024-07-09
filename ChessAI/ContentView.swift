import SwiftUI

struct ContentView: View {
    
    @State private var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    @State private var selectedPiece: ChessPiece? = nil
    
    
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
                                handleTap(row: row, column: column)
                                print("\(row), \(column)")
                            }) {
                                ZStack {
                                
                                    Rectangle()
                                        .fill((row + column) % 2 == 0 ? Color(red: 183/255, green: 192/255, blue: 216/255) : Color(red: 232/255, green: 237/255, blue: 249/255))
                                        .frame(width: 40, height: 40)
                                    
                                    if let piece = board[row][column] {
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
        .onAppear {
            initializeBoard()
        }
    }
    
    private func initializeBoard() {
        // Initialize the white pawn at (1, 0)
        for i in 0...7 {
            board[1][i] = Pawn(position: (1, i), color: .white)
            board[6][i] = Pawn(position: (6, i), color: .black)
        }
        // Initialize knights
            board[0][1] = Knight(position: (0, 1), color: .white)
            board[0][6] = Knight(position: (0, 6), color: .white)
            board[7][1] = Knight(position: (7, 1), color: .black)
            board[7][6] = Knight(position: (7, 6), color: .black)
        

   }
    
    
    private func handleTap(row: Int, column: Int) {
        print("entered")
        if let selectedPiece = selectedPiece {
            if selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
                print("moved")
                movePiece(selectedPiece, to: (row, column))
            } else {
                self.selectedPiece = nil
            }
        } else if let piece = board[row][column] {
            self.selectedPiece = piece
        }
    }

    private func movePiece(_ piece: ChessPiece, to position: (Int, Int)) {
        board[piece.position.0][piece.position.1] = nil
        var mutablePiece = piece
        mutablePiece.move(to: position)
        board[position.0][position.1] = mutablePiece
        selectedPiece = nil
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
