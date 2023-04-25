//
//  VertexView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import SwiftUI

struct VertexView: View {
    @State var vertex: Vertex
    
    @ObservedObject var selection: SelectionHandler
    
    var body: some View {
        Ellipse()
          .fill(Color.green)
          .overlay(Ellipse()
            .stroke(strokeColor(),
                lineWidth: lineWidth()))
          .overlay(Text(String(describing: vertex))
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0,
                                leading: DrawingConstants.leadingPadding,
                                bottom: 0,
                                trailing: DrawingConstants.trailingPadding)))
          .frame(width: DrawingConstants.width, height: DrawingConstants.width, alignment: .center)
    }
    
    // MARK: -- private
    
    private var isSelected: Bool {
        return selection.isVertexSelected(vertex)
    }
    
    private func strokeColor() -> Color {
        isSelected ? DrawingConstants.selectedColor :
            DrawingConstants.unSelectedColor
    }
    
    private func lineWidth() -> CGFloat {
        isSelected ? DrawingConstants.selectedWidth :
            DrawingConstants.unSelectedWidth
    }
    
    private struct DrawingConstants {
        static let width = CGFloat(100)
        
        static let selectedColor: Color = .red
        static let unSelectedColor: Color = .black
        
        static let selectedWidth: CGFloat = 5
        static let unSelectedWidth: CGFloat = 3
        
        static let leadingPadding: CGFloat = 8
        static let trailingPadding: CGFloat = 8
    }
}

struct VertexView_Previews: PreviewProvider {
    static var previews: some View {
        let selection1 = SelectionHandler()
        let vertex1 = Vertex(text: "Hello world, Hello world, Hello world, Hello world")
        let selection2 = SelectionHandler()
        let vertex2 = Vertex(text: "I'm selected")
        selection2.selectVertex(vertex2)
        
        return VStack {
            VertexView(vertex: vertex1, selection: selection1)
            VertexView(vertex: vertex2, selection: selection2)
        }
     }
}


