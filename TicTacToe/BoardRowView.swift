//
//  BoardRowView.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

struct BoardRowView: View {
    var rowIndex: Int
    var body: some View {
        HStack {
            BoardButton(cellIndex: rowIndex * 3)
            BoardButton(cellIndex: rowIndex * 3 + 1)
            BoardButton(cellIndex: rowIndex * 3 + 2)
        }
    }
}

struct BoardRowView_Previews: PreviewProvider {
    static var previews: some View {
        BoardRowView(rowIndex: 0)
            .previewLayout(.sizeThatFits)
    }
}
