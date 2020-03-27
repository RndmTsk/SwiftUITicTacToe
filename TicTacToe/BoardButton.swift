//
//  BoardButton.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

struct BoardButton: View {
    @EnvironmentObject var game: Game
    var cellIndex: Int

    var overlayView: some View {
        if self.game.board[cellIndex] == true {
            return AnyView(XView(color: .blue))
        } else if self.game.board[cellIndex] == false {
            return AnyView(OView(color: .red))
        } else {
            return AnyView(EmptyView())
        }
    }

    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .transition(.opacity)
            .padding(0.5)
            .onTapGesture {
                guard !self.game.isGameOver,
                    self.game.board[self.cellIndex] == nil
                    else { return }
                self.toggle()
        }.overlay(overlayView)
    }

    private func toggle() {
        withAnimation {
            self.game.board[self.cellIndex] = self.game.activePlayer
            guard !game.isGameOver else { return }
            game.activePlayer?.toggle()
        }
    }
}

struct BoardButton_Previews: PreviewProvider {
    static var previews: some View {
        BoardButton(cellIndex: 0)
            .environmentObject(Game())
            .previewLayout(.sizeThatFits)
    }
}
