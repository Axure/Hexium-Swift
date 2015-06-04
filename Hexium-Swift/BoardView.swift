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
    
    init(dimension d: Int, radius r: CGFloat) {
        self.dimension = d
        
        
        
        super.init(frame: CGRectMake(100, 100, 540, 540))
        self.backgroundColor = UIColor.clearColor()
        
        
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
            b = -1
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
                a = j % i
                if (a == 0) {
                    b++
                }
                r = r + 128.0 / CGFloat(6 * i)
                g = g + 128.0 / CGFloat(6 * i)
                bb = bb + 128.0 / CGFloat(6 * i)
                
                x1 = cos(degreeToRadian(CGFloat(60 * b)))
                x1 = x1 * CGFloat(2 * i) * size
                
                x2 = cos(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                x2 = x2 * CGFloat(a) * size * 2
                
                y1 = sin(degreeToRadian(CGFloat(60 * b)))
                y1 = y1 * CGFloat(2 * i) * size
                
                y2 = sin(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                y2 = y2 * CGFloat(a) * size * 2
                
                position = CGPoint(x: x + x1 + x2, y: y + y1 + y2)
                
                color = UIColor( red: r / 256.0, green: g / 256.0, blue: (256.0 - bb) / 256.0, alpha: CGFloat(1.0) )
                
                let offset = CGFloat(30)
                newPiece = PieceView(position: position, width: size + 2, radius: size + 20.0, color: UIColor.blackColor(), offset: offset)
                newPiece.number = b
                addSubview(newPiece)
                
                println("New piece is at \(position) with color \(color)")
                
            }
        }
        
        
        for i in 1...5 {
            b = -1
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
                a = j % i
                if (a == 0) {
                    b++
                }
                r = r + 128.0 / CGFloat(6 * i)
                g = g + 128.0 / CGFloat(6 * i)
                bb = bb + 128.0 / CGFloat(6 * i)
                
                x1 = cos(degreeToRadian(CGFloat(60 * b)))
                x1 = x1 * CGFloat(2 * i) * size
                
                x2 = cos(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                x2 = x2 * CGFloat(a) * size * 2
                
                y1 = sin(degreeToRadian(CGFloat(60 * b)))
                y1 = y1 * CGFloat(2 * i) * size
                
                y2 = sin(degreeToRadian(CGFloat((b + 2) % 6) * 60))
                y2 = y2 * CGFloat(a) * size * 2
                
                position = CGPoint(x: x + x1 + x2, y: y + y1 + y2)
                
                color = UIColor( red: r / 256.0, green: g / 256.0, blue: (256.0 - bb) / 256.0, alpha: CGFloat(1.0) )
                
                let offset = CGFloat(30)
                newPiece = PieceView(position: position, width: size, radius: size, color: color, offset: offset)
                newPiece.number = b
                addSubview(newPiece)
                
                println("New piece is at \(position) with color \(color)")
                
            }
        }
        
        //        var newPiece: PieceView
        //        var r, g, bb: CGFloat
        //        var a, b: Int
        //        var x, y: CGFloat
        //        var x1, x2, y1, y2: CGFloat
        //        var size = CGFloat(20)
        //        x = 200
        //        y = 400
        //        var color: UIColor
        //        var position: CGPoint
        
        let test2Tile = TileView(position: CGPoint(x: 150, y: 150), radius: CGFloat(200))
        addSubview(test2Tile)
    }
    
    func dragAPiece(location: (x: Int, y: Int)) {
        
    }
    
    func placeAPiece(location: (x: Int, y: Int)) {
        
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