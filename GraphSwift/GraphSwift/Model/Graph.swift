//
//  Graph.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import Foundation

class Graph: ObservableObject, CustomStringConvertible {
    var description: String {
        let vertices = vertices.map { $0.text }
        let edges = edges.map { "\(vertexWithID($0.start)!) -> \(vertexWithID($0.end)!)" }
        return "\(name) graph vertices: \(vertices) \n\tedges:\t\(edges.joined(separator: "\n\t\t\t"))"
    }
    
    let rootVertexID: VertexID
    var name = "root"
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
    
    func updateGraphName(_ name: String) {
        self.name = name
    }
    
    func handleAsOperator(_ sourceVertex: Vertex) {
        var newVertex = sourceVertex
        newVertex.isOperator = true
        replace(sourceVertex, with: newVertex)
    }
    
    func replace(_ vertex: Vertex, with replacement: Vertex) {
        var newSet = vertices.filter { $0.id != vertex.id }
        newSet.append(replacement)
        vertices = newSet
    }
    
    func connect(_ parent: Vertex, to child: Vertex) {
        let newedge = Edge(start: child.id, end: parent.id)
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
        let parentEdges = edges.filter { $0.start == vertex.id }
        if let parentEdge = parentEdges.first,
           let parentVertex = vertexWithID(parentEdge.end) {
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
    
    // operator overload
//    static func *(left: Graph, right: Vertex) -> Graph {
//        let graph = Graph()
//        graph.updateVertexText(graph.rootVertex(), string: "*")
//        graph.addVertex(left)
//        graph.connect(graph.rootVertex(), to: left)
//        graph.addVertex(right)
//        graph.connect(graph.rootVertex(), to: right)
//        return graph
//    }
    
    static func +(left: Graph, right: Vertex) -> Graph {
        let leftGraph = Graph()
        leftGraph.updateVertexText(leftGraph.rootVertex(), string: "a*b")
        leftGraph.vertices.append(contentsOf: left.vertices)
        leftGraph.edges = left.edges
        leftGraph.connect(leftGraph.rootVertex(), to: left.rootVertex())
        let leftRoot = leftGraph.rootVertex()
        
        let newGraph = Graph()
        newGraph.updateGraphName("a*b + c")
        newGraph.updateVertexText(newGraph.rootVertex(), string: "+")
        newGraph.handleAsOperator(newGraph.rootVertex())
        newGraph.vertices.append(contentsOf: leftGraph.vertices)
        newGraph.edges = leftGraph.edges
        newGraph.connect(newGraph.rootVertex(), to: leftRoot)
        newGraph.addVertex(right)
        newGraph.connect(newGraph.rootVertex(), to: right)
        print(newGraph)
        return newGraph
    }
    
    // for dragging
    func processVertexTranslation(_ translation: CGSize, vertices: [DragInfo]) {
        vertices.forEach { draginfo in
            if let vertex = vertexWithID(draginfo.id) {
                let nextPosition = draginfo.originalPosition.translatedBy(x: translation.width, y: translation.height)
                self.positionVertex(vertex, position: nextPosition)
            }
        }
    }
    
    func positionVertex(_ vertex: Vertex, position: CGPoint) {
      var movedVertex = vertex
      movedVertex.position = position
      replace(vertex, with: movedVertex)
      rebuildLinks()
    }
}
