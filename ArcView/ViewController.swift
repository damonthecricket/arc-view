//
//  ViewController.swift
//  ArcView
//
//  Created by Damon Cricket on 18.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    @IBOutlet weak var arcView: ArcView?

    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arcView?.startAngle = 0.0
        arcView?.endAngle = DegreesToRadians(90.0)
        arcView?.radius = 50.0
        arcView?.thickness = 25.0
        arcView?.color = UIColor.black
        arcView?.isClockwise = true
    }
}

func DegreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees / CGFloat(180)
}

func RadiansToDegrees(_ radians: CGFloat) -> CGFloat {
    return CGFloat(180) * radians / CGFloat.pi
}
