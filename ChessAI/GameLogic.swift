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
        // Initialize pawns
        for i in 0...7 {
            board[1][i] = Pawn(position: (1, i), color: .white)
            board[6][i] = Pawn(position: (6, i), color: .black)
        }
        
        // Initialize knights
        board[0][1] = Knight(position: (0, 1), color: .white)
        board[0][6] = Knight(position: (0, 6), color: .white)
        board[7][1] = Knight(position: (7, 1), color: .black)
        board[7][6] = Knight(position: (7, 6), color: .black)
        
        // Initialize rooks
        board[0][0] = Rook(position: (0, 0), color: .white)
        board[0][7] = Rook(position: (0, 7), color: .white)
        board[7][0] = Rook(position: (7, 0), color: .black)
        board[7][7] = Rook(position: (7, 7), color: .black)
        
        // Initialize bishops
        board[0][2] = Bishop(position: (0, 2), color: .white)
        board[0][5] = Bishop(position: (0, 5), color: .white)
        board[7][2] = Bishop(position: (7, 2), color: .black)
        board[7][5] = Bishop(position: (7, 5), color: .black)
        
        // Initialize queens
        board[0][3] = Queen(position: (0, 3), color: .white)
        board[7][3] = Queen(position: (7, 3), color: .black)
        
        // Initialize kings
        board[0][4] = King(position: (0, 4), color: .white)
        board[7][4] = King(position: (7, 4), color: .black)
    }
    
    func handleTap(row: Int, column: Int) {
        if let piece = board[row][column] {
            if piece.color == activePlayer {
                // Select or move the piece if the current player is tapping their own piece
                if let selectedPiece = selectedPiece {
                    if selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
                        // Move the selected piece to the new position
                        movePiece(selectedPiece, to: (row, column))
                        activePlayer = activePlayer == .white ? .black : .white
                    } else {
                        // Deselect if the move is not valid
                        self.selectedPiece = nil
                    }
                } else {
                    // Select the piece
                    self.selectedPiece = piece
                }
            } else if let selectedPiece = selectedPiece, selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
                // Capturing an opponent's piece
                capturePiece(at: (row, column))
                movePiece(selectedPiece, to: (row, column))
                activePlayer = activePlayer == .white ? .black : .white
            }
        } else if let selectedPiece = selectedPiece, selectedPiece.availableMoves(in: board).contains(where: { $0 == (row, column) }) {
            // Move to an empty square
            movePiece(selectedPiece, to: (row, column))
            activePlayer = activePlayer == .white ? .black : .white
        } else {
            // Deselect the piece
            self.selectedPiece = nil
        }
    }

    func capturePiece(at position: (Int, Int)) {
        board[position.0][position.1] = nil
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
