//
//  ViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    let screen = UIScreen.mainScreen().bounds.size
    var startBtn:UIButton!
    var backImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
        
    }

    //setup
    func setup(){
        //图片2048
        backImage = UIImageView(frame: CGRectMake(0, 0, screen.width, screen.height))
        backImage.image = UIImage(named: "screen")
        self.view.addSubview(backImage)

        
        //开始
        startBtn = UIButton(frame: CGRectMake((screen.width-100)/2, screen.height-200, 100, 20))
        startBtn.setTitle("开始游戏", forState: .Normal)
        startBtn.titleLabel?.font = UIFont(name: "Zapfino", size: 25.0)
        startBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(25.0)
        startBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startBtn.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        startBtn.addTarget(self, action: Selector("startGame:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startBtn)
        

    }
    
    func startGame(sender: UIButton!)
    {
        
        let alertController = UIAlertController(title: "游戏开始", message: "游戏即将开始你准备好了吗", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "开始", style: UIAlertActionStyle.Default, handler: {
            action in
            self.presentViewController(MainTabViewController(), animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "退出", style: UIAlertActionStyle.Cancel, handler: {
            action in
            self.presentViewController(ViewController(), animated: false, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    

}

