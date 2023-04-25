//
//  GraphSwiftApp.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 24..
//

import SwiftUI

@main
struct GraphSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            GraphView(selection: SelectionHandler(), graph: Graph.sampleGraph2())
        }
    }
}
