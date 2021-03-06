//
//  TileView.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 1..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import Foundation

import UIKit


class PieceView : UIView {
    
    // How to inherit from two different classes and choose the respective ones to run? In other words, how to merge to classes with an option to switch?
    var color : UIColor
    var offset: CGFloat
    var count: UILabel
    var cor: (Int, Int)
    let isBackground: Bool
    var number: ModelPoint {
        didSet {
            println("The number is \(oldValue)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            self.count.text = "\(number.expected)"
//            switch (number) {
//            case -1:
//                color = UIColor.blackColor()
//            case 1:
//                color = UIColor.greenColor()
//            case 2:
//                color = UIColor.cyanColor()
//            case 3:
//                color = UIColor.yellowColor()
//            case 4:
//                color = UIColor.redColor()
//            case 5:
//                color = UIColor.purpleColor()
//            case 6:
//                color = UIColor.brownColor()
//            default:
//                color = UIColor.whiteColor()
//            }
            if (number.expected > number.actual) {
                color = UIColor.greenColor()
            } else {
                if (number.expected < number.actual) {
                    color = UIColor.redColor()
                } else {
                    color = UIColor.yellowColor()
                }
            }
            self.setNeedsDisplay()
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
    
    func drawCircle(context: CGContextRef, x: CGFloat, y: CGFloat,
        radius: CGFloat, sides: Int, color: UIColor, offset: CGFloat) {
            let context = UIGraphicsGetCurrentContext()
            color.set()
            CGContextAddArc(context, x, y, radius, 0.0, degreeToRadian(CGFloat(360)), 1)
            CGContextStrokePath(context);
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
        if (number.expected >= 0) {
            drawCircle(context, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: CGRectGetWidth(rect)/2, sides: 6, color: color, offset: offset)
        }
        drawPolygon(context, x: CGRectGetMidX(rect), y: CGRectGetMidY(rect), radius: CGRectGetWidth(rect)/2, sides: 6, color: color, offset: offset) // x and y is the top-left corner
        
    }
    
    init (position : CGPoint, radius : CGFloat, color: UIColor, offset: CGFloat = 0, number: ModelPoint, coordinate: (Int, Int), isBackground: Bool) {
        // Radius has nothing to do...
        
//        delegate = d;
//        self.color = d.pieceColor(side)
//        self.color = UIColor.blackColor()
        self.color = color
//        self.side = side
        
        self.offset = offset
        
        let defaultFrame = CGRectMake(position.x - radius, position.y - radius, 2 * radius, 2 * radius)
        let labelFrame = CGRectMake(radius / CGFloat(2), radius / CGFloat(2), radius, radius)
        
        self.cor = coordinate
        self.isBackground = isBackground

        
        
        self.count = UILabel(frame: labelFrame)
        self.count.textAlignment = .Center
        self.number = number
        
        super.init(frame: defaultFrame)
//        super.init(frame: CGRectMake(position.x, position.y, width, width))
        if (number.expected != -1) {
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