/**
 The MIT License (MIT)
 Copyright (c) 2016 Shoaib Ahmed / Sufi-Al-Hussaini
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//
//  CircleOverlayView.swift
//  CircleMenu
//
//  Created by Shoaib Ahmed on 11/26/16.
//  Copyright © 2016 Shoaib Ahmed / Sufi-Al-Hussaini. All rights reserved.
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
    
    required init?(with circle: Circle) {
        if !circle.isRotate {
            fatalError("init(with:) called for non-rotating circle")
        }
        
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


