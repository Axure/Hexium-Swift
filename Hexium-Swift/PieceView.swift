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


    
    
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        
//        switch(side) {
//        case Side.Black:
            //            let lineWidth : CGFloat = 5.0
            //            var context = UIGraphicsGetCurrentContext()
            //            CGContextSetLineWidth(context, lineWidth);
            //            color.set()
            //
            //            var startPoint, endPoint : CGPoint
            //            startPoint = CGPointMake(0.0 + lineWidth, 0.0 + lineWidth)
            //            endPoint = CGPointMake(frame.size.width - lineWidth, frame.size.height - lineWidth)
            //            CGContextAddLines(context, [startPoint, endPoint], 2)
            //
            //            startPoint = CGPointMake(0.0 + lineWidth, frame.size.height - lineWidth)
            //            endPoint = CGPointMake(frame.size.width - lineWidth, 0 + lineWidth)
            //            CGContextAddLines(context, [startPoint, endPoint], 2)
            //
            //            // Dig deeper into the layout design!
            //            CGContextStrokePath(context)
            //            CGContextFillPath(context)
            
//            let xOffSet = CGFloat(0.0)
//            //            let xOffSet = frame.size.width/4.0
//            //            let yOffSet = CGFloat(0.0)
//            let yOffSet = frame.size.width/4.0
//            
//            let myLine = lineView(position: CGPointMake(0.0 + xOffSet, 0.0 + yOffSet), width: frame.size.width
//                , length: 5.0, color: color, cornerRadius: 2.0)
//            println(myLine.layer.cornerRadius)
//            
//            myLine.transform = CGAffineTransformMakeRotation(+CGFloat(M_PI)/4.0)
//            addSubview(myLine)
//            
//            
//            // We need more accurate manipulations of the graphical coordinates...
//            
//            // Write an array to debug or to discover the effects of the parameters and functions
//            
//            let myLine3 = lineView(position: CGPointMake(0.0 + xOffSet, 0.0 + yOffSet), width: frame.size.width
//                , length: 5.0, color: color, cornerRadius: 2.0)
//            println(myLine3.layer.cornerRadius)
//            myLine3.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI)/2.0)
//            
//            // Maybe we should write yet one more graphical interface to debug
//            // Graphic generator and graphical interface generator and parameter setter debugger adjuster interactor
//            
//            
//            addSubview(myLine3)
//            
//            let myLine_2 = lineView(position: CGPointMake(0.0 + xOffSet, 0.0 + yOffSet), width: frame.size.width
//                , length: 5.0, color: color, cornerRadius: 2.0)
//            println(myLine_2.layer.cornerRadius)
//            
//            myLine_2.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI)/4.0)
//            addSubview(myLine_2)
//            
//            
//            let myLine_4 = lineView(position: CGPointMake(0.0 + xOffSet, 0.0 + yOffSet), width: frame.size.width
//                , length: 5.0, color: color, cornerRadius: 2.0)
//            println(myLine_4.layer.cornerRadius)
//            
//            
//            addSubview(myLine_4)
//            
//        case Side.White:
            let lineWidth : CGFloat = 5.0
            var context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, lineWidth);
            color.set()
            CGContextAddArc(context, (frame.size.width)/2 - lineWidth/2, frame.size.height/2 - lineWidth/2, (frame.size.width - 10)/2 - lineWidth, 0.0, CGFloat(M_PI * 2.0), 1)
            // Dig deeper into the layout design!
            CGContextStrokePath(context)
            
            
//        }
        
        
    }
    
    init (position : CGPoint, width : CGFloat, radius : CGFloat) {
        
        
//        delegate = d;
//        self.color = d.pieceColor(side)
        self.color = UIColor.blackColor()
//        self.side = side
        
        
        super.init(frame: CGRectMake(position.x, position.y, width, width))
        
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