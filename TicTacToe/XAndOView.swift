//
//  OView.swift
//  TicTacToe
//
//  Created by Terry Latanville on 2020-03-23.
//  Copyright © 2020 Sixth Pixel. All rights reserved.
//

import SwiftUI

extension CGRect {
    var minDimension: CGFloat { min(width, height) }
    var center: CGPoint { CGPoint(x: midX, y: midY) }
    var topLeading: CGPoint { CGPoint(x: minX, y: minY) }
    var topTrailing: CGPoint { CGPoint(x: maxX, y: minY) }
    var bottomLeading: CGPoint { CGPoint(x: minX, y: maxY) }
    var bottomTrailing: CGPoint { CGPoint(x: maxX, y: maxY) }
}

infix operator ++: AdditionPrecedence
infix operator +-: AdditionPrecedence
infix operator -+: AdditionPrecedence
infix operator --: AdditionPrecedence

extension CGPoint {
    static func ++(lhs: CGPoint, length: CGFloat) -> CGPoint { CGPoint(x: lhs.x + length, y: lhs.y + length) }
    static func +-(lhs: CGPoint, length: CGFloat) -> CGPoint { CGPoint(x: lhs.x + length, y: lhs.y - length) }
    static func -+(lhs: CGPoint, length: CGFloat) -> CGPoint { CGPoint(x: lhs.x - length, y: lhs.y + length) }
    static func --(lhs: CGPoint, length: CGFloat) -> CGPoint { CGPoint(x: lhs.x - length, y: lhs.y - length) }
}

struct X: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = rect.minDimension / 2
        var path = Path()
        path.move(to: rect.center ++ radius)
        path.addLine(to: rect.center -- radius)
        path.move(to: rect.center -+ radius)
        path.addLine(to: rect.center +- radius)

        return path
    }
}

struct OView: View {
    let color: Color
    @State var aniamte = false
    var body: some View {
        Circle()
            .trim(from: aniamte ? 0 : 1, to: 1)
            .stroke(lineWidth: 15)
            .foregroundColor(color)
            .padding()
            .rotationEffect(.degrees(5), anchor: .center)
            .animation(.easeInOut(duration: 0.4))
            .onAppear() {
                self.aniamte.toggle()
        }
    }
}

struct XView: View {
    let color: Color
    @State var aniamte = false
    var body: some View {
        ZStack {
            X()
            .trim(from: aniamte ? 0 : 1, to: 1)
            .stroke(lineWidth: 15)
            .foregroundColor(color)
            .padding()
            .animation(.easeInOut(duration: 0.4))
            .onAppear() {
               self.aniamte.toggle()
            }
        }
    }
}

struct OView_Previews: PreviewProvider {
    @State static var animate = false
    static var previews: some View {
        Group {
            OView(color: .red)
                .previewLayout(.sizeThatFits)
            XView(color: .blue)
                .previewLayout(.sizeThatFits)
        }
    }
}
