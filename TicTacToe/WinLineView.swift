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
    static let horizontalColumn1: CGFloat = 0.1
    static let verticalColumn1: CGFloat = 0.15
    static let diagonalColumn1: CGFloat = 0.1
    static let column2: CGFloat = 0.5
    static let horizontalColumn3: CGFloat = 0.9
    static let verticalColumn3: CGFloat = 0.85
    static let diagonalColumn3: CGFloat = 0.9

    static let horizontalRow1: CGFloat = 0.15
    static let verticalRow1: CGFloat = 0.1
    static let diagonalRow1: CGFloat = 0.1
    static let row2: CGFloat = 0.5
    static let horizontalRow3: CGFloat = 0.85
    static let verticalRow3: CGFloat = 0.9
    static let diagonalRow3: CGFloat = 0.9

    //  x | x | x
    // -----------
    //    |   |
    // -----------
    //    |   |
    static let horizontalTop: WinLine = ([Line.horizontalColumn1, Line.horizontalRow1],
                                         [Line.horizontalColumn3, Line.horizontalRow1])
    //    |   |
    // -----------
    //  x | x | x
    // -----------
    //    |   |
    static let horizontalMiddle: WinLine = ([Line.horizontalColumn1, Line.row2],
                                            [Line.horizontalColumn3, Line.row2])

    //    |   |
    // -----------
    //    |   |
    // -----------
    //  x | x | x
    static let horizontalBottom: WinLine = ([Line.horizontalColumn1, Line.horizontalRow3],
                                            [Line.horizontalColumn3, Line.horizontalRow3])

    //  x |   |
    // -----------
    //  x |   |
    // -----------
    //  x |   |
    static let verticalLeading: WinLine = ([Line.verticalColumn1, Line.verticalRow1],
                                           [Line.verticalColumn1, Line.verticalRow3])

    //    | x |
    // -----------
    //    | x |
    // -----------
    //    | x |
    static let verticalMiddle: WinLine = ([Line.column2, Line.verticalRow1],
                                          [Line.column2, Line.verticalRow3])

    //    |   | x
    // -----------
    //    |   | x
    // -----------
    //    |   | x
    static let verticalTrailing: WinLine = ([Line.verticalColumn3, Line.verticalRow1],
                                            [Line.verticalColumn3, Line.verticalRow3])

    //  x |   |
    // -----------
    //    | x |
    // -----------
    //    |   | x
    static let diagonalTopLeft: WinLine = ([Line.diagonalColumn1, Line.diagonalRow1],
                                           [Line.diagonalColumn3, Line.diagonalRow3])

    //    |   | x
    // -----------
    //    | x |
    // -----------
    //  x |   |
    static let diagonalTopRight: WinLine = ([Line.diagonalColumn3, Line.diagonalRow1],
                                            [Line.diagonalColumn1, Line.diagonalRow3])

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
            .trim(from: 0, to: isAnimating ? 1 : 0)
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
            WinLineView(start: Line.horizontalTop.start,
                        end: Line.horizontalTop.end,
                        color: .red)

            //    |   |
            // -----------
            //  x | x | x
            // -----------
            //    |   |
            WinLineView(start: Line.horizontalMiddle.start,
                        end: Line.horizontalMiddle.end,
                        color: .red)

            //    |   |
            // -----------
            //    |   |
            // -----------
            //  x | x | x
            WinLineView(start: Line.horizontalBottom.start,
                        end: Line.horizontalBottom.end,
                        color: .red)

            //  x |   |
            // -----------
            //  x |   |
            // -----------
            //  x |   |
            WinLineView(start: Line.verticalLeading.start,
                        end: Line.verticalLeading.end,
                        color: .red)

            //    | x |
            // -----------
            //    | x |
            // -----------
            //    | x |
            WinLineView(start: Line.verticalMiddle.start,
                        end: Line.verticalMiddle.end,
                        color: .red)

            //    |   | x
            // -----------
            //    |   | x
            // -----------
            //    |   | x
            WinLineView(start: Line.verticalTrailing.start,
                        end: Line.verticalTrailing.end,
                        color: .red)

            //  x |   |
            // -----------
            //    | x |
            // -----------
            //    |   | x
            WinLineView(start: Line.diagonalTopLeft.start,
                        end: Line.diagonalTopLeft.end,
                        color: .red)

            //    |   | x
            // -----------
            //    | x |
            // -----------
            //  x |   |
            WinLineView(start: Line.diagonalTopRight.start,
                        end: Line.diagonalTopRight.end,
                        color: .red)

        }
        .previewLayout(.sizeThatFits)
    }
}
