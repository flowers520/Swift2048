//
//  MainViewController.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/14.
//  Copyright © 2015年 jim. All rights reserved.
//

import UIKit

enum Animation2048Type
{
    case None   // 无动画
    case New    // 新出现动画
    case Merge  // 合并动画
}

class MainViewController: UIViewController, UIAlertViewDelegate {

    //获取屏幕尺寸
    let screen = UIScreen.mainScreen().bounds.size
    //游戏方格维度
    var dimension: Int = DEFAULT_DIMENSION {
        //变化后做
        didSet{
            gmodel.dimension = dimension
            
            width = (UIScreen.mainScreen().bounds.width - CGFloat(15)) / CGFloat(dimension) - CGFloat(5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //游戏过关最大值
    var maxnumber: Int = 2048

    //数字格子的宽度
    var width: CGFloat = (UIScreen.mainScreen().bounds.width - CGFloat(15)) / CGFloat(DEFAULT_DIMENSION) - CGFloat(5)
//        {
//        //计算属性
//        get{
//            return (UIScreen.mainScreen().bounds.width - CGFloat(15)) / CGFloat(dimension) - CGFloat(5)
//        }
//    }
    //格子与格子的间距
    var padding: CGFloat = 5
    //保存背景图数据
    var backgrounds: Array<UIView>!

    var gmodel: GameModel!
    
    var score: ScoreView!
    
    var bestscore: ScoreView!
    
    //保存界面上的数字Label数据
    var tiles: Dictionary<NSIndexPath, TileView>!
    //保存实际数字值的一个字典
    var tileVals: Dictionary<NSIndexPath, Int>!

    
    init() {
        self.backgrounds = Array<UIView>()
        super.init(nibName: nil, bundle: nil)
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 205, green: 186, blue: 150, alpha: 0.8)
        setupGameMap()
        setupScoreLabels()
        self.gmodel = GameModel(dimension: self.dimension, maxnumber: self.maxnumber, score:score, bestscore:bestscore)
        for _ in 0...1
        {
            genNumber()
        }
        gmodel.printTiles()
        setupSwipeGuestures()
        setupButtons()
        
//        print("MainViewController\(dimension)")
//        print("MainVC\(width)")
        
    }

    //手势重置
    func resetTapped()
    {
        print("reset")
        resetUI()
        gmodel.initTiles()
        for _ in 0..<2
        {
            genNumber()
        }
    }
    
    func genTapped()
    {
        genNumber()
    }
    
    //UI重置
    func resetUI()
    {
        for(_, tile) in tiles
        {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
        
        //背景图
        for background in backgrounds {
            background.removeFromSuperview()
        }
        
        setupGameMap()
    }

    
    func setupButtons()
    {
        let btnreset = ViewFactory.createButton("Reset", action: Selector("resetTapped"), sender:self)
        btnreset.frame.origin.x = 0
        btnreset.frame.origin.y = screen.height - 89
        self.view.addSubview(btnreset)
        
        let btngen = ViewFactory.createButton("NewNumber",action:Selector("genTapped"),sender:self)
        btngen.frame.origin.x = screen.width/2
        btngen.frame.origin.y = screen.height - 89
        self.view.addSubview(btngen)
        
    }
    
    func setupScoreLabels()
    {
        score = ScoreView(stype: ScoreType.Common)
        score.frame.origin = CGPointMake(0, 70)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = ScoreView(stype: ScoreType.Best)
        bestscore.frame.origin.x = screen.width/2
        bestscore.frame.origin.y = 70
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
    

    
    func setupGameMap()
    {
        var x: CGFloat = 10
        var y: CGFloat = (screen.height - screen.width - 70)/2 + 50
        
        for i in 0..<dimension
        {
            print("setupGameMap-i-\(i)")
            y = 150
            for j in 0..<dimension
            {
                print("setupGameMap-j-\(j)")
                //初始化视图
                let backGround = UIView(frame: CGRectMake(x, y, width, width))
                backGround.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(backGround)
                
                //将视图保存起来，以备后用
                backgrounds.append(backGround)
                y += padding + width
            }
            x += padding + width
        }
        
    }



    func genNumber()
    {
        //用于确定随机数的概率
        let randv = Int(arc4random_uniform(10))
        print(randv)
        var seed: Int = 2
        //因为有10%的机会，出现1，所以这里是10%的机会给4
        if(randv == 1)
        {
            seed = 4
        }
        
        //随机生成行号和列号
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        

        //执行后续操作
        if(gmodel.isFull())
        {
            print("位置已经满了")
            let alertcontroller = UIAlertController(title: "Game Over", message: "You are GG !", preferredStyle: .Alert)
            alertcontroller.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.Default, handler: {
                action in
                    //重新开始
                    self.resetUI()
                    self.resetTapped()
            }))
            alertcontroller.addAction(UIAlertAction(title: "Give Up", style: UIAlertActionStyle.Cancel, handler: {
                action in
                    self.presentViewController(ViewController(), animated: true, completion: nil)
            }))
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if(gmodel.setPositon(row, col: col, value: seed) == false)
        {
            genNumber()
            return
        }
        
        insertTile((row, col), value: seed, atype:Animation2048Type.New)
    }

    
    // 滑动手势
    func setupSwipeGuestures()
    {
        //监控向上的方向
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        //监控向下的方向，相应处理方法swipeDown
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        //监控向左的方向，相应处理方法swipeLeft
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        //监控向右的方向，相应处理方法swipeRight
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func _showTip(direction: String)
    {
        let alertController = UIAlertController(title: "提示", message: "你刚刚向\(direction)滑动了！", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func swipeUp()
    {
        print("swipeUp")
        //_showTip("上")
        gmodel.reflowUp()
        gmodel.mergeUp()
        gmodel.reflowUp()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }
    }
    
    func swipeDown()
    {
        print("swipeDown")
        //_showTip("下")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }

    }
    
    func swipeLeft()
    {
        print("swipeLeft")
       // _showTip("左")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }

    }
    
    func swipeRight()
    {
        print("swipeRight")
        //_showTip("右")
        gmodel.reflowRight()
        gmodel.mergeRight()
        gmodel.reflowRight()
        initUI()
        if(!gmodel.isSuccess())
        {
            genNumber()
        }

    }

    
    func initUI()
    {
        
        var index: Int
        var key: NSIndexPath
        var tile: TileView
        var tileVal: Int
        
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                index = i * self.dimension + j
                key = NSIndexPath(forRow: i, inSection: j)
                // 原来界面没有值，模型数据中有值
                if((gmodel.tiles[index] > 0) && tileVals.indexForKey(key) == nil)
                {
                    insertTile((i, j), value: gmodel.tiles[index], atype: Animation2048Type.Merge)
                }
                // 原来界面中有值，现在模型中没有值了
                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                //原来有值，但是现在还有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key)) != nil)
                {
                    tileVal = tileVals[key]!
                    //如果不相等，换掉值就可以了
                    if(tileVal != gmodel.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.value = gmodel.tiles[index]
                        tileVals[key] = gmodel.tiles[index]
                    }
                    //如果相等，当然什么也不用做了
                }
            }
        }
    }

    
    func insertTile(pos:(Int, Int), value: Int, atype: Animation2048Type)
    {
        let (row, col) = pos;
        let x = 10 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x, y), width: width, value: value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        //保存数字块视图和数字块上数字键，是NSIndexPath类型
        let index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        //设置动画的初始状态
        //如果不需要动画
        if(atype == Animation2048Type.None)
        {
            return
        }
        else if(atype == Animation2048Type.New)//生出新数字
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        }
        else if(atype == Animation2048Type.Merge) //合并中的数字
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: {
            () -> Void in tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            }, completion: {
                (finished: Bool) -> Void in UIView.animateWithDuration(0.08, animations: {
                    () -> Void in tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
    }
}


