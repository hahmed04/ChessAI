//
//  Queen.swift
//  ChessAI
//
//  Created by Nathanael Tesfaye on 7/9/24.
//

import Foundation
import SwiftUI

struct Queen: ChessPiece {
    var position: (Int, Int)  // Stores the current position of the knight on the board
    let color: Player  // Represents the color of the knight, either black or white
    var image: Image {
        // Provides an image representation of the knight, selecting the correct asset based on color
        color == .white ? Image("white_queen") : Image("black_queen")
    }
    
    
    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
        return [(0,0)]
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
    
    
    
