//
//  MainTabViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit


class MainTabViewController: UITabBarController, KKColorListViewControllerDelegate {

    var viewMain: MainViewController!
    var viewColor: KKColorListViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 一共包含两个视图
        viewMain = MainViewController()
        viewMain.title = "2048"
        let viewSetting = SettingViewController(mainview: viewMain)
        viewSetting.title = "设置"
        
        viewColor = KKColorListViewController(schemeType: KKColorsSchemeType.Crayola)
        viewColor.title = "背景"
        viewColor.headerTitle = "选择背景颜色"
        viewColor.delegate = self
        
        let viewScore = ScoreViewController()
        viewScore.title = "分数"
        
        let color = UINavigationController(rootViewController: viewColor)
        let score = UINavigationController(rootViewController: viewScore)
        
        let main = UINavigationController(rootViewController: viewMain)
        let setting = UINavigationController(rootViewController: viewSetting)
        
        self.viewControllers = [
            main, setting, color, score
        ]
        
        // 默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
        viewMain.callBack = ({ (title: Int) -> Void in
            self.selectedIndex = title
        })
    }

    //颜色处理选中
    func colorListController(controller: KKColorListViewController!, didSelectColor color: KKColor!) {
        viewMain.view.backgroundColor = color.uiColor()
        self.selectedIndex = 0
    }

    //颜色取消选中
    func colorListPickerDidComplete(controller: KKColorListViewController!) {
        self.selectedIndex = 0
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
