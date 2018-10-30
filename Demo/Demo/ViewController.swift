//
//  ViewController.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/10/28.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame.size = CGSize(width: 60, height: 40)
        button.center = view.center
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func tappedButton() {
        let vc = MatrixTableViewController()
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

