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
    
    
    init(dimension d: Int) {
        dimension = d
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        setupGame()
        
        super.viewDidLoad()
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        NSLog("Height is %d", vcHeight)
        
        let testTile = PieceView(position: CGPoint(x: 50, y: 50), width: CGFloat(200), radius: CGFloat(20))
        view.addSubview(testTile)
        
        let test2Tile = TileView(position: CGPoint(x: 150, y: 150), radius: CGFloat(200))
        view.addSubview(test2Tile)
        
        
    }
}
