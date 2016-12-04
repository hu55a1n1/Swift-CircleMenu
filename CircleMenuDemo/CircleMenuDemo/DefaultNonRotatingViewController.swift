//
//  DefaultNonRotatingViewController.swift
//  CircleMenuDemo
//
//  Created by Shoaib Ahmed on 12/2/16.
//  Copyright © 2016 Kindows Tech Solutions. All rights reserved.
//

import UIKit

class DefaultNonRotatingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNonRotatingCircleMenu()
    }
    
    func prepareView() {
        view.backgroundColor = UIColor.lightGray
    }
    
    func prepareNonRotatingCircleMenu() {
        // Create circle
        let circle = Circle(with: CGRect(x: 10, y: 90, width: 300, height: 300), numberOfSegments: 10, ringWidth: 80.0, isRotating: false)
        // Set dataSource and delegate
        circle.dataSource = self
        circle.delegate = self
        
        // Position and customize
        circle.center = view.center
        
        // Add to view
        self.view.addSubview(circle)
        
        // NOTE: Do not add overlay for non-rotating circle
    }
    
}


extension DefaultNonRotatingViewController: CircleDelegate, CircleDataSource {
    
    func circle(_ circle: Circle, didMoveTo segment: Int, thumb: CircleThumb) {
        let alert = UIAlertController(title: "Selected", message: "Item with tag: \(segment)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func circle(_ circle: Circle, iconForThumbAt row: Int) -> UIImage {
        return UIImage(named: "icon_arrow_up")!
    }
    
}

