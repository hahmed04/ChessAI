//
//  Queen.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/9/24.
//

import Foundation
import SwiftUI

struct Queen: ChessPiece {
    var position: (Int, Int)
    let color: Color
    var image: Image {
        color == .white ? Image("white_queen") : Image("black_queen")  // Use appropriate asset names
    }

    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
        var moves: [(Int, Int)] = []
        
        // Directions arrays represent vertical, horizontal, and diagonal moves
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]
        
        // Explore each direction
        for (dRow, dCol) in directions {
            var nextRow = position.0 + dRow
            var nextCol = position.1 + dCol
            // Keep moving in the direction until the edge of the board or an obstacle is encountered
            while isValidPosition((nextRow, nextCol)) {
                if let piece = board[nextRow][nextCol] {
                    if piece.color != color {
                        moves.append((nextRow, nextCol))  // Capture the opponent's piece
                    }
                    break  // Stop moving in this direction upon encountering any piece
                } else {
                    moves.append((nextRow, nextCol))  // Add empty square as a valid move
                }
                nextRow += dRow
                nextCol += dCol
            }
        }
        
        return moves
    }

    mutating func move(to newPosition: (Int, Int)) {
        self.position = newPosition
    }

    private func isValidPosition(_ position: (Int, Int)) -> Bool {
        // Check if a position is within the 8x8 chessboard
        return position.0 >= 0 && position.0 < 8 && position.1 >= 0 && position.1 < 8
    }
}
