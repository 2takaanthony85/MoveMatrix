//
//  MMViewControllerType.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/11/03.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation
import UIKit

public class MMNavigationController: UINavigationController {
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    public override var shouldAutorotate: Bool {
        return false
    }
}

public class MMTabBarController: UITabBarController {
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    public override var shouldAutorotate: Bool {
        return false
    }
}
