//
//  File.swift
//  draw2d
//
//  Created by zoomway on 2018/10/26.
//  Copyright © 2018年 zw. All rights reserved.
//

import UIKit
import CoreGraphics

protocol PaintBrush {
    
    func supportedContinuousDrawing() -> Bool
    
    func drawInContext(context: CGContext)
}

class BaseBrush : NSObject, PaintBrush {
    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var lastPoint: CGPoint?
    
    var strokeWidth: CGFloat!
    
    func supportedContinuousDrawing() -> Bool {
        return false
    }
    
    func drawInContext(context: CGContext) {
        assert(false, "must implements in subclass.")
    }
}

class PencilBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        if let lastPoint = self.lastPoint {
            context.move(to: lastPoint)
            context.addLine(to: endPoint)
        } else {
            context.move(to: beginPoint)
            context.addLine(to: endPoint)
        }
    }
    
    override func supportedContinuousDrawing() -> Bool {
        return true
    }
}
