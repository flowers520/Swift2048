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
    var mainVC: MainViewController! 
    var textNum: UITextField!
    
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
        textNum = ViewFactory.createtextField(String(mainVC.maxnumber), action: Selector("numChanged"), sender: self)
        textNum.frame = CGRect(x: 80, y: 100, width: 200, height: 30)
        textNum.returnKeyType = UIReturnKeyType.Done
        self.view.addSubview(textNum)
        
        let labelNum = ViewFactory.createLabel("阀值：")
        labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        
        //创建分段单选控件
        segDimension = ViewFactory.createSegment(["3x3", "4x4", "5x5", "6x6"], action: Selector("dimensionChanged:"), sender: self)
        segDimension.frame = CGRect(x: 80, y: 200, width: 200, height: 30)
        self.view.addSubview(segDimension)
        
        let dman = [3:0, 4:1, 5:2, 6:3]
        
        segDimension.selectedSegmentIndex = dman[mainVC.dimension]!
        
        let labelDm = ViewFactory.createLabel("维度：")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
        
    }

    //阈值的返回
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()//键盘隐藏
        //判断是否改变阈值
        if(textField.text != "\(mainVC.maxnumber)"){
            let num = Int(textField.text!)
            mainVC.maxnumber = num!
            
        }
        if(textField.text == ""){
            mainVC.maxnumber = 2048
            
        }
        
        return true
    }
    
    //添加手势点击是软键盘失去焦点
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let t: UITouch = touch as! UITouch
            if (t.tapCount == 1){
                textNum.resignFirstResponder()
            }
        }
    }
    
    //维度的变化值
    func dimensionChanged(sender: SettingViewController){
        var segVals = [3, 4, 5, 6]
        
        mainVC.dimension = segVals[segDimension.selectedSegmentIndex]
//        print("mainvc.dimension\(mainVC.dimension)")
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
