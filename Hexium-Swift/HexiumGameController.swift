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
    var boardView: BoardView
    
    
    init(dimension d: Int) {
        dimension = d
        model = GameModel(dimension: d)
        boardView = BoardView(dimension: d, radius: 500)
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
        

        initView()
        
    }
    
    func initView() {
        view.addSubview(boardView)
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
