//
//  GameModel.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/17.
//  Copyright © 2015年 jim. All rights reserved.
//

import Foundation

//闭包传值
//typealias cloureScore = (title: String) -> Void

class GameModel {
//    //定义闭包
//    var cloureScoreCallBack: cloureScore!
    
    var dimension: Int = 0
    
    var tiles: Array<Int>!
    var mtiles: Array<Int>!
    var scoredelegate: ScoreViewProtocol!
    var bestscoredelegate: ScoreViewProtocol!
    
    var score: Int = 0
    var bestscore: Int = 0{
        didSet{
            bestscoredelegate.changeScore(value: bestscore)
        }
    }
    
    var maxnumber: Int = 0
    
    // 由外部来传入维度值
    init (dimension: Int, maxnumber: Int, score: ScoreViewProtocol, bestscore: ScoreViewProtocol)
    {
        self.maxnumber = maxnumber
        self.scoredelegate = score
        self.bestscoredelegate = bestscore
        self.dimension = dimension
        self.initTiles()
    }
    
    func initTiles()
    {
        self.tiles = Array<Int>(count:self.dimension*self.dimension, repeatedValue:0)
        self.mtiles = Array<Int>(count:self.dimension*self.dimension, repeatedValue:0)
    }

    //找出空位置
    func emptyPositions() -> [Int]
    {
        var emptytiles = Array<Int>()
        // var index: Int
        for i in 0..<(dimension * dimension)
        {
            if(tiles[i] == 0)
            {
                emptytiles.append(i)
            }
        }
        return emptytiles
    }
    
    func isFull() -> Bool
    {
        if(emptyPositions().count == 0)
        {
            return true
        }
        return false
    }
    
    // 输出当前数据模型
    func printTiles()
    {
//        print(tiles)
//        print("输出数据模型数据")
        let count = tiles.count
        for var i=0; i<count; i++
        {
            if (i+1) % Int (dimension) == 0
            {
                print(tiles[i])
            }
            else
            {
                print("\(tiles[i])\t")
            }
        }
        print(" ")
    }
    
    
    func setPositon(row:Int, col:Int, value:Int) -> Bool
    {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        //3行4列， 即 row=2, col=3 index=2*4+3 =11
        //4行4列， 即 3*4+3 =15
        let index = self.dimension * row + col
        let val = tiles[index]
        if(val > 0)
        {
            print("该位置(\(row), \(col)已经有值了)")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func isSuccess() -> Bool
    {
        for i in 0..<(dimension*dimension)
        {
            if(tiles[i] >= maxnumber)
            {
                return true
            }
        }
        return false
    }

    
    func copyToMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            mtiles[i] = tiles[i]
        }
    }
    
    func copyFromMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            tiles[i] = mtiles[i]
        }
    }
    
//MARK: 数据模型变更
    func reflowUp()
    {
        copyToMtiles()
        var index: Int
        //从最后一行开始找
        // 为什么是i>0, 而不是i>=0, 因为第一行不用再动了
        for var i=dimension-1; i>0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                // 如果当前位置有值，上一行没有值
                if(mtiles[index - self.dimension] == 0) && (mtiles[index] > 0)
                {
                    //把下一行的值赋值到上一行
                    mtiles[index - self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex: Int = index
                    //因为当前行发生了移动，得让其后面的行跟上
                    //否则滑动重排之后，会出现空隙
                    while(subindex + self.dimension < mtiles.count)
                    {
                        if(mtiles[subindex + self.dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + self.dimension]
                            mtiles[subindex + self.dimension] = 0
                        }
                        subindex += self.dimension
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowDown()
    {
        copyToMtiles()
        var index: Int
        //从第一行开始往下走
        //只找到dimension-i行，因为最下面一行不用再动了
        for i in 0..<dimension-1
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                //如果当前位置有值，下一行相应的位置没有值
                if (mtiles[index + self.dimension] == 0) && (mtiles[index] > 0)
                {
                    //把这一行的值赋值到下一行
                    mtiles[index + self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    var subindex: Int = index
                    //对后面的内容进行检查
                    //因为当下面的行发生了移动，得让上面的行跟上
                    //否则滑动重排之后，会出现空隙
                    while((subindex - self.dimension) >= 0)
                    {
                        if(mtiles[subindex - self.dimension] > 0)
                        {
                            mtiles[index] = mtiles[subindex - self.dimension]
                            mtiles[subindex - self.dimension] = 0
                        }
                        subindex -= self.dimension
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowLeft()
    {
        copyToMtiles()
        var index: Int
        //从最右列开始往左找
        //只找到第2列，因为第一列的数据不用再动了
        for i in 0..<dimension
        {
            for var j=dimension-1; j>0; j--
            {
                index = self.dimension * i + j
                //如果当前位置有值，而且其左边一列，即前一个位置没有值，则移动
                if(mtiles[index-1] == 0) &&  (mtiles[index] > 0)
                {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    var subindex: Int = index
                    //对右边的内容进行检查，如果出现空隙则补上
                    while((subindex + 1) < i * dimension + dimension)
                    {
                        if(mtiles[subindex+1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex+1]
                            mtiles[subindex+1] = 0
                        }
                        subindex += 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowRight()
    {
        copyToMtiles()
        var index: Int
        //从第一列开始往右找
        //只找到dimension-1列，因为最右边一列不用再动了
        for i in 0..<dimension
        {
            for j in 0..<dimension-1
            {
                index = self.dimension * i + j
                // 如果当前位置有值，而且右边位置没有值
                if(mtiles[index+1] == 0)
                    && (mtiles[index] > 0)
                {
                    mtiles[index+1] = mtiles[index]
                    mtiles[index] = 0
                    var subindex: Int = index
                    //对后面的内容进行检查
                    //补上右边的空白快，以免出现空隙
                    while((subindex-1) > i*dimension-1)
                    {
                        if(mtiles[subindex-1]>0)
                        {
                            mtiles[subindex] = mtiles[subindex-1]
                            mtiles[subindex-1] = 0
                        }
                        subindex -= 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    
//MARK: 合并方法
    //分数值变化
    func changeScore(value: Int){
        score += value
        if(bestscore < score){
            bestscore = score
        }
        scoredelegate.changeScore(value: score)
        bestscoredelegate.changeScore(value: bestscore)
    }
    // 向上合并的方法
    func mergeUp()
    {
        copyToMtiles()
        var index: Int
        //从上到上合
        for var i=1; i<dimension; i++
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                //如果相同列上，而且相邻的数字相等
                if((mtiles[index] > 0) && (mtiles[index-self.dimension] == mtiles[index]))
                {
                    //将数字合并到上面行的位置，下面的数字清空
                    mtiles[index - self.dimension] = mtiles[index] * 2
                    mtiles[index] = 0
                    changeScore(mtiles[index]*2)
                }
            }
        }
        copyFromMtiles()
    }
    
    // 向下合并的方法
    func mergeDown()
    {
        copyToMtiles()
        var index: Int
        //从上到下合
        for var i=dimension-2; i>=0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                //如果下一行的数字和当前行数字
                if((mtiles[index] > 0) && (mtiles[index+self.dimension] == mtiles[index]))
                {
                    //将叠加合并后的结果放置到下一行。上一行的数字清空
                    mtiles[index+self.dimension] = mtiles[index] * 2
                    mtiles[index] = 0
                    changeScore(mtiles[index]*2)
                }
            }
        }
        copyFromMtiles()
    }
    
    //向左合并的方法
    func mergeLeft()
    {
        copyToMtiles()
        var index:Int
        //从右到左合并
        for i in 0..<dimension
        {
            for var j=1; j<dimension; j++
            {
                index = self.dimension * i + j
                //如果邮编和左边的数字相邻的相等，则合并
                if(mtiles[index] > 0 && mtiles[index-1] == mtiles[index])
                {
                    //叠加合并到左边一列，右边一列当前位置上的数字清空
                    mtiles[index-1] = mtiles[index] * 2
                    mtiles[index] = 0
                    changeScore(mtiles[index]*2)
                }
            }
        }
        copyFromMtiles()
    }
    
    //向右合并的方法
    func mergeRight()
    {
        copyToMtiles()
        var index: Int
        //从左向右合
        for i in 0..<dimension
        {
            for var j=dimension-2; j>=0; j--
            {
                index = self.dimension * i + j
                //如果当前数字和正右边相邻的数字相等，则可以合并
                if (mtiles[index] > 0 && mtiles[index+1] == mtiles[index] )
                {
                    //叠加合并到右边一列，左边当前位置相应的数字清空
                    mtiles[index+1] = mtiles[index] * 2
                    mtiles[index] = 0
                    changeScore(mtiles[index]*2)
                }
            }
        }
        copyFromMtiles()
    }
    
}
