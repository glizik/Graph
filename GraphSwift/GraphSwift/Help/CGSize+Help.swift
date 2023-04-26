//
//  CGSize+Help.swift
//  GraphSwift
//
//  Created by Mac on 2023. 04. 26..
//

import Foundation

extension CGSize {
    func scaledDownTo(_ factor: CGFloat) -> CGSize {
        return CGSize(width: width/factor, height: height/factor)
    }
}
