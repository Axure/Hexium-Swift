//
//  BoardView.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 1..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol BoardViewProtocol {

}

class BoardView: UIView, BoardViewProtocol { // The board view should wrap the piece view
    let dimension: Int
    var coordinateTable = [Int: CGPoint]()
    var viewTable = [Int: PieceView]()
    let totalRadius: CGFloat
    let singleRadius: CGFloat
    
    init(dimension d: Int, singleRadius r: CGFloat) {
        self.dimension = d
        self.singleRadius = r
        self.totalRadius = r * CGFloat(2 * 2 * (d + 1))
        
        
        super.init(frame: CGRectMake(0, 0, totalRadius, totalRadius))
        self.backgroundColor = UIColor.clearColor()
        
        
        var newPiece: PieceView
        var r, g, bb: CGFloat
        var a, b: Int
        var x, y: CGFloat
        var x1, x2, y1, y2: CGFloat
        let backPiecePadding = CGFloat(1.5 / 15)
        
        var size = self.singleRadius
        x = totalRadius / 2
        y = totalRadius / 2
        var color: UIColor
        var position: CGPoint
        
        coordinateTable[hashPair((0, 0))] = CGPoint(x: x, y: y)
        for i in 1...dimension {
            b = -1
            for j in 0...6 * i - 1 {
                a = j % i
                if (a == 0) {
                    b++
                }
                x1 = cos(degreeToRadian(CGFloat(60 * b)))
                x1 = x1 * CGFloat(2 * i) * size
                
                x2 = cos(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                x2 = x2 * CGFloat(a) * size * 2
                
                y1 = sin(degreeToRadian(CGFloat(60 * b)))
                y1 = y1 * CGFloat(2 * i) * size
                
                y2 = sin(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                y2 = y2 * CGFloat(a) * size * 2
                
                position = CGPoint(x: x + x1 + x2, y: y + y1 + y2)
                coordinateTable[hashPair((i, j))] = position
            }
        }

        // Load the background
        let offset = CGFloat(30)
        // Add the piece in center
        newPiece = PieceView(position: CGPoint(x: x, y: y), radius: size * (1 + backPiecePadding), color: UIColor.blackColor(), offset: offset, number: -1, coordinate: (0, 0), isBackground: true)
        addSubview(newPiece)
        // Add the pieces around it
        for i in 1...dimension {
            
            for j in 0...6 * i - 1 {
                

                newPiece = PieceView(position: coordinateTable[hashPair(i, j)]!, radius: size * (1 + backPiecePadding), color: UIColor.blackColor(), offset: offset, number: -1, coordinate: (i, j), isBackground: true)
//                newPiece.number = 2
                addSubview(newPiece)
                
                
            }
        }
        
//        let test2Tile = TileView(position: CGPoint(x: 150, y: 150), radius: CGFloat(200))
//        addSubview(test2Tile)
        
//        loadDemoView()
    }
    
    func loadDemoView() {
        var newPiece: PieceView
        var r, g, bb: CGFloat
        var a, b: Int
        var x, y: CGFloat
        var x1, x2, y1, y2: CGFloat
        var size = CGFloat(20)
        x = 200
        y = 400
        var color: UIColor
        var position: CGPoint
        for i in 1...5 {
            if (i % 2 == 0) {
                r = 0
                g = 128
                bb = 0
            } else {
                r = 128
                bb = 128
                g = 0
            }
            
            for j in 0...6 * i - 1 {
                r = r + 128.0 / CGFloat(6 * i)
                g = g + 128.0 / CGFloat(6 * i)
                bb = bb + 128.0 / CGFloat(6 * i)
                
                println("Coordinate is \(i), \(j)")
                position = coordinateTable[hashPair(i, j)]!
                
                color = UIColor( red: r / 256.0, green: g / 256.0, blue: (256.0 - bb) / 256.0, alpha: CGFloat(1.0) )
                
                let offset = CGFloat(30)
                newPiece = PieceView(position: position, radius: size, color: color, offset: offset, number: j, coordinate: (i, j), isBackground: false)
                newPiece.number = 5
                addSubview(newPiece)
                
                println("New piece is at \(position) with color \(color)")
                
            }
        }
    }
    
    func dragAPiece(location: (x: Int, y: Int)) {
        
    }

    
    func placeAPiece(location: (x: Int, y: Int), number n: Int) {
        var newPiece: PieceView
        var size = self.singleRadius
        var color: UIColor
        color = UIColor.greenColor()
        let position = coordinateTable[hashPair(location)]
        let offset = CGFloat(30)
        newPiece = PieceView(position: position!, radius: size, color: color, offset: offset, number: n, coordinate: location, isBackground: false)
        newPiece.number = n
        addSubview(newPiece)
        viewTable[hashPair(location)] = newPiece
        
        UIView.animateWithDuration(5, animations: { () -> Void in
            // Make the tile 'pop'
            newPiece.layer.setAffineTransform(CGAffineTransformMakeScale(2, 2))
            })
    }
    
    func updateAPiece(location: (x: Int, y: Int), number n: Int) {
//        var piece: PieceView
        if viewTable[hashPair(location)] != nil {
            viewTable[hashPair(location)]!.number = n
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TileView: UIView {
    var color: UIColor
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init (position: CGPoint, radius: CGFloat) {
        
        color = UIColor.blackColor()
        
        
        super.init(frame: CGRectMake(position.x, position.y, radius, radius))
        
        // Maybe we need to write a class for the circle inherited from a rectangle and override the CGRectMake method?
        self.backgroundColor = UIColor.clearColor()
        
        //        backgroundColor = delegate.pieceColor(side)
        println("Background color is \(backgroundColor)")
        
    }
    
    override func drawRect(rect: CGRect) {
        let lineWidth : CGFloat = 5.0
        var context = UIGraphicsGetCurrentContext()
        println("Current context is \(context)")
        CGContextSetLineWidth(context, lineWidth)
        color.set()
        println(color)
        CGContextAddArc(context, (frame.size.width)/2 - lineWidth/2, frame.size.height/2 - lineWidth/2, (frame.size.width - 10)/2 - lineWidth, 0.0, CGFloat(M_PI * 2.0), 1)
        // Dig deeper into the layout design!
        CGContextStrokePath(context)
        println(frame.size)
        println(color)
    }
}