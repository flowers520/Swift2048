//
//  UserModel.swift
//  10-14Swift2048
//
//  Created by jim on 15/10/21.
//  Copyright © 2015年 jim. All rights reserved.
//

import Foundation

class UserModel {
    var db: SQLiteDB!
    class func get_uuid() -> String {
        let userid = NSUserDefaults.standardUserDefaults().stringForKey("swift2048user")
        if(userid != nil){
            return userid!
        }else{
            let uuid_ref = CFUUIDCreate(nil)
            let uuid_string_ref = CFUUIDCreateString(nil, uuid_ref)
            let uuid: String = NSString(format: uuid_string_ref) as String
            NSUserDefaults.standardUserDefaults().setObject(uuid, forKey: "swift2048user")
            return uuid
        }
        print("uuid----------\(userid)")
    }
    
    //初始化数据
    init(dimension: Int, maxnum: Int, backgroundColor: UIColor){
        //获取数据库实例
        db = SQLiteDB.sharedInstance()

//        //如果表不存在则创建表
//        db.execute("create table if not exists userdata(userid integer primary key, dimension varchar(1), maxnum varchar(4), red varchar(10), green varchar(10), blue varchar(10), alpha varchar(10))")

        
        var cicolor: CIColor!
        cicolor = CIColor(color: backgroundColor)
        let red = cicolor.red
        let green = cicolor.green
        let blue = cicolor.blue
        let alpha = cicolor.alpha
        
        let userid = UserModel.get_uuid()
        let data = db.query("select * from userdata where userid='\(userid)'")
        print("init初始化数据\(data)")
        
        if(data.count == 0 || data[0].data["dimension"]!.integer == 0){
            let sql = "insert into userdata(userid, dimension, maxnum, red, green, blue, alpha) values('\(userid)', \(dimension), \(maxnum), \(red), \(green), \(blue), \(alpha))"
            db.execute(sql)
            
            print("sql....\(sql)")
        }
        
        
    }
    
    
    init(){
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
//        //如果表不存在则创建表
//        db.execute("create table if not exists userdata(userid integer primary key, dimension varchar(1), maxnum varchar(4), red varchar(10), green varchar(10), blue varchar(10), alpha varchar(10))")
//        
        print("userModelInit()......")
    }
    
    //获得现在保存的数据
    func get_userdata() -> Dictionary<String, String>{
        let userid = UserModel.get_uuid()
        let data = db.query("select * from userdata where userid=\(userid)")
        
        print("userModel\(data)")
        
        let row = data[0]
        let maxnum: Int = row["maxnum"]!.integer
        let dimension: Int = row["diension"]!.integer
        let red: Double = row["red"]!.asDouble
        let green: Double = row["green"]!.asDouble
        let blue: Double = row["blue"]!.asDouble
        let alpha: Double = row["alpha"]!.asDouble
        
        let dic: Dictionary<String, String> = [
            "maxnum": "\(maxnum)",
            "dimension": "\(dimension)",
            "red": "\(red)",
            "green": "\(green)",
            "blue": "\(blue)",
            "alpha": "\(alpha)"
        ];
        return dic
    }
    
    //保存维度数据
    func save_dimension(dimension: Int){
        let userid = UserModel.get_uuid()
        db.execute("update userdata set dimension=\(dimension) where userid='\(userid)'")
    }
    
    //保存过关最大成绩
    func save_maxnum(maxnum: Int){
        let userid = UserModel.get_uuid()
        db.execute("update userdata set maxnum=\(maxnum) where userid='\(userid)'")
    }
    
    //保存颜色数据
    func save_color(backgroundColor: UIColor){
        var cicolor: CIColor
        cicolor = CIColor(color: backgroundColor)
        let red = cicolor.red
        let green = cicolor.green
        let blue = cicolor.blue
        let alpha = cicolor.alpha
        let userid = UserModel.get_uuid()
        
        db.execute("update userdata set red=\(red), green=\(green), blue=\(blue), alpha=\(alpha) where userid='\(userid)'")
    }
}
