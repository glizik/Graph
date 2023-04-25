//
//  EdgeMapView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import SwiftUI

struct EdgesView: View {
    @Binding var edges: [Line]
    var body: some View {
        ZStack {
          ForEach(edges) { edge in
            EdgeView(edge: edge)
              .stroke(Color.black, lineWidth: 3.0)
          }
        }
    }
}

struct EdgesView_Previews: PreviewProvider {
    static let line1 = Line(
      id: EdgeID(),
      start: .zero,
      end: CGPoint(x: -100, y: 30))
    static let line2 = Line(
      id: EdgeID(),
      start: .zero,
      end: CGPoint(x: 100, y: 30))

    @State static var edges = [line1, line2]

    static var previews: some View {
        EdgesView(edges: $edges)
    }
}
