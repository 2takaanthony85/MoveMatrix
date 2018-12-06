//
//  MMComponentType.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/11/03.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

//MMComponentType abstruct type of MoveMatrixView 
public protocol MMComponentType: class {
    
    associatedtype ViewType: UIView
    
    associatedtype MarkerType: UIView
    
    var UpLeftView: ViewType { get set }
    
    var UpRightView: ViewType { get set }
    
    var DownLeftView: ViewType { get set }
    
    var DownRightView: ViewType { get set }
    
    // center marker
    var Marker: MarkerType { get set }
    
    // view backgroundColor
    var upLeftBackColor: UIColor { get set }
    var upRightBackColor: UIColor { get set }
    var downLeftBackColor: UIColor { get set }
    var downRightBackColor: UIColor { get set }
    
    // initialized view frame
    var upLeftInitFrame: CGRect! { get set }
    var upRightInitFrame: CGRect! { get set }
    var downLeftInitFrame: CGRect! { get set }
    var downRightInitFrame: CGRect! { get set }
    
    //judgeLocationPoint touch point judge into marker
    func judgeLocationPoint(_ location: CGPoint) -> Bool
    
    //moveMarker marker changes CGpoint
    func moveMarker(newPoint: CGPoint, oldPoint: CGPoint)
    
    //changeViewSize tableViews change frame
    func changeViewsSize(location: CGPoint)
}

extension MMComponentType {
    
    //judgeLocationPoint touch point judge into marker
    public func judgeLocationPoint(_ location: CGPoint) -> Bool {
        if Marker.frame.origin.x < location.x && location.x < Marker.frame.maxX && Marker.frame.origin.y < location.y && location.y < Marker.frame.maxY {
            return true
        } else {
            return false
        }
    }
    
    //moveMarker marker changes CGpoint
    public func moveMarker(newPoint: CGPoint, oldPoint: CGPoint) {
        let dx = newPoint.x - oldPoint.x
        let dy = newPoint.y - oldPoint.y
        Marker.frame.origin.x += dx
        Marker.frame.origin.y += dy
    }
    
    //changeViewSize tableViews change frame
    public func changeViewsSize(location: CGPoint) {
        //upLeftTableView changes size
        UpLeftView.frame = CGRect(origin: upLeftInitFrame.origin,
                                   size: CGSize(width: location.x - UpLeftView.frame.origin.x,
                                                height: location.y - UpLeftView.frame.origin.y))
        //upRightTableView changes size
        UpRightView.frame = CGRect(origin: CGPoint(x: location.x + 4, y: upRightInitFrame.origin.y),
                                    size: CGSize(width: upRightInitFrame.maxX - location.x,
                                                 height: location.y))
        //downLeftTableView changes size
        DownLeftView.frame = CGRect(origin: CGPoint(x: downLeftInitFrame.origin.x, y: location.y + 4),
                                     size: CGSize(width: location.x,
                                                  height: downLeftInitFrame.maxY - location.y))
        //downRightTableView changes size
        DownRightView.frame = CGRect(origin: CGPoint(x: location.x + 4, y: location.y + 4),
                                      size: CGSize(width: downRightInitFrame.maxX - location.x,
                                                   height: downLeftInitFrame.maxY - location.y))
    }

}

// MMTableType ViewType == UITableView
public protocol MMTableType: MMComponentType where ViewType == UITableView {}

