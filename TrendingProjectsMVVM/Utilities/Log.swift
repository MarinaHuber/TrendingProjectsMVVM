
//  Copyright © 2020 All rights reserved.
//

import Foundation

public class Log{
    
    static let debug = true
    
    static func wtf(_ TAG: String?, _ MSG: Any){
        print("\(TAG!) : \(MSG)")
    }
    
    static func data(_ TAG: String?, _ data: Data){
        let str = String(data: data, encoding: .utf8)
        wtf(TAG, str ?? "")
    }
}
