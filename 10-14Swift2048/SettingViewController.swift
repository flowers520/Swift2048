//
//  SettingViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {

    var segDimension: UISegmentedControl!
    var mainVC = MainViewController()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    convenience init(mainview:MainViewController)
    {
        self.init(nibName:nil, bundle:nil)
        self.mainVC = mainview
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 205, green: 186, blue: 150, alpha: 0.8)
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
        
        let dman = [3:0,4:1,5:2]
        
        segDimension.selectedSegmentIndex = dman[mainVC.dimension]!
        
        let labelDm = ViewFactory.createLabel("维度：")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
        
    }

    func dimensionChanged(sender: SettingViewController){
        var segVals = [3,4,5]
        mainVC.dimension  = segVals[self.segDimension.selectedSegmentIndex]
        mainVC.resetTapped()
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
