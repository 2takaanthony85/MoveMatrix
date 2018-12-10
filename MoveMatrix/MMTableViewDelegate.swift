//
//  MMTableViewDelegate.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/12/10.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

public protocol MMTableViewDelegate {
    
    //delegate method of UITableViewDataSource
    
    func numberOfRowsInSection(tableView: UITableView, number: Int)
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath)
    
    
    //delegate method of UITableViewDelegate
    
    func didSelectRowAt(tableView: UITableView, indexPath: IndexPath)
    
}
