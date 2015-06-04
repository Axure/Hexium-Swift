//
//  HexiumGameController.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 1..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

class HexiumGameController: UIViewController {
    var dimension: Int
    var model: GameModel
    
    
    init(dimension d: Int) {
        dimension = d
        model = GameModel(dimension: d)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.whiteColor()
        setupTapControls()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        setupGame()
        
        super.viewDidLoad()
    }
    
    func setupTapControls() {
        
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        NSLog("Height is %d", vcHeight)
        
        
        let testTile = PieceView(position: CGPoint(x: 50, y: 50), width: CGFloat(200), radius: CGFloat(20), color: UIColor.redColor())
        view.addSubview(testTile)
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
                newPiece = PieceView(position: position, width: size, radius: size, color: color, offset: offset)
                newPiece.number = b
                view.addSubview(newPiece)
                
                println("New piece is at \(position) with color \(color)")
                
            }
        }
        
        let test2Tile = TileView(position: CGPoint(x: 150, y: 150), radius: CGFloat(200))
        view.addSubview(test2Tile)
        
        
    }
    
    func initView() {
        
    }
    
    func sizeToCoordinate(radius: CGFloat, padding: CGFloat) -> (Int, Int) {
        
        return (0, 0)
    }
    
    // Drag up, then modify the model.
    // It should be wrapped in the delegate
    // You should call the model to eliminate the hexagon...
    
    // Let the view controller move the view?
    // Judge the type of the action
    // Relative coordinate systems...
    
    @objc(tap:)
    func tapCommand(r: UIGestureRecognizer!) {
        let location = r.locationInView(view)
        
        println(location.x, location.y)
        println("Up!")
    }
}
