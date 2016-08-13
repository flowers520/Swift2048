//
//  ViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    
    @IBAction func startGame(sender: UIButton)
    {
        
        let alertController = UIAlertController(title: "开始！", message: "游戏就要开始了，你准备好了吗？", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ready Go!", style: UIAlertActionStyle.Default, handler: {
        action in
            self.presentViewController(MainTabViewController(), animated: true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }


    


}

