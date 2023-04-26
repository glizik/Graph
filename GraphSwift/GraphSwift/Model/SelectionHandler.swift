//
//  SelectionHandler.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import Foundation
import CoreGraphics

struct DragInfo {
    var id: VertexID
    var originalPosition: CGPoint
}

class SelectionHandler: ObservableObject {
    @Published private(set) var selectedVertexIDs: [VertexID] = []
    @Published var draggingVertices: [DragInfo] = []
    
    @Published var editingText: String = ""
    
    func isVertexSelected(_ vertex: Vertex) -> Bool {
        return selectedVertexIDs.contains(vertex.id)
    }
    
    func selectVertex(_ vertex: Vertex) {
        selectedVertexIDs = [vertex.id]
        editingText = vertex.text
    }
    
    func selectedVertices(in graph: Graph) -> [Vertex] {
        return selectedVertexIDs.compactMap { graph.vertexWithID($0) }
    }
    
    func startDragging(_ graph: Graph) {
        draggingVertices = selectedVertices(in: graph)
            .map { DragInfo(id: $0.id, originalPosition: $0.position) }
    }
    
    func stopDragging(_ graph: Graph) {
      draggingVertices = []
    }
}
