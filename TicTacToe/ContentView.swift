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
    var body: some View {
        VStack {
            BoardRowView(rowIndex: 0)
            BoardRowView(rowIndex: 1)
            BoardRowView(rowIndex: 2)
        }
        .padding()
        .sheet(isPresented: self.$game.isGameOver) {
            GameOverView()
                .environmentObject(self.game)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(Color.gray)
            .environmentObject(Game())
    }
}
