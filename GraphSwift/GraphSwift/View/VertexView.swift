//
//  VertexView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import SwiftUI

struct VertexView: View {
    static let width = CGFloat(100)
    
    @State var vertex: Vertex
    
    @ObservedObject var selection: SelectionHandler
    
    var isSelected: Bool {
        return selection.isVertexSelected(vertex)
    }
    
    var body: some View {
        Ellipse()
          .fill(Color.green)
          .overlay(Ellipse()
            .stroke(isSelected ? Color.red : Color.black, lineWidth: isSelected ? 5 : 3))
          .overlay(Text(String(describing: vertex))
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
          .frame(width: VertexView.width, height: VertexView.width, alignment: .center)
    }
}

struct VertexView_Previews: PreviewProvider {
    static var previews: some View {
        let selection1 = SelectionHandler()
        let vertex1 = Vertex(text: "Hello world")
        let selection2 = SelectionHandler()
        let vertex2 = Vertex(text: "I'm selected")
        selection2.selectVertex(vertex2)
        
        return VStack {
            VertexView(vertex: vertex1, selection: selection1)
            VertexView(vertex: vertex2, selection: selection2)
        }
     }
}
