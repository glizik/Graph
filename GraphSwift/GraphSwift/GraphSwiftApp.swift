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
            SurfaceView(graph: Graph.sampleGraph3(), selection: SelectionHandler())
        }
    }
}
