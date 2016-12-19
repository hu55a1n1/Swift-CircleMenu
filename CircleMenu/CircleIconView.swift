/**
 The MIT License (MIT)
 Copyright (c) 2016 Shoaib Ahmed / Sufi-Al-Hussaini
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//
//  CircleIconView.swift
//  CircleMenu
//
//  Created by Shoaib Ahmed on 11/26/16.
//  Copyright © 2016 Shoaib Ahmed / Sufi-Al-Hussaini. All rights reserved.
//

import UIKit

class CircleIconView: UIView {
    
    public var image: UIImage?
    public var highlightedIconColor = UIColor.green
    public var isSelected: Bool {
        didSet {
            if oldValue != isSelected {
                self.setNeedsDisplay()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        isSelected = false
        
        super.init(frame: frame)
        
        isOpaque = false
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard image != nil else {
            return
        }
        
        if isSelected {
            let context = UIGraphicsGetCurrentContext()
            context!.translateBy(x: 0, y: image!.size.height)
            context!.scaleBy(x: 1.0, y: -1.0)
            context!.setBlendMode(CGBlendMode.color)
            context!.clip(to: self.bounds, mask: image!.cgImage!) // this restricts drawing to within alpha channel
            context!.setFillColor(self.highlightedIconColor.cgColor) // this is your color,  a light reddish tint
            context!.fill(rect)
        }
        else {
            image?.draw(in: rect)
        }
    }
    
}
