//
//  DefaultRotatingViewController.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 11/25/16.
//  Copyright © 2016 Shoaib Ahmed / Sufi-Al-Hussaini. All rights reserved.
//

import UIKit

class DefaultRotatingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareDefaultCircleMenu()
    }
    
    func prepareView() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func prepareDefaultCircleMenu() {
        // Create circle
        let circle = Circle(with: CGRect(x: 10, y: 90, width: 300, height: 300), numberOfSegments: 10, ringWidth: 80.0)
        // Set dataSource and delegate
        circle.dataSource = self
        circle.delegate = self
        
        // Position and customize
        circle.center = view.center
        
        // Create overlay with circle
        let overlay = CircleOverlayView(with: circle)
        
        // Add to view
        self.view.addSubview(circle)
        self.view.addSubview(overlay!)
    }
}


extension DefaultRotatingViewController: CircleDelegate, CircleDataSource {
    
    func circle(_ circle: Circle, didMoveTo segment: Int, thumb: CircleThumb) {
        let alert = UIAlertController(title: "Selected", message: "Item with tag: \(segment)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func circle(_ circle: Circle, iconForThumbAt row: Int) -> UIImage {
        return UIImage(named: "icon_arrow_up")!
    }
    
}

