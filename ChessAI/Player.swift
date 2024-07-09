//
//  Player.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/8/24.
//

//import Foundation
//import
//class Player {
//    var pieces: [ChessPiece] = []
//    var color: Color
//
//    init(color: Color) {
//        self.color = color
//        setupPieces()
//    }
//
//    private func setupPieces() {
//        // Initialize the pieces for this player
//        pieces.append(King(color: color, position: (color == .white ? 0 : 7, 4)))
//        pieces.append(Queen(color: color, position: (color == .white ? 0 : 7, 3)))
//        pieces += [Rook, Knight, Bishop].flatMap { PieceType in
//            [(PieceType(color: color, position: (color == .white ? 0 : 7, PieceType.defaultPositions.first))),
//             (PieceType(color: color, position: (color == .white ? 0 : 7, PieceType.defaultPositions.last)))]
//        }
//        for i in 0..<8 {
//            pieces.append(Pawn(color: color, position: (color == .white ? 1 : 6, i)))
//        }
//    }
//}
//
