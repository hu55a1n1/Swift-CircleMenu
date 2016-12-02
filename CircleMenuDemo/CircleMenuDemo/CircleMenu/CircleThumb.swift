/**
 The MIT License (MIT)
 Copyright (c) 2016 Shoaib Ahmed / Sufi-Al-Hussaini
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//
//  CircleThumb.swift
//  CircleMenu
//
//  Created by Shoaib Ahmed on 11/25/16.
//  Copyright © 2016 Shoaib Ahmed / Sufi-Al-Hussaini. All rights reserved.
//

import UIKit

class CircleThumb: UIView {
    
    enum CGGradientPosition {
        case vertical
        case horizontal
    }
    
    let kIconViewWidth: CGFloat =  30
    let kIconViewHeight: CGFloat = 30
    
    private var numberOfSegments: CGFloat
    //    private var bigArcHeight: CGFloat
    //    private var smallArcWidth: CGFloat
    
    public let sRadius: CGFloat
    public let lRadius: CGFloat
    //    public let yydifference: CGFloat?
    public var arc: UIBezierPath?
    public var separatorColor: UIColor?
    public var separatorStyle: Circle.ThumbSeparatorStyle
    public var centerPoint: CGPoint?
    public var colorsLocations: Array<CGFloat>?
    public var isGradientFill: Bool
    public var gradientColors = [UIColor.black.cgColor, UIColor.gray.cgColor]
    public var arcColor: UIColor?
    
    public var iconView: CircleIconView!
    
    
    required init(with shortRadius: CGFloat, longRadius: CGFloat, numberOfSegments sNumber: Int) {
        var frame: CGRect?
        
        var width: CGFloat
        var height: CGFloat
        
        let fstartAngle: CGFloat = CGFloat(270 - ((360/sNumber)/2))
        let fendAngle: CGFloat = CGFloat(270 + ((360/sNumber)/2))
        
        let startAngle: CGFloat = CircleThumb.radiansFrom(degrees: fstartAngle)
        let endAngle: CGFloat = CircleThumb.radiansFrom(degrees: fendAngle)
        
        
        let bigArc = UIBezierPath(arcCenter: CGPoint(x: longRadius, y: longRadius), radius:longRadius, startAngle:startAngle, endAngle:endAngle, clockwise: true)
        let smallArc = UIBezierPath(arcCenter: CGPoint(x: longRadius, y: longRadius), radius:shortRadius, startAngle:startAngle, endAngle:endAngle, clockwise: true)
        
        // Start of calculations
        if ((fendAngle - fstartAngle) <= 180) {
            width = bigArc.bounds.size.width
            height = smallArc.currentPoint.y
            frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
        if ((fendAngle - fstartAngle) > 269) {
            frame = CGRect(x: 0, y: 0, width: bigArc.bounds.size.width, height: bigArc.bounds.size.height)
        }
        //End of calculations
        
        
        numberOfSegments = CGFloat(sNumber)
        sRadius = shortRadius
        lRadius = longRadius
        separatorStyle = .basic
        isGradientFill = false
        
        super.init(frame: frame!)
        
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        
        let y: CGFloat = (lRadius - sRadius)/2.00
        let xi: CGFloat = 0.5
        let yi: CGFloat = y/frame!.size.height
        self.layer.anchorPoint = CGPoint(x: xi, y: yi)
        self.isGradientFill = true
        self.arcColor = UIColor.green
        self.centerPoint = CGPoint(x: self.bounds.midX, y: y)
        self.iconView = CircleIconView(frame: CGRect(x: frame!.midX, y: y, width: kIconViewWidth, height: kIconViewHeight))
        self.iconView!.center = CGPoint(x: frame!.midX, y: y)
        self.addSubview(self.iconView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        arcColor?.setStroke()
        arcColor?.setFill()
        
        //Angles
        let clockwiseStartAngle = CircleThumb.radiansFrom(degrees: (270 - ((360/numberOfSegments)/2)))
        let clockwiseEndAngle = CircleThumb.radiansFrom(degrees: (270 + ((360/numberOfSegments)/2)))
        
        let nonClockwiseStartAngle = clockwiseEndAngle
        let nonClockwiseEndAngle = clockwiseStartAngle
        
        let center = CGPoint(x: rect.midX, y: lRadius)
        
        arc = UIBezierPath(arcCenter: center, radius: lRadius, startAngle: clockwiseStartAngle, endAngle: clockwiseEndAngle, clockwise: true)
        let f = arc?.currentPoint
        arc?.addArc(withCenter: center, radius: sRadius, startAngle: nonClockwiseStartAngle, endAngle: nonClockwiseEndAngle, clockwise: false)
        
        let e = arc?.currentPoint
        
        arc?.close()
        
        let context = UIGraphicsGetCurrentContext()
        
        if !self.isGradientFill {
            arc?.fill()
        }
        else {
            // Gradient color code
            var la = [CGFloat]()
            let path = arc?.cgPath
            if (gradientColors.count == 2) {
                la.insert(0.00, at: 0)
                la.insert(1.00, at: 1)
            }
            else
            {
                if colorsLocations == nil {
                    for var i in (0..<gradientColors.count) {
                        let fi = gradientColors.count-1
                        let point = CGFloat(1.00)/CGFloat(fi)
                        la.insert(point*CGFloat(i), at: i)
                        i+=1
                    }
                }
                else {
                    for var i in (0..<colorsLocations!.count) {
                        la.insert(colorsLocations![i], at: i)
                        i+=1
                    }
                }
            }
            
            drawLinearGradient(context: context!, path: path!, colors: gradientColors as CFArray, position: .horizontal, locations: la, rect: rect)
        }
        
        UIColor.lightGray.setStroke()
        UIColor.lightGray.setFill()
        
        
        if (self.separatorStyle != .none) {
            let line = UIBezierPath()
            if (separatorStyle == .basic) {
                line.lineWidth = 1.0;
            }
            
            
            line.move(to: f!)
            line.addLine(to: CGPoint(x: f!.x - e!.x, y: e!.y))
            separatorColor?.setStroke()
            separatorColor?.setFill()
            
            line.stroke(with: .copy, alpha: 1.00)
            line.fill(with: .copy, alpha: 1.00)
        }
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
    static func radiansFrom(degrees: CGFloat) -> CGFloat {
        return (CGFloat(M_PI) * (degrees) / 180.0)
    }
    
    static func degreesFrom(radians: CGFloat) -> CGFloat {
        return ((radians) / CGFloat(M_PI) * 180)
    }
    
    func drawLinearGradient(context: CGContext, path: CGPath, colors: CFArray, position: CGGradientPosition, locations: [CGFloat], rect: CGRect) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch (position) {
        case .horizontal:
            startPoint = CGPoint(x: rect.midX, y: rect.minY)
            endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        case .vertical:
            startPoint = CGPoint(x: rect.minX, y: rect.midY)
            endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        }
        
        context.saveGState()
        context.addPath(path)
        context.clip()
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context.restoreGState()
        
        //        CGGradientRelease(gradient);
        //        CGColorSpaceRelease(colorSpace);
    }
    
    
}
