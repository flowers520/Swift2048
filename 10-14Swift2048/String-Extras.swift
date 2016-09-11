

import UIKit

extension String {
    func positionOf(sub:String)->Int {
        var pos = -1
        if let range = self.rangeOfString(sub) {
            if !range.isEmpty {
                pos = self.startIndex.distanceTo(range.startIndex)
            }
        }
        return pos
    }
    
    func subStringFrom(pos:Int)->String {
        var substr = ""
        let start = self.startIndex.advancedBy(pos)
        let end = self.endIndex
        //		print("String: \(self), start:\(start), end: \(end)")
        let range = start..<end
        substr = self[range]
        //		print("Substring: \(substr)")
        return substr
    }
    
    func subStringTo(pos:Int)->String {
        var substr = ""
        let end = self.startIndex.advancedBy(pos-1)
        let range = self.startIndex...end
        substr = self[range]
        return substr
    }
}
