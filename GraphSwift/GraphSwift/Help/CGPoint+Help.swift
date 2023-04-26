//
//  CGPoint+Help.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 25..
//

import Foundation

extension CGPoint {
    func alignCenterInParent(_ parent: CGSize) -> CGPoint {
        let x = parent.width/2 + self.x
        let y = parent.height/2 + self.y
        return CGPoint(x: x, y: y)
    }
    
    func scaledFrom(_ factor: CGFloat) -> CGPoint {
      return CGPoint(
        x: self.x * factor,
        y: self.y * factor)
    }
    
    func translatedBy(x: CGFloat, y: CGFloat) -> CGPoint {
      return CGPoint(x: self.x + x, y: self.y + y)
    }
}
