//
//  CircleOverlayView.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 11/26/16.
//  Copyright © 2016 Kindows Tech Solutions. All rights reserved.
//

import UIKit

class CircleOverlayView: UIView {
    
    public var overlayThumb: CircleThumb!
    public var circle: Circle?
    public var controlPoint: CGPoint?
    public var buttonCenter: CGPoint?
    
    open override var center: CGPoint {
        didSet {
            self.circle?.center = buttonCenter!
        }
    }
    
    required init(with circle: Circle) {
        let frame = circle.frame
        super.init(frame: frame)
        
        self.isOpaque = false
        self.circle = circle
        self.circle?.overlayView = self
        
        var rect1 = CGRect(x: 0, y: 0, width: self.circle!.frame.height - (2*circle.ringWidth), height: self.circle!.frame.width - (2*circle.ringWidth))
        rect1.origin.x = self.circle!.frame.size.width/2 - rect1.size.width/2
        rect1.origin.y = 0
        
        overlayThumb = CircleThumb(with: rect1.size.height/2, longRadius: self.circle!.frame.size.height/2, numberOfSegments: self.circle!.numberOfSegments)
        overlayThumb?.isGradientFill = false
        
        overlayThumb?.layer.position = CGPoint(x: frame.width/2, y: circle.ringWidth/2)
        self.controlPoint = overlayThumb?.layer.position
        self.addSubview(overlayThumb!)
        
        overlayThumb?.arcColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
        self.buttonCenter = CGPoint(x: frame.midX, y: circle.frame.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
}


