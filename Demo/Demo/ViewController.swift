//
//  ViewController.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/10/28.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var upLeft: UITableView!
    @IBOutlet weak var upRight: UITableView!
    @IBOutlet weak var downLeft: UITableView!
    @IBOutlet weak var downRight: UITableView!
    
    var upLeftInitFrame: CGRect!
    var upRightInitFrame: CGRect!
    var downLeftInitFrame: CGRect!
    var downRightInitFrame: CGRect!
    
    @IBOutlet weak var label: UILabel!
    
    let margin: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upLeft.backgroundColor = UIColor.blue
        upRight.backgroundColor = UIColor.red
        downLeft.backgroundColor = UIColor.darkGray
        downRight.backgroundColor = UIColor.brown
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        upLeftInitFrame = upLeft.frame
        upRightInitFrame = upRight.frame
        downLeftInitFrame = downLeft.frame
        downRightInitFrame = downRight.frame
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if judgeLocationPoint(location) {
                moveMarker(newPoint: location, oldPoint: touch.previousLocation(in: self.view))
                changeViewsSize(location: location)
            }
        }
    }
    
    func judgeLocationPoint(_ location: CGPoint) -> Bool {
        if label.frame.origin.x < location.x && location.x < label.frame.maxX && label.frame.origin.y < location.y && location.y < label.frame.maxY {
            return true
        } else {
            return false
        }
    }
    
    func moveMarker(newPoint: CGPoint, oldPoint: CGPoint) {
        let dx = newPoint.x - oldPoint.x
        let dy = newPoint.y - oldPoint.y
        label.frame.origin.x += dx
        label.frame.origin.y += dy
    }
    
    func changeViewsSize(location: CGPoint) {
        //upLeftTableView changes size
        upLeft.frame = CGRect(origin: upLeftInitFrame.origin,
                              size: CGSize(width: location.x - upLeft.frame.origin.x,
                                           height: location.y - upLeft.frame.origin.y))
        //upRightTableView changes size
        upRight.frame = CGRect(origin: CGPoint(x: location.x + margin, y: upRightInitFrame.origin.y),
                               size: CGSize(width: upRightInitFrame.maxX - location.x,
                                            height: location.y))
        //downLeftTableView changes size
        downLeft.frame = CGRect(origin: CGPoint(x: downLeftInitFrame.origin.x, y: location.y + margin),
                                size: CGSize(width: location.x,
                                             height: downLeftInitFrame.maxY - location.y))
        //downRightTableView changes size
        downRight.frame = CGRect(origin: CGPoint(x: location.x + margin, y: location.y + margin),
                                 size: CGSize(width: downRightInitFrame.maxX - location.x,
                                              height: downLeftInitFrame.maxY - location.y))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

