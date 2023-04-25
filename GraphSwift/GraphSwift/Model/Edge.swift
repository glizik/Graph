//
//  File.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import Foundation

typealias EdgeID = UUID

struct Edge: Identifiable, Equatable {
    var id = EdgeID()
    var start: VertexID
    var end: VertexID
}

struct Line: Identifiable {
    var id: EdgeID
    var start: CGPoint
    var end: CGPoint
}
