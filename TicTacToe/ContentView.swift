//
//  ContentView.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: Game

    var gameOverOverlay: some View {
        if let winLine = game.winLine {
            return AnyView(WinLineView(start: winLine.start, end: winLine.end, color: game.activePlayer!.color))
        } else {
            return AnyView(EmptyView())
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                BoardRowView(rowIndex: 0)
                BoardRowView(rowIndex: 1)
                BoardRowView(rowIndex: 2)
            }
            .background(Color.gray)
            .padding()
            .overlay(gameOverOverlay)
            .navigationBarTitle("\(game.activePlayer?.title ?? "")", displayMode:.inline)
            .sheet(isPresented: $game.isShowingPlayAgain) {
                GameOverView()
                    .environmentObject(self.game)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(Color.gray)
            .environmentObject(Game())
    }
}
