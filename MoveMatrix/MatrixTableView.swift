//
//  MatrixTableView.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/11/01.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import UIKit

public class MatrixTableView: UIView, MoveMatrixComponent {

    //
    public lazy var upLeftTable: UITableView = {
        let table = UITableView()
        table.frame = CGRect(origin: self.frame.origin, size: tableSize)
        table.tag = 1
        table.backgroundColor = upLeftTableColor
//        table.dataSource = self
//        table.delegate = self
        return table
    }()
    
    //
    public lazy var upRightTable: UITableView = {
        let table = UITableView()
        table.frame = CGRect(origin: CGPoint(x: self.frame.origin.x + (self.frame.width / 2) + (margin / 2),
                                             y: self.frame.origin.y),
                             size: tableSize)
        table.tag = 2
        table.backgroundColor = upRightTableColor
//        table.dataSource = self
//        table.delegate = self
        return table
    }()
    
    //
    public lazy var downLeftTable: UITableView = {
        let table = UITableView()
        table.frame = CGRect(origin: CGPoint(x: self.frame.origin.x,
                                             y: self.frame.origin.y + (self.frame.height / 2) + (margin / 2)),
                             size: tableSize)
        table.tag = 3
        table.backgroundColor = downLeftTableColor
//        table.dataSource = self
//        table.delegate = self
        return table
    }()
    
    //
    public lazy var downRightTable: UITableView = {
        let table = UITableView()
        table.frame = CGRect(origin: CGPoint(x: self.frame.origin.x + (self.frame.width / 2) + (margin / 2),
                                             y: self.frame.origin.y + (self.frame.height / 2) + (margin / 2)),
                             size: tableSize)
        table.tag = 4
        table.backgroundColor = downRightTableColor
//        table.dataSource = self
//        table.delegate = self
        return table
    }()
    
    //
    internal lazy var tableSize: CGSize = {
        let size = CGSize(width: self.frame.width / 2 - (margin / 2),
                          height: self.frame.height / 2 - (margin / 2))
        return size
    }()
    
    //
    public var upLeftTableColor: UIColor = UIColor(code: "#9BF9CC") {
        didSet {
            upLeftTable.backgroundColor = upLeftTableColor
        }
    }
    
    //
    public var upRightTableColor: UIColor = UIColor(code: "#CEF9DC") {
        didSet {
            upRightTable.backgroundColor = upRightTableColor
        }
    }
    
    //
    public var downLeftTableColor: UIColor = UIColor(code: "#B1F9D0") {
        didSet {
            downLeftTable.backgroundColor = downLeftTableColor
        }
    }
    
    //
    public var downRightTableColor: UIColor = UIColor(code: "#9BF9CC") {
        didSet {
            downRightTable.backgroundColor = downRightTableColor
        }
    }
    
    //MARK: center marker
    internal lazy var label: UILabel = {
        let l = UILabel()
        l.frame.size = CGSize(width: 30, height: 30)
        l.center = self.center
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(upLeftTable)
        self.addSubview(upRightTable)
        self.addSubview(downLeftTable)
        self.addSubview(downRightTable)
        self.addSubview(label)
        
        loadTableFrame()
        loadTableColor()
    }
    
    internal func loadTableFrame() {
        upLeftInitFrame = upLeftTable.frame
        upRightInitFrame = upRightTable.frame
        downLeftInitFrame = downLeftTable.frame
        downRightInitFrame = downRightTable.frame
    }
    
    internal func loadTableColor() {
        upLeftTable.backgroundColor = upLeftTableColor
        upRightTable.backgroundColor = upRightTableColor
        downLeftTable.backgroundColor = downLeftTableColor
        downRightTable.backgroundColor = downRightTableColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            touchFlg = judgeLocationPoint(location)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if touchFlg {
                moveMarker(newPoint: location, oldPoint: touch.previousLocation(in: self))
                changeViewsSize(location: location)
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
