//
//  WinLineView.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-26.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

extension CGPoint: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: CGFloat...) {
        precondition(elements.count == 2)
        self.init(x: elements.first!, y: elements.last!)
    }
}

typealias WinLine = (start: CGPoint, end: CGPoint)

struct Line: Shape {
    static let column1: CGFloat = 0.2
    static let column2: CGFloat = 0.5
    static let column3: CGFloat = 0.8

    static let row1: CGFloat = 0.1
    static let row2: CGFloat = 0.5
    static let row3: CGFloat = 0.9

    //  x | x | x
    // -----------
    //    |   |
    // -----------
    //    |   |
    static let horizontalTop: WinLine = ([Line.column1, Line.row1],
                                         [Line.column3, Line.row1])
    //    |   |
    // -----------
    //  x | x | x
    // -----------
    //    |   |
    static let horizontalMiddle: WinLine  = ([Line.column1, Line.row2],
                                             [Line.column3, Line.row2])

    //    |   |
    // -----------
    //    |   |
    // -----------
    //  x | x | x
    static let horizontalBottom: WinLine = ([Line.column1, Line.row3],
                                            [Line.column3, Line.row3])

    //  x |   |
    // -----------
    //  x |   |
    // -----------
    //  x |   |
    static let verticalLeading: WinLine = ([Line.column1, Line.row1],
                                           [Line.column1, Line.row3])

    //    | x |
    // -----------
    //    | x |
    // -----------
    //    | x |
    static let verticalMiddle: WinLine = ([Line.column2, Line.row1],
                                          [Line.column2, Line.row3])

    //    |   | x
    // -----------
    //    |   | x
    // -----------
    //    |   | x
    static let verticalTrailing: WinLine = ([Line.column3, Line.row1],
                                            [Line.column3, Line.row3])

    //  x |   |
    // -----------
    //    | x |
    // -----------
    //    |   | x
    static let diagonalTopLeft: WinLine = ([Line.column1, Line.row1],
                                           [Line.column3, Line.row3])

    //    |   | x
    // -----------
    //    | x |
    // -----------
    //  x |   |
    static let diagonalTopRight: WinLine = ([Line.column3, Line.row1],
                                            [Line.column1, Line.row1])

    //       Column 1 |   Column 2 |  Column 3
    // Row 1  [1, 1]  |   [2, 1]   |   [3, 1]
    // ---------------------------------------
    // Row 2  [1, 2]  |   [2, 2]   |   [3, 2]
    // ---------------------------------------
    // Row 3  [1, 3] |    [2, 3]   |   [3, 3]

    let start: CGPoint
    let end: CGPoint

    func path(in rect: CGRect) -> Path {
        let lineStart = CGPoint(x: rect.width * start.x, y: rect.height * start.y)
        let lineEnd = CGPoint(x: rect.width * end.x, y: rect.height * end.y)
        var path = Path()
        path.move(to: lineStart)
        path.addLine(to: lineEnd)

        return path
    }
}

struct WinLineView: View {
    let start: CGPoint
    let end: CGPoint
    let color: Color
    @EnvironmentObject var game: Game

    @State private var isAnimating = false
    var body: some View {
        Line(start: start, end: end)
            .trim(from: isAnimating ? 0 : 1, to: 1)
            .stroke(color, lineWidth: 15)
            .animation(Animation
                .easeInOut(duration: 0.6)
            .delay(0.5))
            .onAppear {
                withAnimation {
                    self.isAnimating.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.game.isShowingPlayAgain = true
                }
            }
    }
}

struct WinLineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //  x | x | x
            // -----------
            //    |   |
            // -----------
            //    |   |
            WinLineView(start: [Line.column1, Line.row1],
                        end: [Line.column3, Line.row1],
                        color: .red)

            //    |   |
            // -----------
            //  x | x | x
            // -----------
            //    |   |
            WinLineView(start: [Line.column1, Line.row2],
                        end: [Line.column3, Line.row2],
                        color: .red)

            //    |   |
            // -----------
            //    |   |
            // -----------
            //  x | x | x
            WinLineView(start: [Line.column1, Line.row3],
                        end: [Line.column3, Line.row3],
                        color: .red)

            //  x |   |
            // -----------
            //  x |   |
            // -----------
            //  x |   |
            WinLineView(start: [Line.column1, Line.row1],
                        end: [Line.column1, Line.row3],
                        color: .red)

            //    | x |
            // -----------
            //    | x |
            // -----------
            //    | x |
            WinLineView(start: [Line.column2, Line.row1],
                        end: [Line.column2, Line.row3],
                        color: .red)

            //    |   | x
            // -----------
            //    |   | x
            // -----------
            //    |   | x
            WinLineView(start: [Line.column3, Line.row1],
                        end: [Line.column3, Line.row3],
                        color: .red)

            //  x |   |
            // -----------
            //    | x |
            // -----------
            //    |   | x
            WinLineView(start: [Line.column1, Line.row1],
                        end: [Line.column3, Line.row3],
                        color: .red)

            //    |   | x
            // -----------
            //    | x |
            // -----------
            //  x |   |
            WinLineView(start: [Line.column3, Line.row1],
                        end: [Line.column1, Line.row3],
                        color: .red)

        }
            .previewLayout(.sizeThatFits)
    }
}
