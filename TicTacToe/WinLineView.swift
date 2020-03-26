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



struct Line: Shape {
    //  [1, 1]  |  [0.5, 1]  | [0, 1]
    // --------------------------------
    // [1, 0.5] | [0.5, 0.5] | [0, 0.5]
    // --------------------------------
    //  [1, 0]  |  [0.5, 0]  | [0, 0]

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

    @State private var isAnimating = false
    var body: some View {
        Line(start: start, end: end)
            .trim(from: isAnimating ? 0 : 1, to: 1)
            .stroke(color, lineWidth: 15)
            .animation(Animation
                .easeInOut(duration: 0.6)
            .delay(0.5))
            .padding()
            .onAppear {
                withAnimation {
                    self.isAnimating.toggle()
                }
            }
    }
}

struct WinLineView_Previews: PreviewProvider {
    static var previews: some View {
        WinLineView(start: [1, 1], end: [0, 0], color: .red)
            .previewLayout(.sizeThatFits)
    }
}
