//
//  Game.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import Combine
import SwiftUI

extension Bool {
    static let x: Color = .blue
    static let o: Color = .red

    var color: Color { self ? Self.x : Self.o }
    var title: String { "\(self ? "X" : "O")'s Turn" }
    var gameOverMessage: String { "\(self ? "X" : "O") Wins!" }
}

class Game: ObservableObject {
    @Published var winLine: WinLine?
    @Published var isShowingPlayAgain = false
    @Published var activePlayer: Bool? = true
    @Published var board: [Bool?] = Array(repeating: nil, count: 9)

    var isGameOver: Bool {
        //  x | x | x
        // -----------
        //    |   |
        // -----------
        //    |   |
        if board[0] != nil && board[0] == board[1] && board[1] == board[2] {
            winLine = Line.horizontalTop
            return true
        }
        //    |   |
        // -----------
        //  x | x | x
        // -----------
        //    |   |
        if board[3] != nil && board[3] == board[4] && board[4] == board[5] {
            winLine = Line.horizontalMiddle
            return true
        }

        //    |   |
        // -----------
        //    |   |
        // -----------
        //  x | x | x
        if board[6] != nil && board[6] == board[7] && board[7] == board[8] {
            winLine = Line.horizontalBottom
            return true
        }

        //  x |   |
        // -----------
        //  x |   |
        // -----------
        //  x |   |
        if board[0] != nil && board[0] == board[3] && board[3] == board[6] {
            winLine = Line.verticalLeading
            return true
        }

        //    | x |
        // -----------
        //    | x |
        // -----------
        //    | x |
        if board[1] != nil && board[1] == board[4] && board[4] == board[7] {
            winLine = Line.verticalMiddle
            return true
        }

        //    |   | x
        // -----------
        //    |   | x
        // -----------
        //    |   | x
        if board[2] != nil && board[2] == board[5] && board[5] == board[8] {
            winLine = Line.verticalTrailing
            return true
        }

        //  x |   |
        // -----------
        //    | x |
        // -----------
        //    |   | x
        if board[0] != nil && board[0] == board[4] && board[4] == board[8] {
            winLine = Line.diagonalTopLeft
            return true
        }

        //    |   | x
        // -----------
        //    | x |
        // -----------
        //  x |   |
        if board[2] != nil && board[2] == board[4] && board[4] == board[6] {
            winLine = Line.diagonalTopRight
            return true
        }

        // All squares filled, no winner
        if board.allSatisfy({ $0 != nil }) {
            activePlayer = nil
            isShowingPlayAgain = true
            return true
        }
        return false
    }


    func reset() {
        board = Array(repeating: nil, count: 9)
        activePlayer = true
        winLine = nil
        isShowingPlayAgain = false
    }
}
