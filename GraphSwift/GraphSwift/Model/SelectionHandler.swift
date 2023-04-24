//
//  SelectionHandler.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import Foundation
import CoreGraphics

class SelectionHandler: ObservableObject {
    @Published private(set) var selectedVertexIDs: [VertexID] = []

    @Published var editingText: String = ""

    func isVertexSelected(_ vertex: Vertex) -> Bool {
      return selectedVertexIDs.contains(vertex.id)
    }

    func selectVertex(_ vertex: Vertex) {
      selectedVertexIDs = [vertex.id]
      editingText = vertex.text
    }
}
