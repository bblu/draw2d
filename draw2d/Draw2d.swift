//
//  Draw2d.swift
//  draw2d
//
//  Created by bblu on 2018/10/23.
//  Copyright © 2018年 zw. All rights reserved.
//

import UIKit

class Draw2d: UIView {

    @IBOutlet weak var lblLog: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let curPoint = touch.location(in: self)
            lblLog.text = "curPoint:\(curPoint.x),\(curPoint.y)"
        }
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components:[CGFloat] = [1.0, 0.0, 0.0, 0.0]
        let color = CGColor(colorSpace: colorSpace, components:components)
        context?.setStrokeColor(color!)
        context?.move(to: CGPoint(x:40, y:30))
        context?.addLine(to: CGPoint(x:400, y:300))
        context?.strokePath()
        let rect = CGRect(x:40,y:30,width:400,height:300)
        self.draw(rect);
    }
    
    override func draw(_ rect:CGRect){
        //
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components:[CGFloat] = [0.0, 0.0, 1.0, 1.0]
        let color = CGColor(colorSpace: colorSpace, components:components)
        
        context?.setLineWidth(2.0)
        context?.setStrokeColor(color!)
        context?.move(to: CGPoint(x:30, y:30))
        context?.addLine(to: CGPoint(x:300, y:400))
        context?.strokePath()
    }
}
