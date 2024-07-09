//
//  Bishop.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/9/24.
//

import Foundation
import SwiftUI

struct Bishop: ChessPiece {
    var position: (Int, Int)
    let color: Color
    var image: Image {
        color == .white ? Image("white_bishop") : Image("black_bishop")  // Use appropriate asset names
    }

    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
        var moves: [(Int, Int)] = []
        
        // Directions a bishop can move: all four diagonals
        let directions = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
        
        // Check each diagonal direction
        for (dRow, dCol) in directions {
            var nextRow = position.0 + dRow
            var nextCol = position.1 + dCol
            // Continue in the direction until the edge of the board or a piece is encountered
            while isValidPosition((nextRow, nextCol)) {
                if let piece = board[nextRow][nextCol] {
                    if piece.color != color {
                        moves.append((nextRow, nextCol))  // Can capture an opponent's piece
                    }
                    break  // Stop if a piece is encountered
                } else {
                    moves.append((nextRow, nextCol))  // Add the move if the square is empty
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
        // Ensure the position is within the 8x8 chessboard boundaries
        return position.0 >= 0 && position.0 < 8 && position.1 >= 0 && position.1 < 8
    }
}

