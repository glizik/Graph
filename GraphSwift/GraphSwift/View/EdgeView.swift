//
//  EdgeView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import SwiftUI

struct EdgeView: Shape {
    var startx: CGFloat = 0
    var starty: CGFloat = 0
    var endx: CGFloat = 0
    var endy: CGFloat = 0

    init(edge: Line) {
      startx = edge.start.x
      starty = edge.start.y
      endx = edge.end.x
      endy = edge.end.y
    }
    
    func path(in rect: CGRect) -> Path {
      var linkPath = Path()
      linkPath.move(to: CGPoint(x: startx, y: starty)
        .alignCenterInParent(rect.size))
      linkPath.addLine(to: CGPoint(x: endx, y:endy)
        .alignCenterInParent(rect.size))
      return linkPath
    }
}

struct EdgeView_Previews: PreviewProvider {
    static var previews: some View {
        EdgeView()
    }
}
