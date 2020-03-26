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
    @Published var isGameOver = false
    @Published var isShowingPlayAgain = false
    @Published var activePlayer: Bool? = true
    @Published var board: [Bool?] = Array(repeating: nil, count: 9) {
        didSet {
            checkGameOver()
        }
    }

    func reset() {
        board = Array(repeating: nil, count: 9)
        activePlayer = true
        winLine = nil
        isShowingPlayAgain = false
        isGameOver = false
    }

    private func checkGameOver() {
        //  x | x | x
        // -----------
        //    |   |
        // -----------
        //    |   |
        if board[0] != nil && board[0] == board[1] && board[1] == board[2] {
            winLine = Line.horizontalTop
            isGameOver = true
            return
        }
        //    |   |
        // -----------
        //  x | x | x
        // -----------
        //    |   |
        if board[3] != nil && board[3] == board[4] && board[4] == board[5] {
            winLine = Line.horizontalMiddle
            isGameOver = true
            return
        }

        //    |   |
        // -----------
        //    |   |
        // -----------
        //  x | x | x
        if board[6] != nil && board[6] == board[7] && board[7] == board[8] {
            winLine = Line.horizontalBottom
            isGameOver = true
            return
        }

        //  x |   |
        // -----------
        //  x |   |
        // -----------
        //  x |   |
        if board[0] != nil && board[0] == board[3] && board[3] == board[6] {
            winLine = Line.verticalLeading
            isGameOver = true
            return
        }

        //    | x |
        // -----------
        //    | x |
        // -----------
        //    | x |
        if board[1] != nil && board[1] == board[4] && board[4] == board[7] {
            winLine = Line.verticalMiddle
            isGameOver = true
            return
        }

        //    |   | x
        // -----------
        //    |   | x
        // -----------
        //    |   | x
        if board[2] != nil && board[2] == board[5] && board[5] == board[8] {
            winLine = Line.verticalTrailing
            isGameOver = true
            return
        }

        //  x |   |
        // -----------
        //    | x |
        // -----------
        //    |   | x
        if board[0] != nil && board[0] == board[4] && board[4] == board[8] {
            winLine = Line.diagonalTopLeft
            isGameOver = true
            return
        }

        //    |   | x
        // -----------
        //    | x |
        // -----------
        //  x |   |
        if board[2] != nil && board[2] == board[4] && board[4] == board[6] {
            winLine = Line.diagonalTopRight
            isGameOver = true
            return
        }

        // All squares filled, no winner
        if board.allSatisfy({ $0 != nil }) {
            activePlayer = nil
            isGameOver = true
            isShowingPlayAgain = true
        }
    }
}
