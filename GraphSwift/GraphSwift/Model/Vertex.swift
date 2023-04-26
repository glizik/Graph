//
//  Vertex.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import Foundation

typealias VertexID = UUID

struct Vertex: CustomStringConvertible {
    var id: VertexID = VertexID()
    var position: CGPoint = .zero
    var text: String = ""
    var isOperator = false
    
    var description: String {
        text
    }
    
    static func *(left: Vertex, right: Vertex) -> Graph {
        let graph = Graph()
        graph.updateVertexText(graph.rootVertex(), string: "*")
        graph.handleAsOperator(graph.rootVertex())
        graph.addVertex(left)
        graph.connect(graph.rootVertex(), to: left)
        graph.addVertex(right)
        graph.connect(graph.rootVertex(), to: right)
        return graph
    }
    
    static func +(left: Vertex, right: Vertex) -> Graph {
        let graph = Graph()
        graph.updateVertexText(graph.rootVertex(), string: "+")
        graph.handleAsOperator(graph.rootVertex())
        graph.addVertex(left)
        graph.connect(graph.rootVertex(), to: left)
        graph.addVertex(right)
        graph.connect(graph.rootVertex(), to: right)
        return graph
    }
}
