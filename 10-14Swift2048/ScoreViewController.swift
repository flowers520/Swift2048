

import UIKit


class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let screen = UIScreen.mainScreen().bounds.size
    var tableView: UITableView!
    var gameModel: GameModel!
    var mainVC: MainViewController!

    
//    var refreshControl: UIRefreshControl!
//
//    var gameScore = 0{
//        didSet{
//            gameScore = gameBestScore.count
//        }
//    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 205, green: 186, blue: 150, alpha: 0.8)
        
        setup()
        
    
    }

    //MARK: setup
    func setup(){
        //tableview
        tableView = UITableView(frame: CGRectMake(0, 30, screen.width, screen.height-60))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableView)
       
//        //refreshcontrol
//        refreshControl.addTarget(self, action: Selector("refreshData"), forControlEvents: .ValueChanged)
//        self.view.addSubview(refreshControl)
//        
//        mainVC.refresh = ({() -> Void in
//            self.tableView.reloadData()
//        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    
//    //刷新数据
//    func refreshData(){
//        self.tableView.reloadData()
//    }
//    //下拉刷新
//    func setupRefresh(){
//        //添加刷新控件
//        var control:UIRefreshControl!
//        control.addTarget(self, action: Selector("refreshStateChange:"), forControlEvents: .ValueChanged)
//        self.view.addSubview(control)
//        //马上进入刷新状态，并不触发valueChange事件
//        control.beginRefreshing()
//        //加载数据
//        self.re
//        
//    }

    //返回节数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("gameBestScore: \(gameBestScore.count)")
        return gameBestScore.count
    }
    
    //单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: NSString = "cell"
        //        let cellIdentifier: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier as String)
        //判断表格是否为空
        if(cell == ""){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier as String)
            cell.backgroundColor = UIColor.clearColor()
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }
        
        cell.textLabel?.text = "分数：\(gameBestScore.objectAtIndex(indexPath.row))"
        cell.detailTextLabel?.text = "时间：\(gameTime.objectAtIndex(indexPath.row))"
        
        return cell
    }
    //滑动删除要实现的方法
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        gameBestScore.removeObjectAtIndex(indexPath.row)
        gameTime.removeObjectAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
    }
    
    
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    //修改删除按钮
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    //设置cell的显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //设置cell的显示动画为3d缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy缩放的最终值为1
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
        
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
