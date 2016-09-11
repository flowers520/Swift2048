//
//  ScoreView.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

enum ScoreType{
    case Common // 普通分数面板
    case Best  // 最高分面板
}

//分数协议
protocol ScoreViewProtocol{
    func changeScore(value s: Int)
}

class ScoreView: UIView, ScoreViewProtocol {

    var label: UILabel!
    let defaultFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width/2, 40)
    var stype: String! //显示最高分还是分数
    var score: Int = 0{
        willSet{
            //分数变化，标签内容也要变化
            label.text = "\(stype):\(newValue)"
        }
    }
    
    //传入分数面板的类型，用于控制标签的显示
    init(stype: ScoreType){
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        super.init(frame: defaultFrame)
        self.stype = (stype == ScoreType.Common ? "分数" : "最高分")
        backgroundColor = UIColor.clearColor()
        label.font = UIFont(name: "微软雅黑", size: 16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeScore(value s: Int) {
        score = s
    }
    

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
