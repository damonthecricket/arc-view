//
//  ArcView.swift
//  ArcView
//
//  Created by Damon Cricket on 18.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ArcView

class ArcView: UIView {

    var startAngle: CGFloat {
        set {
            arcLayer.startAngle = newValue
        } get {
            return arcLayer.startAngle
        }
    }
    
    var endAngle: CGFloat {
        set {
            arcLayer.endAngle = newValue
        } get {
            return arcLayer.endAngle
        }
    }
    
    var radius: CGFloat {
        set {
            arcLayer.radius = newValue
        } get {
            return arcLayer.radius
        }
    }
    
    var thickness: CGFloat {
        set {
            arcLayer.thickness = newValue
        } get {
            return arcLayer.thickness
        }
    }
    
    var color: UIColor {
        set {
            arcLayer.color = newValue.cgColor
        } get {
            return UIColor(cgColor: arcLayer.color)
        }
    }
    
    var isClockwise: Bool {
        set {
            arcLayer.isClockwise = newValue
        } get {
            return arcLayer.isClockwise
        }
    }

    var arcLayer: ArcLayer {
        return layer as! ArcLayer
    }
    
    override open class var layerClass: AnyClass {
        return ArcLayer.self
    }
}
