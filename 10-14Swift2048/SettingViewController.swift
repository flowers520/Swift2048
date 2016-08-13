//
//  SettingViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupControls()
    }

    
    func setupControls()
    {
        //创建文本输入框
        let txtNum = ViewFactory.createtextField(" ", action: Selector("numChanged"), sender: self)
        txtNum.frame = CGRect(x: 80, y: 100, width: 200, height: 30)
        txtNum.returnKeyType = UIReturnKeyType.Done
        self.view.addSubview(txtNum)
        
        let labelNum = ViewFactory.createLabel("阀值：")
        labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        
        //创建分段单选控件
        let segDimension = ViewFactory.createSegment(["3x3", "4x4", "5x5"], action: "dimensionChanged:", sender: self)
        segDimension.frame = CGRect(x: 80, y: 200, width: 200, height: 30)
        self.view.addSubview(segDimension)
        segDimension.selectedSegmentIndex = 1
        
        let labelDm = ViewFactory.createLabel("维度：")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
