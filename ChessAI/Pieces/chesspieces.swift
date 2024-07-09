//
//  chesspieces.swift
//  ChessAI
//
//  Created by Hamza Ahmed on 7/8/24.
//

import Foundation
import SwiftUI

protocol ChessPiece {
    var position: (Int, Int) { get set }
    var color: Player { get }
    var image: Image { get }
    func availableMoves(in board: [[ChessPiece?]]) -> [(Int, Int)]
    mutating func move(to position: (Int, Int))
    
}
