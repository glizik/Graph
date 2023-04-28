//
//  SurfaceView.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 26..
//

import SwiftUI

struct SurfaceView: View {
    @ObservedObject var graph: Graph
    @ObservedObject var selection: SelectionHandler
    
    //dragging
    @State var portalPosition: CGPoint = .zero
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    @State var isDraggingGraph: Bool = false
    
    //zooming
    @State var zoomScale: CGFloat = 1.0
    @State var initialZoomScale: CGFloat?
    @State var initialPortalPosition: CGPoint?
    
    var body: some View {
        VStack {
            // 1
            Text("drag offset = w:\(dragOffset.width), h:\(dragOffset.height)")
            Text("portal offset = x:\(portalPosition.x), y:\(portalPosition.y)")
            Text("zoom = \(zoomScale)")

            TextField("", text: $selection.editingText, onCommit: {
                if let vertex = self.selection.onlySelectedVertex(in: self.graph) {
                    let editedText = self.self.selection.editingText
                    print(editedText)
                    self.graph.updateVertexText(vertex, string: editedText)
                }
            })
            
            // 2
            GeometryReader { geometry in
                // 3
                ZStack {
                    Rectangle().fill(Color.gray)
                    GraphView(selection: self.selection, graph: self.graph)
                    //<-- insert scale here later
                        .scaleEffect(self.zoomScale)
                    // 4
                        .offset(
                            x: self.portalPosition.x + self.dragOffset.width,
                            y: self.portalPosition.y + self.dragOffset.height)
                        .animation(.easeIn)
                }
                //<-- add drag gesture later
                .gesture(DragGesture()
                    .onChanged { value in
                        self.processDragChange(value, containerSize: geometry.size)
                    }
                    .onEnded { value in
                        self.processDragEnd(value)
                    })
                //<-- add magnification gesture later
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        // 1
                        if self.initialZoomScale == nil {
                            self.initialZoomScale = self.zoomScale
                            self.initialPortalPosition = self.portalPosition
                        }
                        self.processScaleChange(value)
                    }
                    .onEnded { value in
                        // 2
                        self.processScaleChange(value)
                        self.initialZoomScale = nil
                        self.initialPortalPosition  = nil
                    })
            }
        }
    }
}

struct SurfaceView_Previews: PreviewProvider {
    static var previews: some View {
        let graph = Graph.sampleGraph()
        let selection = SelectionHandler()
        return SurfaceView(graph: graph, selection: selection)
    }
}

private extension SurfaceView {
    // 1
    func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        let xdelta = pow(pointA.x - pointB.x, 2)
        let ydelta = pow(pointA.y - pointB.y, 2)
        
        return sqrt(xdelta + ydelta)
    }
    
    // 2
    func hitTest(point: CGPoint, parent: CGSize) -> Vertex? {
        let width = CGFloat(100)
        
        for vertex in graph.vertices {
            let endPoint = vertex.position
                .scaledFrom(zoomScale)
                .alignCenterInParent(parent)
                .translatedBy(x: portalPosition.x, y: portalPosition.y)
            let dist =  distance(from: point, to: endPoint) / zoomScale
            
            //3
            if dist < width / 2.0 {
                return vertex
            }
        }
        return nil
    }
    
    // 4
    func processVertexTranslation(_ translation: CGSize) {
        guard !selection.draggingVertices.isEmpty else { return }
        let scaledTranslation = translation.scaledDownTo(zoomScale)
        graph.processVertexTranslation(
            scaledTranslation,
            vertices: selection.draggingVertices)
    }
    
    func processDragChange(_ value: DragGesture.Value, containerSize: CGSize) {
        // 1
        if !isDragging {
            isDragging = true
            
            if let vertex = hitTest(
                point: value.startLocation,
                parent: containerSize
            ) {
                isDraggingGraph = false
                selection.selectVertex(vertex)
                // 2
                selection.startDragging(graph)
            } else {
                isDraggingGraph = true
            }
        }
        
        // 3
        if isDraggingGraph {
            dragOffset = value.translation
        } else {
            processVertexTranslation(value.translation)
        }
    }
    
    // 4
    func processDragEnd(_ value: DragGesture.Value) {
        isDragging = false
        dragOffset = .zero
        
        if isDraggingGraph {
            portalPosition = CGPoint(
                x: portalPosition.x + value.translation.width,
                y: portalPosition.y + value.translation.height)
        } else {
            processVertexTranslation(value.translation)
            selection.stopDragging(graph)
        }
    }
    
    // 1
    func scaledOffset(_ scale: CGFloat, initialValue: CGPoint) -> CGPoint {
        let newx = initialValue.x*scale
        let newy = initialValue.y*scale
        return CGPoint(x: newx, y: newy)
    }
    
    func clampedScale(_ scale: CGFloat, initialValue: CGFloat?)
    -> (scale: CGFloat, didClamp: Bool) {
        let minScale: CGFloat = 0.1
        let maxScale: CGFloat = 2.0
        let raw = scale.magnitude * (initialValue ?? maxScale)
        let value =  max(minScale, min(maxScale, raw))
        let didClamp = raw != value
        return (value, didClamp)
    }
    
    func processScaleChange(_ value: CGFloat) {
        let clamped = clampedScale(value, initialValue: initialZoomScale)
        zoomScale = clamped.scale
        if !clamped.didClamp,
           let point = initialPortalPosition {
            portalPosition = scaledOffset(value, initialValue: point)
        }
    }
}
