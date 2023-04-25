//
//  MapView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import SwiftUI

struct GraphView: View {
    @ObservedObject var selection: SelectionHandler

    @ObservedObject var graph: Graph

    var body: some View {
        ZStack {
          Rectangle().fill(Color.gray)
          EdgesView(edges: $graph.links)
          VerticesView(selection: selection, vertices: $graph.vertices)
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        let graph = Graph()
        let child1 = Vertex(position: CGPoint(x: 100, y: 200), text: "a")
        let child2 = Vertex(position: CGPoint(x: -100, y: 200), text: "b")
        [child1, child2].forEach {
            graph.addVertex($0)
            graph.connect(graph.rootVertex(), to: $0)
        }
        let selection = SelectionHandler()
        return GraphView(selection: selection, graph: graph)
    }
}
