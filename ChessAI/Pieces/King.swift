//
//  Queen.swift
//  ChessAI
//
//  Created by Nathanael Tesfaye on 7/9/24.
//

import Foundation
import SwiftUI

struct King: ChessPiece {
    var position: (Int, Int)  // Stores the current position of the knight on the board
    let color: Player  // Represents the color of the knight, either black or white
    var image: Image {
        // Provides an image representation of the knight, selecting the correct asset based on color
        color == .white ? Image("white_king") : Image("black_king")
    }
    
    
    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
            var moves: [(Int, Int)] = []
            
            // Possible moves for a king include all adjacent squares
            let directions = [
                (-1, -1), (-1, 0), (-1, 1), // Upper row
                (0, -1), (0, 1),           // Middle row (excluding current position)
                (1, -1), (1, 0), (1, 1)    // Lower row
            ]
            
            // Check each possible move
            for direction in directions {
                let newRow = position.0 + direction.0
                let newCol = position.1 + direction.1
                if isValidPosition((newRow, newCol)) {
                    if let piece = board[newRow][newCol] {
                        // Allow the move if it's capturing an opponent's piece
                        if piece.color != color {
                            moves.append((newRow, newCol))
                        }
                    } else {
                        // Allow the move if the square is empty
                        moves.append((newRow, newCol))
                    }
                }
            }
            
            return moves
        }

        mutating func move(to newPosition: (Int, Int)) {
            self.position = newPosition
        }

        private func isValidPosition(_ position: (Int, Int)) -> Bool {
            // Check if the position is within the 8x8 chessboard boundaries
            return position.0 >= 0 && position.0 < 8 && position.1 >= 0 && position.1 < 8
        }
    
    
    
}
    
    
    
