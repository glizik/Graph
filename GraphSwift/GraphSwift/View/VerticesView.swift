//
//  VerticesView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import SwiftUI

struct VerticesView: View {
    @ObservedObject var selection: SelectionHandler
    @Binding var vertices: [Vertex]
    
    var body: some View {
        ZStack {
            ForEach(vertices, id: \.id/*.visualID*/) { vertex in
              VertexView(vertex: vertex, selection: self.selection)
              .offset(x: vertex.position.x,
                      y: vertex.position.y)
              .onTapGesture {
                self.selection.selectVertex(vertex)
              }
          }
        }
    }
}

struct VerticesView_Previews: PreviewProvider {
    static let vertex1 = Vertex(position: CGPoint(x: -100, y: -30), text: "hello")
    static let vertex2 = Vertex(position: CGPoint(x: 100, y: 30), text: "world")
    @State static var vertices = [vertex1, vertex2]
    
    static var previews: some View {
        let selection = SelectionHandler()
        return VerticesView(selection: selection,
                            vertices: $vertices)
    }
}
