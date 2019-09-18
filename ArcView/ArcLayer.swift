//
//  ArcLayer.swift
//  ArcView
//
//  Created by Damon Cricket on 18.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ArcLayer

class ArcLayer: CALayer {

    @NSManaged
    var startAngle: CGFloat
    
    @NSManaged
    var endAngle: CGFloat
    
    @NSManaged
    var radius: CGFloat
    
    @NSManaged
    var thickness: CGFloat
    
    @NSManaged
    var color: CGColor
    
    @NSManaged
    var isClockwise: Bool
    
    // MARK: - Object LifeCycle
    
    override init() {
        super.init()
        
        postInitSetup()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let arcLayer = layer as? ArcLayer {
            startAngle = arcLayer.startAngle
            endAngle = arcLayer.endAngle
            radius = arcLayer.radius
            thickness = arcLayer.thickness
            radius = arcLayer.radius
            thickness = arcLayer.thickness
            color = arcLayer.color
            isClockwise = arcLayer.isClockwise
        }
        
        postInitSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        postInitSetup()
    }
    
    func postInitSetup() {
        contentsScale = UIScreen.main.scale
        allowsEdgeAntialiasing = true
        needsDisplayOnBoundsChange = true
    }
    
    // MARK: - Display
    
    override open class func needsDisplay(forKey key: String) -> Bool {
        if key == "startAngle" {
            return true
        } else if key == "endAngle" {
            return true
        } else if key == "radius" {
            return true
        } else if key == "thickness" {
            return true
        } else if key == "color" {
            return true
        } else if key == "isClockwise" {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }
    
    // MARK: - Draw
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        
        ctx.setLineWidth(thickness)
        
        let path = CGMutablePath()
        
        path.addArc(center: CGPoint(x: bounds.maxX/2.0, y: bounds.maxY/2.0), radius: radius + thickness/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: !isClockwise)
        
        ctx.addPath(path)
        
        ctx.setFillColor(UIColor.clear.cgColor)
        
        ctx.setStrokeColor(color)
        
        ctx.strokePath()
        
        UIGraphicsPopContext()
    }
}
