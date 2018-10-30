//
//  MatrixTableViewController.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/10/30.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import UIKit

public class MatrixTableViewController: UIViewController {
    
    //
    internal lazy var upLeftTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = upLeftTableColor
        table.frame = CGRect(origin: view.frame.origin, size: tableSize)
        return table
    }()
    
    //
    internal lazy var upRightTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = upRightTableColor
        table.frame = CGRect(origin: CGPoint(x: view.frame.origin.x + (view.frame.width / 2) + (margin / 2),
                                             y: view.frame.origin.y),
                             size: tableSize)
        return table
    }()
    
    //
    internal lazy var downLeftTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = downLeftTableColor
        table.frame = CGRect(origin: CGPoint(x: view.frame.origin.x,
                                             y: view.frame.origin.y + (view.frame.height / 2) + (margin / 2)),
                             size: tableSize)
        return table
    }()
    
    //
    internal lazy var downRightTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = downRightTableColor
        table.frame = CGRect(origin: CGPoint(x: view.frame.origin.x + (view.frame.width / 2) + (margin / 2),
                                             y: view.frame.origin.y + (view.frame.height / 2) + (margin / 2)),
                             size: tableSize)
        return table
    }()
    
    //
    internal lazy var tableSize: CGSize = {
        let size = CGSize(width: view.frame.width / 2 - (margin / 2),
                          height: view.frame.height / 2 - (margin / 2))
        return size
    }()
    
    //
    public var upLeftTableColor: UIColor = UIColor.white
    //
    public var upRightTableColor: UIColor = UIColor(code: "#CEF9DC")
    //
    public var downLeftTableColor: UIColor = UIColor(code: "#B1F9D0")
    //
    public var downRightTableColor: UIColor = UIColor(code: "#9BF9CC")
    
    //MARK: center marker
    internal lazy var label: UILabel = {
       let l = UILabel()
       l.frame.size = CGSize(width: 30, height: 30)
       l.center = view.center
       l.backgroundColor = UIColor.cyan
       return l
    }()
    
    //
    internal var upLeftInitFrame: CGRect!
    //
    internal var upRightInitFrame: CGRect!
    //
    internal var downLeftInitFrame: CGRect!
    //
    internal var downRightInitFrame: CGRect!
    
    //MARK:
    let margin: CGFloat = 4
    
    //touchFlg
    internal var touchFlg = false

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(upLeftTable)
        view.addSubview(upRightTable)
        view.addSubview(downLeftTable)
        view.addSubview(downRightTable)
        view.addSubview(label)
        
        upLeftInitFrame = upLeftTable.frame
        upRightInitFrame = upRightTable.frame
        downLeftInitFrame = downLeftTable.frame
        downRightInitFrame = downRightTable.frame
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            touchFlg = judgeLocationPoint(location)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if touchFlg {
                moveMarker(newPoint: location, oldPoint: touch.previousLocation(in: self.view))
                changeViewsSize(location: location)
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchFlg = false
    }
    
    //judgeLocationPoint touch point judge into label
    internal func judgeLocationPoint(_ location: CGPoint) -> Bool {
        if label.frame.origin.x < location.x && location.x < label.frame.maxX && label.frame.origin.y < location.y && location.y < label.frame.maxY {
            return true
        } else {
            return false
        }
    }
    
    //moveMarker : label changes frame
    internal func moveMarker(newPoint: CGPoint, oldPoint: CGPoint) {
        let dx = newPoint.x - oldPoint.x
        let dy = newPoint.y - oldPoint.y
        label.frame.origin.x += dx
        label.frame.origin.y += dy
    }
    
    //changeViewSize tableViews change frame
    internal func changeViewsSize(location: CGPoint) {
        //upLeftTableView changes size
        upLeftTable.frame = CGRect(origin: upLeftInitFrame.origin,
                              size: CGSize(width: location.x - upLeftTable.frame.origin.x,
                                           height: location.y - upLeftTable.frame.origin.y))
        //upRightTableView changes size
        upRightTable.frame = CGRect(origin: CGPoint(x: location.x + margin, y: upRightInitFrame.origin.y),
                               size: CGSize(width: upRightInitFrame.maxX - location.x,
                                            height: location.y))
        //downLeftTableView changes size
        downLeftTable.frame = CGRect(origin: CGPoint(x: downLeftInitFrame.origin.x, y: location.y + margin),
                                size: CGSize(width: location.x,
                                             height: downLeftInitFrame.maxY - location.y))
        //downRightTableView changes size
        downRightTable.frame = CGRect(origin: CGPoint(x: location.x + margin, y: location.y + margin),
                                 size: CGSize(width: downRightInitFrame.maxX - location.x,
                                              height: downLeftInitFrame.maxY - location.y))
    }

}
