//
//  GameModel.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 4..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol GameModelProtocol: class {
    func placeAPiece(cor: (Int, Int), number n: Int)
    func updateAPiece(cor: (Int, Int), number n: Int)
}


class GameModel: NSObject {
    let dimension: Int
    
    var hexagonBoard = [Int: Int]()
    let coordinateConverter: CoordinateConverter
    
    let delegate: GameModelProtocol
    
    
    init (dimension d: Int, delegate dg: GameModelProtocol) {
        self.dimension = d
        self.delegate = dg
        hexagonBoard[hashPair((0, 0))] = -1
        for i in 1...self.dimension {
            for j in 0..<6 * i {
                hexagonBoard[hashPair((i, j))] = -1
            }
        }
        self.coordinateConverter = CoordinateConverter(dimension: d)
        super.init()
        randomStart()
        
    }
    
    func randomStart() {
        for i in 0...self.dimension {
            for j in 0..<6 * i {
                if (random() % 3 == 0) {
                    placeAPiece((i, j))
                }
            }
        }
        // The initial setup can be done by first calculating then drawing once for better performance
    }
    
    func reauthModel() {
        reauthCor((0, 0))
        for i in 0...self.dimension {
            for j in 0..<6 * i {
                reauthCor((i, j))
            }
        }
    }
    
    func placeAPiece(cor: (Int, Int)) {
        // if
        if (hexagonBoard[hashPair(cor)] == -1) {
            hexagonBoard[hashPair(cor)] = 0
            increaseNear(cor)
            reauthCor(cor)
            delegate.placeAPiece(cor, number: hexagonBoard[hashPair(cor)]!)
        } else {
            println("Model says position taken")
        }
        
    }
    
    func placeAPieceWithTwo(cor: (Int, Int)) {
        placeAPiece(coordinateConverter.twoToHex(cor))
    }
    
    
    func reauthCor(cor: (Int, Int)) {

        if (hexagonBoard[hashPair(cor)]) != nil && (hexagonBoard[hashPair(cor)]) != -1 { // If here exists and not empty
            hexagonBoard[hashPair(cor)] = 0 // reset it
            let nearCors = self.coordinateConverter.neighborIndex(cor) // get neighbors
            for neighbor in nearCors {
                if ((hexagonBoard[hashPair(neighbor)]) != nil) { // if neighbor exists
                    if (hexagonBoard[hashPair(neighbor)]! != -1) { // and is not empty
                        hexagonBoard[hashPair(cor)]! += 1 // increase the count
                    }
                }
                
            }
        }
    }
    
    func increaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil && (hexagonBoard[hashPair(neighbor)]) != -1) { // If neighbor exists and is not empty
                hexagonBoard[hashPair(neighbor)]! += 1
                delegate.updateAPiece(neighbor, number: hexagonBoard[hashPair(neighbor)]!)
            }

        }
        
    }
    
    func decreaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil && (hexagonBoard[hashPair(neighbor)]) != -1) { // If neighbor exists and is not empty
                hexagonBoard[hashPair(neighbor)]! -= 1
                delegate.updateAPiece(neighbor, number: hexagonBoard[hashPair(neighbor)]!)
            }
        }
    }
    
    
}
