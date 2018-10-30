//
//  Draw2d.swift
//  draw2d
//
//  Created by bblu on 2018/10/23.
//  Copyright © 2018年 cn. All rights reserved.
//

import UIKit

class DrawView: UIView {

    @IBOutlet weak var lblLog: UILabel!
    
    let path=UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat=5.0
    
    func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint
    {
        let x=(p0.x+p1.x)/2
        let y=(p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
    
    @objc func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void
    {
        let currentPoint=panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
        
        if panGestureRecognizer.state == .began
        {
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed
        {
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint=currentPoint
        self.setNeedsDisplay()
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        previousPoint=CGPoint.zero
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        previousPoint=CGPoint.zero
        super.init(coder: aDecoder)!
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches=1
        self.addGestureRecognizer(panGestureRecognizer)
        
    }
    var brush: BaseBrush?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let curPoint = touch.location(in: self)
            lblLog.text = "curPoint:\(curPoint.x),\(curPoint.y)"
        }
    }
    
    override func draw(_ rect:CGRect){
        // Drawing code
        UIColor.green.setStroke()
        path.stroke()
        path.lineWidth=lineWidth
    }
}
