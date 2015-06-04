//
//  GameModel.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 4..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol GameModelProtocol: class {
    
}


class GameModel: NSObject {
    let dimension: Int
    
    var hexagonBoard: [[Int]] = [[]]
    
    
    
    init (dimension d: Int) {
        self.dimension = d
        
        for i in 0...2 {
            hexagonBoard[i][i] = 0
        }
        
        super.init()
    }
    
    
    
    
    
    
    
    
}
