//
//  TileView.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 1..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import Foundation

import UIKit


//class PieceView : UIView {
//
//
//
//    var delegate : AppearanceProviderProtocol
//    var side: Side = Side.Black {
//        didSet {
//            backgroundColor = delegate.pieceColor(side)
//        }
//        // Understanding and applying such kind of codes
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("NSCoding not supported")
//    }
//
//    init (position : CGPoint, width : CGFloat, side : Side, radius : CGFloat, delegate d : AppearanceProviderProtocol) {
//
//        delegate = d;
//
//        switch(side) {
//        case Side.Black:
//            super.init(frame: CGRectMake(position.x, position.y, width, width));
//
//        case Side.White:
////            super.init(frame: CGRectMake(position.x + width/4, position.y + width/4, width/2, width/2));
//            super.init(frame: CircleView(CGRectMake(position.x + width/4, position.y + width/4, width/2, width/2), color: UIColor.clearColor()))
//
//        }
//
//        // Maybe we need to write a class for the circle inherited from a rectangle and override the CGRectMake method?
//
//
//        self.side = side
//        backgroundColor = delegate.pieceColor(side)
//        println(backgroundColor)
//
//    }
//
//}

class PieceView : UIView {
    
    // How to inherit from two different classes and choose the respective ones to run? In other words, how to merge to classes with an option to switch?
    var color : UIColor
    var offset: CGFloat
    var count: UILabel
    var number: Int {
        didSet {
            println("The number is \(oldValue)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            self.count.text = "\(number)"
            if number > 3 {
                color = UIColor.redColor()
            } else {
                if (number == -1) {
                    println("-1!!!!!!!!!!!!!!!!!")
                    color = UIColor.blackColor()
                } else {
                    color = UIColor.greenColor()
                }

            }
        }
    }

    // TODO: it is the circle that is not just in its context, not the hexagon... We need to find the principle behind it.
    
    
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    
    func polygonVertices(number: Int, point: CGPoint, radius: CGFloat, angleOffSet: CGFloat = 0) -> [CGPoint] {
        let angleShare = CGFloat(360 / number)
        var angle = angleOffSet
        var points = [CGPoint]()
        println("Radius is \(radius)")
        println("Angle share is \(angleShare)")
        for i in 0..<number {
            println("The \(i)th angle is \(angle)")
            println("The cos is \(cos(degreeToRadian(angle)))")
            points.append(CGPoint(x: point.x + radius * cos(degreeToRadian(angle)), y: point.y + radius * sin(degreeToRadian(angle))))
            angle = angle + angleShare
        }
        println(points)
        return points
    }
    
    func drawPolygon(context: CGContextRef, x: CGFloat, y: CGFloat,
        radius: CGFloat, sides: Int, color: UIColor, offset: CGFloat) {
            
            let points = polygonVertices(sides, point: CGPoint(x: x, y: y), radius: radius, angleOffSet: offset)
            
            CGContextAddLines(context, points, Int(points.count))
            
            let cgcolor = color.CGColor
            CGContextSetFillColorWithColor(context, cgcolor)
            CGContextFillPath(context)
            println("Polygon color is \(color)")
            println("Context for the polygon is \(context)")
    }
    
    override func drawRect(rect: CGRect) {

        let angleOff = 0
        let xOffSet = CGFloat(300)
        var context = UIGraphicsGetCurrentContext()
        drawPolygon(context, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: CGRectGetWidth(rect)/2, sides: 6, color: color, offset: offset) // x and y is the top-left corner
    }
    
    init (position : CGPoint, width : CGFloat, radius : CGFloat, color: UIColor, offset: CGFloat = 0, number: Int) {
        
        
//        delegate = d;
//        self.color = d.pieceColor(side)
//        self.color = UIColor.blackColor()
        self.color = color
//        self.side = side
        
        self.offset = offset
        
        let defaultFrame = CGRectMake(position.x - width, position.y - width, 2 * width, 2 * width)
        let labelFrame = CGRectMake(width / CGFloat(2), width / CGFloat(2), width, width)
        

        
        
        self.count = UILabel(frame: labelFrame)
        self.number = number
        println("The initialized number is \(self.number)^^^^^^^^^^^^^^^^^^^")
        
        super.init(frame: defaultFrame)
//        super.init(frame: CGRectMake(position.x, position.y, width, width))
        if (number != -1) {
            self.addSubview(self.count)
        }
        // Maybe we need to write a class for the circle inherited from a rectangle and override the CGRectMake method?
        self.backgroundColor = UIColor.clearColor()

        //        backgroundColor = delegate.pieceColor(side)
        println(backgroundColor)
        
    }
    
}


class lineView : UIView {
    override func drawRect(rect: CGRect) {
        
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init (position : CGPoint, width : CGFloat, length : CGFloat, color : UIColor, cornerRadius : CGFloat) {
        
        super.init(frame: CGRectMake(position.x, position.y, width, length))
        
        
        self.backgroundColor = color
        
        self.layer.masksToBounds = true // But here why?
        self.layer.cornerRadius = cornerRadius
    }
}