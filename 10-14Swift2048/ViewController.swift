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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        setup()
        
    }

    //setup
    func setup(){
        startBtn = UIButton(frame: CGRectMake((screen.width-100)/2, (screen.height-20)/2, 100, 20))
        startBtn.setTitle("Play Game", forState: .Normal)
        startBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        startBtn.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        startBtn.addTarget(self, action: Selector("startGame:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startBtn)
    }
    
    func startGame(sender: UIButton!)
    {
        
        let alertController = UIAlertController(title: "start", message: "Game is start, Are you ready?", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.Default, handler: {
            action in
            self.presentViewController(MainTabViewController(), animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: {
            action in
            self.presentViewController(ViewController(), animated: false, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    

}
