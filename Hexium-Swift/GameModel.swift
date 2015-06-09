//
//  GameModel.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 4..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol GameModelProtocol: class {
    func placeAPiece(cor: (Int, Int), number n: ModelPoint) // Note that we are passing the piece to the view... So we do need all the properties I think... Otherwise we may simple pass a color and the expected number? Or just update the number? Maybe we should not store data in the view.
    func updateAPiece(cor: (Int, Int), number n: ModelPoint)
    func removeAPiece(cor: (Int, Int))
    func startMoveAPiece(cor: (Int, Int))
    func successMoveAPiece(src: (Int, Int), dest: (Int, Int))
    func failMoveAPiece(src: (Int, Int))
}

struct ModelPoint {
    var expected, actual: Int
    
    init(expected e: Int, actual a: Int) {
        self.expected = e
        self.actual = a
    }
}

class PolygonView: UIView {
    
}

class HexagonView: UIView {
    
}

class BasePieceView: UIView {
    
}

class BackgroundPieceView: UIView {
    
}

// When should I write delegates/protocols myself?
// Should I write the color changer delegate?

class GameModel: NSObject {
    let dimension: Int
    
    var hexagonBoard = [Int: ModelPoint]()
    let coordinateConverter: CoordinateConverter
    
    let delegate: GameModelProtocol
    
    var pieceInMove: (Int, Int)?
    var pieceInMoveExpected: Int?
    
    
    init (dimension d: Int, delegate dg: GameModelProtocol) {
        self.dimension = d
        self.delegate = dg
        hexagonBoard[hashPair((0, 0))] = ModelPoint(expected: -1, actual: -1)
        for i in 1...self.dimension {
            for j in 0..<6 * i {
                hexagonBoard[hashPair((i, j))] = ModelPoint(expected: -1, actual: -1)
            }
        }
        self.coordinateConverter = CoordinateConverter(dimension: d)
        super.init()
//        randomStart()
        trueStart(number: 5)
        
    }
    
    func randomStart() {
        for i in 0...self.dimension {
            for j in 0..<6 * i {
                if (random() % 3 == 0) {
                    placeAPiece((i, j), expected: random() % 6)
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
    
    func placeAPiece(cor: (Int, Int), expected e: Int) {
        // if
        if ( (cor.0 <= dimension) && ( (cor.1 == 0) || (cor.1 < 6 * cor.0) ) ) {
            if (hexagonBoard[hashPair(cor)]!.expected == -1) {
                println("Model says at \(cor) is fucking \(hexagonBoard[hashPair(cor)])")
                hexagonBoard[hashPair(cor)] = ModelPoint(expected: e, actual: 0)
                increaseNear(cor)
                reauthCor(cor)
                delegate.placeAPiece(cor, number: hexagonBoard[hashPair(cor)]!)
            } else {
                println("Model says position taken")
            }
        } else {
            println("Place out of range!")
        }
        
        
    }
    
//    func placeAPieceWith(number n: Int, cor: (Int, Int)) {
//        // if
//        if (hexagonBoard[hashPair(cor)] == -1) {
//            hexagonBoard[hashPair(cor)] = n
//            increaseNear(cor)
//            reauthCor(cor)
//            delegate.placeAPiece(cor, number: hexagonBoard[hashPair(cor)]!)
//        } else {
//            println("Model says position taken")
//        }
//        
//    }
    
    func removeAPiece(cor: (Int, Int)) {
        if (hexagonBoard[hashPair(cor)]?.expected != -1) {
            hexagonBoard[hashPair(cor)]?.expected = -1
            decreaseNear(cor)

            delegate.removeAPiece(cor)
        } else {
            println("Model says already empty")
        }
    }
    
    func startMoveAPiece(cor: (Int, Int)) {
        if (hexagonBoard[hashPair(cor)]?.expected != -1) {
            pieceInMoveExpected = hexagonBoard[hashPair(cor)]?.expected
            hexagonBoard[hashPair(cor)]?.expected = -1
            decreaseNear(cor)

            delegate.startMoveAPiece(cor)
            println("Model says _________ moving a piece")
            pieceInMove = cor
        } else {
            println("Model says already empty")
        }
    }
    
    func endMoveAPiece(dest: (Int, Int)) {
        if (hexagonBoard[hashPair(dest)]?.expected != -1) {

            println("Model says target already take")
            hexagonBoard[hashPair(pieceInMove!)] = ModelPoint(expected: pieceInMoveExpected!, actual: 0)
            reauthCor(pieceInMove!)
            increaseNear(pieceInMove!)
            delegate.failMoveAPiece(pieceInMove!)
            
        } else {
            placeAPiece(dest, expected: pieceInMoveExpected!)
            println("Model says succeed in moving a piece. Placing it!")
            delegate.successMoveAPiece(pieceInMove!, dest: dest)
        }
        
    }
    
    // TODO: place a piece only needs the expected. Update only needs the actual? Move a piece needs what? Only needs the expected just as place a piece I think...
    
    
//    func placeAPieceWithTwo(cor: (Int, Int)) {
//        placeAPiece(coordinateConverter.twoToHex(cor))
//    }
    
    // TODO: separate the views into more comprehensible classes...
    
    func reauthCor(cor: (Int, Int)) {

        if (hexagonBoard[hashPair(cor)]) != nil && (hexagonBoard[hashPair(cor)])?.expected != -1 { // If here exists and not empty
            hexagonBoard[hashPair(cor)]?.actual = 0 // reset it
            let nearCors = self.coordinateConverter.neighborIndex(cor) // get neighbors
            for neighbor in nearCors {
                if ((hexagonBoard[hashPair(neighbor)]) != nil) { // if neighbor exists
                    if (hexagonBoard[hashPair(neighbor)]!.expected != -1) { // and is not empty
                        hexagonBoard[hashPair(cor)]!.actual += 1 // increase the count
                    }
                }
                
            }
        }
    }
    
    func increaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil && (hexagonBoard[hashPair(neighbor)])?.expected != -1) { // If neighbor exists and is not empty
                hexagonBoard[hashPair(neighbor)]!.actual += 1
                delegate.updateAPiece(neighbor, number: hexagonBoard[hashPair(neighbor)]!)
            }

        }
        
    }
    // Make it work. Make it right. Make it fast. Make it elegant.
    func decreaseNear(cor: (Int, Int)) {
        let nearCors = self.coordinateConverter.neighborIndex(cor)
        for neighbor in nearCors {
            if ((hexagonBoard[hashPair(neighbor)]) != nil && (hexagonBoard[hashPair(neighbor)])?.expected != -1) { // If neighbor exists and is not empty // TODO: wrap it into a method called isEmpty...
                hexagonBoard[hashPair(neighbor)]!.actual -= 1
                delegate.updateAPiece(neighbor, number: hexagonBoard[hashPair(neighbor)]!) // TODO: should we update this brutally?
            }
        }
    }
    
    func hasWon() -> Bool {
        for (cor, modelPoint) in hexagonBoard {
            if modelPoint.expected != modelPoint.actual {
                return false;
            }
        }
        
        return true;
    }
    
    func trueStart(number n: Int) {
        randomStart()
        rematch()
        randomMove(times: 500)
    }
    
    func rematch() {
        for (cor, modelPoint) in self.hexagonBoard {
//            modelPoint.expected = modelPoint.actual
            if hexagonBoard[cor]?.expected != -1 {
                hexagonBoard[cor]?.expected = modelPoint.actual
                delegate.updateAPiece(revHashPair(cor), number: hexagonBoard[cor]!)
                println("Fucking!")
            }

        }
    }
    // TODO: more parameters. More decoupled...
    func randomMove(times t: Int) {
        var randomTakenCorMap = [Int: Int]()
        var randomAllCorMap = [Int: Int]()
        var i, j: Int
        (i, j) = (0, 0)
        
        for (cor, modelPoint) in self.hexagonBoard {
            randomAllCorMap[i] = cor
            ++i
            if (modelPoint.expected != -1) {
                randomTakenCorMap[j] = cor
                ++j
            }
        }
        var times = t
        let allSize = randomAllCorMap.count
        let takenSize = randomTakenCorMap.count
        
        var a, b: (Int, Int)
        var randomA, randomB: Int
        while (times > 0) {
            randomA = random() % takenSize
            randomB = random() % allSize
            
            a = revHashPair(randomTakenCorMap[randomA]!)
            b = revHashPair(randomAllCorMap[randomB]!)
            if (moveAToB(a, b: b)) {
                randomTakenCorMap[randomA] = hashPair(b)
                --times
            }
        }
        
    } // How to solve the indice dilemma?
    
    func moveAToB(a: (Int, Int), b: (Int, Int)) -> Bool { // Return if successful
        if hexagonBoard[hashPair(b)] == nil {
            return false
        } else {
            if hexagonBoard[hashPair(b)]!.expected == -1 {
                placeAPiece(b, expected: hexagonBoard[hashPair(a)]!.expected)
                removeAPiece(a)
                return true
            } else {
                return false
            }
        }
    }
}
