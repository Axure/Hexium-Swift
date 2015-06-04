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
    
    var hexagonBoard = [Int: Int]()
    let coordinateConverter: CoordinateConverter
    
    
    init (dimension d: Int) {
        self.dimension = d
        hexagonBoard[hashPair((0, 0))] = 0
        for i in 0...self.dimension {
            for j in 0..<6 * i {
                hexagonBoard[hashPair((i, j))] = 0
            }
        }
        self.coordinateConverter = CoordinateConverter(dimension: d)
        super.init()
    }
    
    
    
    func increaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil) {
                hexagonBoard[hashPair(neighbor)]! += 1
            }

        }
        
    }
    
    func decreaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil) {
                hexagonBoard[hashPair(neighbor)]! -= 1
            }
        }
    }
    
    
}
