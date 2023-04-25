//
//  Graph.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import Foundation

class Graph: ObservableObject {
    let rootVertexID: VertexID
    @Published var vertices: [Vertex] = [] {
        didSet {
            print("Number of vertices: \(vertices.count)")
            print("\titems: [\(vertices)]")
        }
    }
    @Published var editingText: String
    
    init() {
        print("Graph created")
        self.editingText = ""
        let root = Vertex(text: "root")
        self.rootVertexID = root.id
        addVertex(root)
    }
    
    func rootVertex() -> Vertex {
        guard let root = vertices.filter({ $0.id == rootVertexID }).first else {
            fatalError("Graph is invalid - no root")
        }
        return root
    }
    
    func addVertex(_ vertex: Vertex) {
        vertices.append(vertex)
    }
    
    func updateVertexText(_ sourceVertex: Vertex, string: String) {
        var newVertex = sourceVertex
        newVertex.text = string
        replace(sourceVertex, with: newVertex)
    }
    
    func replace(_ vertex: Vertex, with replacement: Vertex) {
        var newSet = vertices.filter { $0.id != vertex.id }
        newSet.append(replacement)
        vertices = newSet
    }
    
    func connect(_ parent: Vertex, to child: Vertex) {
        let newedge = Edge(start: parent.id, end: child.id)
        let exists = edges.contains(where: { edge in
            return newedge == edge
        })
        
        guard exists == false else {
            return
        }
        
        edges.append(newedge)
    }
    
    var edges: [Edge] = [] {
        didSet {
            rebuildLinks()
        }
    }
    @Published var links: [Line] = []
    
    func rebuildLinks() {
        links = edges.compactMap { edge in
            let startVertex = vertices.filter({ $0.id == edge.start }).first
            let endVertex = vertices.filter({ $0.id == edge.end }).first
            if let startVertex = startVertex, let endVertex = endVertex {
                return Line(id: edge.id, start: startVertex.position, end: endVertex.position)
            }
            return nil
        }
    }
    
    func vertexWithID(_ vertexID: VertexID) -> Vertex? {
        return vertices.filter({ $0.id == vertexID }).first
    }
    
    func locateParent(_ vertex: Vertex) -> Vertex? {
        let parentEdges = edges.filter { $0.end == vertex.id }
        if let parentEdge = parentEdges.first,
           let parentVertex = vertexWithID(parentEdge.start) {
            return parentVertex
        }
        return nil
    }
    
    func distanceFromRoot(_ vertex: Vertex, distance: Int = 0) -> Int? {
        if vertex.id == rootVertexID { return distance }
        
        if let ancestor = locateParent(vertex) {
            if ancestor.id == rootVertexID {
                return distance + 1
            } else {
                return distanceFromRoot(ancestor, distance: distance + 1)
            }
        }
        return nil
    }
}
