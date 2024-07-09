//
//  Knight.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/9/24.
//

import Foundation
import SwiftUI

struct Knight: ChessPiece {
    var position: (Int, Int)  // Stores the current position of the knight on the board
    let color: Player  // Represents the color of the knight, either black or white
    var image: Image {
        // Provides an image representation of the knight, selecting the correct asset based on color
        color == .white ? Image("white_knight") : Image("black_knight")
    }

    // Calculates the available moves for the knight based on its current position
    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
        var moves: [(Int, Int)] = []  // Initializes an empty list to store valid moves
        // All potential "L" shaped moves for a knight from its current position
        let potentialMoves = [
            (position.0 + 2, position.1 + 1),
            (position.0 + 2, position.1 - 1),
            (position.0 - 2, position.1 + 1),
            (position.0 - 2, position.1 - 1),
            (position.0 + 1, position.1 + 2),
            (position.0 + 1, position.1 - 2),
            (position.0 - 1, position.1 + 2),
            (position.0 - 1, position.1 - 2)
        ]
        
        // Evaluates each potential move to ensure it's within the board and either unoccupied or occupied by an opponent's piece
        for move in potentialMoves {
            if isValidPosition(move) {  // Checks if the position is within the board's bounds
                if let piece = board[move.0][move.1] {  // Checks if there is a piece at the calculated position
                    if piece.color != color {  // Ensures the piece is of the opposite color for capturing
                        moves.append(move)
                    }
                } else {
                    moves.append(move)  // Adds the move if the position is empty
                }
            }
        }
        
        return moves  // Returns the list of all valid moves
    }

    // Updates the position of the knight to a new position
    mutating func move(to newPosition: (Int, Int)) {
        self.position = newPosition
    }

    // Helper function to check if a position is within the 8x8 chessboard
    private func isValidPosition(_ position: (Int, Int)) -> Bool {
        return position.0 >= 0 && position.0 < 8 && position.1 >= 0 && position.1 < 8
    }
}
