//
//  pawn.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/8/24.
//

import Foundation
import SwiftUI
struct Pawn: ChessPiece {
    var position: (Int, Int)
    let color: Color
    var image: Image {
        color == .white ? Image("white_pawn") : Image("black_pawn")  // Use a custom image in your app assets
    }

    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)] {
        var moves: [(Int, Int)] = []
        let direction = color == .white ? 1 : -1
        let forward = (position.0 + direction, position.1)
        if isValidPosition(forward) && board[forward.0][forward.1] == nil {
            moves.append(forward)
        }
        let diagonals = [(forward.0, position.1 + 1), (forward.0, position.1 - 1)]
        for diag in diagonals {
            if isValidPosition(diag), let piece = board[diag.0][diag.1], piece.color != color {
                moves.append(diag)
            }
        }
        return moves
    }

    mutating func move(to position: (Int, Int)) {
        self.position = position
    }

    private func isValidPosition(_ position: (Int, Int)) -> Bool {
        return position.0 >= 0 && position.0 < 8 && position.1 >= 0 && position.1 < 8
    }
}


