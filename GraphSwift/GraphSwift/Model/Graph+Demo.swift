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
        graph.handleAsOperator(graph.rootVertex())
        let child1 = Vertex(position: CGPoint(x: -100, y: 200), text: "a")
        let child2 = Vertex(position: CGPoint(x: 100, y: 200), text: "b")
        [child1, child2].forEach {
            graph.addVertex($0)
            graph.connect(graph.rootVertex(), to: $0)
        }
        return graph
    }
    
    static func sampleGraph2() -> Graph {
        let a = Vertex(position: CGPoint(x: -100, y: 200), text: "a")
        let b = Vertex(position: CGPoint(x: 100, y: 200), text: "b")
        return a * b
    }

    static func sampleGraph3() -> Graph {
        let a_mul_b = sampleGraph2()
        let c = Vertex(position: CGPoint(x: 50, y: 100), text: "c")
        return a_mul_b + c
    }

}
