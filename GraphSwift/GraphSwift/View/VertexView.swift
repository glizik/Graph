//
//  VertexView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import SwiftUI

struct VertexView: View {
    static let width: CGFloat(100)
    
    @State var node: Node
    
    @ObservedObject var selection: SelectionHandler
    
    var isSelected: Bool {
        return selection.isNodeSelected(node)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct VertexView_Previews: PreviewProvider {
    static var previews: some View {
        VertexView()
    }
}
