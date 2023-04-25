//
//  Graph+Demo.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import Foundation

extension Graph {
    static func sampleGraph() -> Graph {
        let graph = Graph()
        graph.updateVertexText(graph.rootVertex(), string: "*")
        let child1 = Vertex(position: CGPoint(x: -100, y: 200), text: "a")
        let child2 = Vertex(position: CGPoint(x: 100, y: 200), text: "b")
        [child1, child2].forEach {
            graph.addVertex($0)
            graph.connect(graph.rootVertex(), to: $0)
        }
        return graph
    }
}
