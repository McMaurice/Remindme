//
//  TriangleView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/9/24.
//

import SwiftUI

struct lineView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        lineView()
    }
}
