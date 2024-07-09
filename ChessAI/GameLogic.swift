import Foundation
import SwiftUI

enum Player {
    case white
    case black
}

class ChessModel: ObservableObject {
    @Published var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    @Published var activePlayer: Player = .white
    @Published var selectedPiece: ChessPiece? = nil
    
    init() {
        setupBoard()
    }
    
    func setupBoard() {
        for i in 0...7 {
            board[1][i] = Pawn(position: (1, i), color: .white)
            board[6][i] = Pawn(position: (6, i), color: .black)
        }
    }
    
    func handleTap(row: Int, column: Int) {
        if let piece = board[row][column] {
            if piece.color == activePlayer {
                if let selectedPiece = selectedPiece {
                    if selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
                        movePiece(selectedPiece, to: (row, column))
                        activePlayer = activePlayer == .white ? .black : .white
                    } else {
                        self.selectedPiece = nil
                    }
                } else {
                    self.selectedPiece = piece
                }
            }
        } else if let selectedPiece = selectedPiece {
            if selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
                movePiece(selectedPiece, to: (row, column))
                activePlayer = activePlayer == .white ? .black : .white
            } else {
                self.selectedPiece = nil
            }
        }
    }

    func movePiece(_ piece: ChessPiece, to position: (Int, Int)) {
        board[piece.position.0][piece.position.1] = nil
        var mutablePiece = piece
        mutablePiece.move(to: position)
        board[position.0][position.1] = mutablePiece
        selectedPiece = nil
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: nil, count: 8), count: 8)
        activePlayer = .white
        selectedPiece = nil
        setupBoard()
        
    }
}
