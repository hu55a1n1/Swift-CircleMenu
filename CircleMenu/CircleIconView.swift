//
//  CircleIconView.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 11/26/16.
//  Copyright © 2016 Kindows Tech Solutions. All rights reserved.
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
