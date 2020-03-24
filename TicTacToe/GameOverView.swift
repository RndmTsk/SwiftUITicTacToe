//
//  GameOverView.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var game: Game
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
            Group {
                if self.game.activePlayer == nil {
                    Text("It's a Tie!")
                } else {
                    HStack {
                        if self.game.activePlayer! {
                            XView(color: .blue)
                                .frame(width: 80, height: 80)
                        } else {
                            OView(color: .red)
                                .frame(width: 80, height: 80)
                        }
                        Text(" Wins!")
                            .font(.largeTitle)
                            .padding([.leading], -16)
                    }
                }
            }
            .padding([.bottom], 16)
            Button(action: {
                self.resetGame()
            }) {
                Text("Play Again?")
            }
        }
    }

    private func resetGame() {
        game.board = Array(repeating: nil, count: 9)
        game.activePlayer = true
        game.isGameOver = false
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(Game())
    }
}
