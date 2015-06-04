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