//
//  CustomViewController.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 11/25/16.
//  Copyright © 2016 Kindows Tech Solutions. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    let numberOfThumbs = 8
    var circle: Circle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareCustomCircleMenu()
    }
    
    func prepareView() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func prepareCustomCircleMenu() {
        circle = Circle(with: CGRect(x: 10, y: 90, width: 300, height: 300), numberOfSegments: numberOfThumbs, ringWidth: 80.0, isRotating: true, iconWidth: 35, iconHeight: 35)
        circle?.dataSource = self
        circle?.delegate = self
        
        let overlay = CircleOverlayView(with: circle)
        circle?.overlayView?.overlayThumb.arcColor = UIColor.clear
        circle?.circleColor = UIColor.clear
        
        // Customize thumbs
        for (_, thumb) in (circle?.thumbs.enumerated())! {
            let thumb = thumb as! CircleThumb
            
            thumb.iconView.highlightedIconColor = UIColor.blue
            thumb.iconView.isSelected = false
            thumb.iconView.isHidden = false
            thumb.separatorStyle = .none
            thumb.isGradientFill = false
            thumb.arcColor = UIColor.clear
            
            // Add circular border to icon
            thumb.iconView.layer.borderWidth = 1
            thumb.iconView.layer.masksToBounds = false
            thumb.iconView.layer.borderColor = UIColor.white.cgColor
            thumb.iconView.layer.cornerRadius = thumb.iconView.frame.height/2
            thumb.iconView.layer.backgroundColor = UIColor.clear.cgColor
            thumb.iconView.clipsToBounds = true
        }
        
        // Center circle and overlay
        overlay!.center = view.center
        circle?.center = view.center
        
        // Add circle and overlay to view
        self.view.addSubview(circle!)
        self.view.addSubview(overlay!)
    }
    
}


extension CustomViewController: CircleDelegate, CircleDataSource {
    
    func circle(_ circle: Circle, didMoveTo segment: Int, thumb: CircleThumb) {
        let alert = UIAlertController(title: "Selected", message: "Item with tag: \(segment)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        thumb.iconView.isSelected = false
//        thumb.iconView.isHidden = false
        
        // Rotate selected icon
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            thumb.iconView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        })
        
        UIView.animate(withDuration: 0.2, delay: 0.15, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            thumb.iconView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 2))
        }, completion: nil)
    }
    
    func circle(_ circle: Circle, iconForThumbAt row: Int) -> UIImage {
//        let thumb = circle.thumbs[row] as! CircleThumb
//        thumb.iconView.isSelected = false
//        thumb.iconView.isHidden = false
        return UIImage(named: "icon_arrow_up")!
    }
    
}


extension UIView {
    
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
}
