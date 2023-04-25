//
//  ListView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import SwiftUI

struct ListView: View {
    @ObservedObject var selection: SelectionHandler

    @ObservedObject var graph: Graph

    func indent(_ vertex: Vertex) -> CGFloat {
      let base = 20.0
      
      return CGFloat(graph.distanceFromRoot(vertex) ?? 0) * CGFloat(base)
    }
    
    var body: some View {
        List(graph.vertices, id: \.id) { vertex in
          Text(vertex.text)
            .padding(EdgeInsets(
              top: 0,
              leading: self.indent(vertex),
              bottom: 0,
              trailing: 0))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let graph = Graph.sampleGraph()
        let selection = SelectionHandler()
        
        return ListView(selection: selection, graph: graph)
    }
}
