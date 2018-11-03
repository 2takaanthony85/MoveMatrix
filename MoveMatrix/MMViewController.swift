//
//  MMViewController.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/11/03.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

public class MMViewController: UIViewController, MMComponentType {
    
    public typealias ViewType = UIView
    
    public typealias MarkerType = UILabel
    
    
    public lazy var UpLeftView: UIView = {
        let view = UIView()
        view.frame = CGRect(origin: self.view.frame.origin, size: viewSize)
        view.backgroundColor = upLeftBackColor
        return view
    }()
    
    public lazy var UpRightView: UIView = {
        let view = UIView()
        view.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x + (self.view.frame.width / 2) + 2,
                                            y: self.view.frame.origin.y),
                             size: viewSize)
        view.backgroundColor = upRightBackColor
        return view
    }()
    
    public lazy var DownLeftView: UIView = {
        let view = UIView()
        view.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x,
                                             y: self.view.frame.origin.y + (self.view.frame.height / 2) + 2),
                             size: viewSize)
        view.backgroundColor = downLeftBackColor
        return view
    }()
    
    public lazy var DownRightView: UIView = {
        let view = UIView()
        view.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x + (self.view.frame.width / 2) + 2,
                                             y: self.view.frame.origin.y + (self.view.frame.height / 2) + 2),
                             size: viewSize)
        view.backgroundColor = downRightBackColor
        return view
    }()
    
    public lazy var Marker: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 30, height: 30)
        label.center = self.view.center
        label.backgroundColor = UIColor.black
        return label
    }()
    
    internal lazy var viewSize: CGSize = {
        let size = CGSize(width: self.view.frame.width / 2 - 2, height: self.view.frame.height / 2 - 2)
        return size
    }()
    
    public var upLeftBackColor: UIColor = UIColor(code: "#9BF9CC") {
        didSet {
            UpLeftView.backgroundColor = upLeftBackColor
        }
    }
    
    public var upRightBackColor: UIColor = UIColor(code: "#CEF9DC") {
        didSet {
            UpRightView.backgroundColor = upRightBackColor
        }
    }
    
    public var downLeftBackColor: UIColor = UIColor(code: "#B1F9D0") {
        didSet {
            DownLeftView.backgroundColor = downLeftBackColor
        }
    }
    
    public var downRightBackColor: UIColor = UIColor(code: "#9BF9CC") {
        didSet {
            DownRightView.backgroundColor = downRightBackColor
        }
    }
    
    public var upLeftInitFrame: CGRect!
    
    public var upRightInitFrame: CGRect!
    
    public var downLeftInitFrame: CGRect!
    
    public var downRightInitFrame: CGRect!
    
    //touchFlg
    internal var touchFlg = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _loadView()
        loadTableFrame()
    }
    
    internal func _loadView() {
        self.view.addSubview(UpLeftView)
        self.view.addSubview(UpRightView)
        self.view.addSubview(DownLeftView)
        self.view.addSubview(DownRightView)
        self.view.addSubview(Marker)
    }
    
    internal func loadTableFrame() {
        upLeftInitFrame = UpLeftView.frame
        upRightInitFrame = UpRightView.frame
        downLeftInitFrame = DownLeftView.frame
        downRightInitFrame = DownRightView.frame
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            touchFlg = judgeLocationPoint(location)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if touchFlg {
                moveMarker(newPoint: location, oldPoint: touch.previousLocation(in: self.view))
                changeViewsSize(location: location)
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchFlg = false
        Marker.center = CGPoint(x: UpLeftView.frame.maxX + 2, y: UpLeftView.frame.maxY + 2)
    }
    
    override public var shouldAutorotate: Bool {
        return false
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
