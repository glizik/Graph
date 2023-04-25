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
    
    var description: String {
        text
    }
}
