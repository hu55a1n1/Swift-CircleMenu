//
//  CircleGestureRecognizer.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 11/25/16.
//  Copyright © 2016 Kindows Tech Solutions. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CircleGestureRecognizer: UIGestureRecognizer {
    
    private let DECELERATION_MULTIPLIER: Double = 30
    
    private var previousTouchDate: Date?
    private var currentTransformAngle: CFloat?
    
    public var isEnded: Bool?
    public var rotation: CGFloat?
    public var controlPoint: CGPoint?
    public var currentThumb: CircleThumb?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = self.view as! Circle
        let touch = touches.first
        let point = touch?.location(in: view)
        
        // Fail when more than 1 finger detected.
        if event!.touches(for: self)!.count > 1 || view.path!.contains(point!) {
            self.state = .failed
        }
        self.isEnded = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.state == .possible {
            state = .began
        }
        else {
            state = .changed
        }
        
        let view = self.view as! Circle
        if !view.isRotate {
            return
        }
        
        // We can look at any touch object since we know we
        // have only 1. If there were more than 1 then
        // touchesBegan:withEvent: would have failed the recognizer.
        let touch = touches.first
        
        // To rotate with one finger, we simulate a second finger.
        // The second figure is on the opposite side of the virtual
        // circle that represents the rotation gesture.
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        let currentTouchPoint = touch?.location(in: view)
        let previousTouchPoint = touch?.previousLocation(in: view)
        
        previousTouchDate = Date()
        
        let angleInRadians: CGFloat = atan2(currentTouchPoint!.y - center.y, currentTouchPoint!.x - center.x) - atan2(previousTouchPoint!.y - center.y, previousTouchPoint!.x - center.x)
        self.rotation = angleInRadians
        currentTransformAngle = atan2f(Float(view.transform.b), Float(view.transform.a))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Perform final check to make sure a tap was not misinterpreted.
        if self.state == .changed {
            let view = self.view as! Circle
            var flipintime: Double = 0
            var angle: Double = 0
            
            if view.isInertiaEffect {
                let angleInRadians: CGFloat = atan2(view.transform.b, view.transform.a) - CGFloat(currentTransformAngle!)
                let time: Double = Date().timeIntervalSince(previousTouchDate!)
                let velocity: Double = Double(angleInRadians)/time
                let a: Double = DECELERATION_MULTIPLIER
                
                flipintime = fabs(velocity)/a
                angle = (velocity * flipintime) - (a * flipintime * flipintime/2)
                
                if (angle>M_PI/2) || (angle<0 && angle < (-M_PI/2)) {
                    if angle < 0 { angle = -M_PI/2.1 }
                    else { angle = M_PI/2.1 }
                    
                    flipintime = 1 / -(a/2*velocity/angle)
                }
            }
            
            UIView.animate(withDuration: flipintime, delay: 0, options: .curveEaseOut, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            }, completion: { (finished: Bool) in
                for thumb in view.thumbs {
                    let thumb = thumb as! CircleThumb
                    
                    let point = thumb.convert(thumb.centerPoint!, to: nil)
                    let shadow: CircleThumb = view.overlayView!.overlayThumb!
                    let shadowRect: CGRect = shadow.superview!.convert(shadow.frame, to: nil)
                    
                    if shadowRect.contains(point) {
                        let deltaAngle: CGFloat = -CircleThumb.radiansFrom(degrees: 180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b)
                        
                        let current = view.transform
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            view.transform = current.rotated(by: deltaAngle)
                        })
                        
                        
                        self.currentThumb?.iconView!.isSelected = false
                        thumb.iconView!.isSelected = true
                        self.currentThumb = thumb
                        
                        view.delegate?.circle(view, didMoveTo: thumb.tag, thumb: thumb)
                        self.isEnded = true
                        break
                    }
                    
                }
            })
            
            currentTransformAngle = 0
            state = .ended
        }
        else {
            let view = self.view as! Circle
            let touch = touches.first
            
            if !view.isRotate {
                for thumb in view.thumbs {
                    let thumb = thumb as! CircleThumb
                    let touchPoint = touch?.location(in: thumb)
                    if thumb.arc!.cgPath.contains(touchPoint!) {
                        view.delegate?.circle(view, didMoveTo: thumb.tag, thumb: thumb)
                    }
                }
                return
            }
            
            // Circle rotation animation code, to move selected thumb to center top position
            for thumb in view.thumbs {
                let thumb = thumb as! CircleThumb
                let touchPoint = touch?.location(in: thumb)
                if thumb.arc!.cgPath.contains(touchPoint!) {
                    let deltaAngle: CGFloat = -CircleThumb.radiansFrom(degrees: 180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b)
                    
                    let current = view.transform
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        view.transform = current.rotated(by: deltaAngle)
                    }, completion: { (finished: Bool) in
                        self.currentThumb?.iconView!.isSelected = false
                        thumb.iconView!.isSelected = true
                        self.currentThumb = thumb
                        
                        view.delegate?.circle(view, didMoveTo: thumb.tag, thumb: thumb)
                        self.isEnded = true
                    })
                    
                    break
                }
            }
            
            self.state = .failed
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.state = .failed
    }
    
}
