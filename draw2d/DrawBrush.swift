//
//  File.swift
//  draw2d
//
//  Created by bblu on 2018/10/26.
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
class LineBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        context.move(to: beginPoint)
        context.addLine(to: endPoint)
    }
}

class DashLineBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        let lengths: [CGFloat] = [self.strokeWidth * 3, self.strokeWidth * 3]
        context.setLineDash(phase: 2, lengths: lengths)
        //CGContextSetLineDash(context, 0, lengths, 2)
        
        //CGContextMoveToPoint(context, beginPoint.x, beginPoint.y)
        //CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
        context.move(to: beginPoint)
        context.addLine(to: endPoint)
    }
}

class RectangleBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        context.addRect(CGRect(origin: CGPoint(x: min(beginPoint.x, endPoint.x), y: min(beginPoint.y, endPoint.y)),
                               size: CGSize(width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y))))
    }
}

class EllipseBrush: BaseBrush {
    
    override func drawInContext(context: CGContext) {
        context.addEllipse(in:CGRect(origin: CGPoint(x: min(beginPoint.x, endPoint.x), y: min(beginPoint.y, endPoint.y)),
                                     size: CGSize(width: abs(endPoint.x - beginPoint.x), height: abs(endPoint.y - beginPoint.y))))
    }
}

class EraserBrush: PencilBrush {
    
    override func drawInContext(context: CGContext) {
        context.setBlendMode(CGBlendMode.clear)
        
        super.drawInContext(context: context)
    }
}

