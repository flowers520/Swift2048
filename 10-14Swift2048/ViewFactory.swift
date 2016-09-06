//
//  ViewFactory.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/15.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

class ViewFactory{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    class func getDefaultFrame() -> CGRect {
        let defaultFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width/2, 40)
        return defaultFrame
    }
    
    class func createControl(type: String, title: [String], action: Selector, sender:AnyObject) -> UIView {
        switch(type)
        {
            case "label":
                return ViewFactory.createLabel(title[0])
            case "button":
                return ViewFactory.createButton(title[0], action: action, sender: sender as! UIViewController)
            case "text":
                return ViewFactory.createtextField(title[0], action: action, sender: sender as! UITextFieldDelegate)
            case "segment":
                return ViewFactory.createSegment(title, action: action, sender: sender as! UIViewController)
            default:
                
                return ViewFactory.createLabel(title[0])
        }
    }
    
    //按钮
    class func createButton(title: String, action: Selector, sender: UIViewController) -> UIButton {
        let button = UIButton(frame: ViewFactory.getDefaultFrame())
        
        button.backgroundColor = UIColor.grayColor()
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        button.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        return button
    }
    // 文本
    class func createtextField(value: String, action: Selector, sender: UITextFieldDelegate) -> UITextField {
        let textField = UITextField(frame: ViewFactory.getDefaultFrame())
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.blackColor()
        textField.text = value
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = "Input Threahold..."//输入阈值
        textField.keyboardType = UIKeyboardType.NumberPad
        textField.resignFirstResponder()
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        return textField
    }
    
    //Segment
    class func createSegment(items: [String], action: Selector, sender:UIViewController) -> UISegmentedControl {
        let segment = UISegmentedControl(items: items)
        segment.frame = ViewFactory.getDefaultFrame()
        segment.momentary = false
        segment.addTarget(sender, action: action, forControlEvents: .ValueChanged)
        
        return segment
    }
    
    //标签
    class func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor.clearColor()
        label.text = title;
        label.frame = ViewFactory.getDefaultFrame()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }
}
