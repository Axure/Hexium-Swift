//
//  HexiumGameController.swift
//  Hexium-Swift
//
//  Created by 郑虎 on 15 年 6. 1..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

class HexiumGameController: UIViewController, GameModelProtocol {
    var dimension: Int
    var model: GameModel? // Use optional to resolve the problem that model must be initialized before super.init, but self must be used after super.init...
    var boardView: BoardView
    let singleRadius = CGFloat(15)
    var coordinateTable = [Int: CGPoint]()
    let totalRadius: CGFloat
    var pieceBeingManipulated: PieceView?
    let coordinateConverter: CoordinateConverter
    var panBegin, panEnd: CGPoint?
    var panSrc: (Int, Int)?
    var panNum: Int?
    
    init(dimension d: Int) {
        self.dimension = d
        self.totalRadius = self.singleRadius * CGFloat(2 * 2 * (d + 1))
        self.coordinateConverter = CoordinateConverter(dimension: d)
        boardView = BoardView(dimension: d, singleRadius: singleRadius)
        
        super.init(nibName: nil, bundle: nil)
        
        initTable()
        
        model = GameModel(dimension: d, delegate: self)
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
        
        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapRecognizer:"))
//        tapRecognizer.numberOfTapsRequired = 1
//        view.addGestureRecognizer(tapRecognizer)
        
        var panRecognizer = UIPanGestureRecognizer(target:self, action: Selector("panRecognizer:"))
        view.addGestureRecognizer(panRecognizer)
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        NSLog("Height is %d", vcHeight)
        
        
//        let testTile = PieceView(position: CGPoint(x: 50, y: 50), radius: CGFloat(200), color: UIColor.redColor(), number: 5)
//        view.addSubview(testTile)
        

        initView()
        
    }
    
    func initTable() {
        var x, y, x1, x2, y1, y2: CGFloat
        var position: CGPoint
        
        x = totalRadius / CGFloat(2.0)
        y = totalRadius / CGFloat(2.0)
        let size = singleRadius
        var a, b: Int
        
        // We should rewrite it in the coordinate converter flavor...
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
    }
    
    func initView() {
        view.addSubview(boardView)
        var number: Int
    }
    
    func inefficientSizeToCoordinate(position: CGPoint) -> (Int, Int) { // AKA, my own hit test
        
        var currentPoint: CGPoint
        var closestPoint = CGPoint(x: 0, y: 0)
        var minimalDistance = myDistance(position, b: CGPoint(x: 0, y: 0))
        
        for i in 1...dimension {
            for j in 0...6 * i - 1 {
                currentPoint = coordinateTable[hashPair((i, j))]!
                if (minimalDistance <= myDistance(position, b: currentPoint)) {
                    closestPoint = currentPoint
                    minimalDistance = myDistance(position, b: currentPoint)
                }
            }
        }
        // check if the hit point is inside the closest hexagon
        
        
        return (0, 0)
    }
    
    func cgfloatToInt(cgFloat: CGFloat) -> Int {
        if cgFloat >= 0 {
            return Int(cgFloat)
        } else {
            return Int(cgFloat) - 1
        }
    }
    
    func pointToCoordinate(position: CGPoint) -> (Int, Int) { // AKA, my own hit test
        // Which box?
        // Find row first
        var gridHeight = 2 * singleRadius / sqrt(CGFloat(3)) * 1.5
        var gridWidth = 2 * singleRadius
        var halfWidth = singleRadius
        
        var relativePosition = CGPoint(x: position.x - totalRadius / 2, y: position.y - totalRadius / 2)
        println((relativePosition.y / gridHeight))
        var row = -(cgfloatToInt)(relativePosition.y / gridHeight)
        var column: Int
        
        println((relativePosition.x + halfWidth * CGFloat(row + 1)) / (gridWidth))
        column = cgfloatToInt((relativePosition.x + halfWidth * CGFloat(row + 1)) / (gridWidth))
        var absColumn = cgfloatToInt((relativePosition.x + halfWidth * ((row % 2 == 0) ? 1 : 0)) / (gridWidth))
//        var innerY: CGFloat = CGFloat(relativePosition.y) + CGFloat(gridHeight * row)
        var innerX = relativePosition.x
        var innerY = relativePosition.y
        
        innerY = innerY + (gridHeight * CGFloat(row))
        innerX = innerX - CGFloat(absColumn) * gridWidth - ((row % 2 == 0) ? 0 : 1) * halfWidth

        let k = sqrt(CGFloat(1.0 / 3))
//         On the left corner
        println("The two differences are \(innerY - ((CGFloat(k) * innerX) + 2 * singleRadius / sqrt(CGFloat(3))), innerY - ((CGFloat(-k) * innerX) + 2 * singleRadius / sqrt(CGFloat(3))))")
        if (innerY > (CGFloat(k) * innerX) + 2 * singleRadius / sqrt(CGFloat(3)) && innerX < 0) {
            row--
            column--
        }
        // On the right corner
        if (innerY > (CGFloat(-k) * innerX) + 2 * singleRadius / sqrt(CGFloat(3)) && innerX >= 0) {
            row--
        }
        
        println("Inner coordinates are \(innerX, innerY, absColumn)")
        // TODO: draw animations
        
        return self.coordinateConverter.twoToHex((column - row, -row))
    }
    
    func myDistance(a: CGPoint, b: CGPoint) -> CGFloat {
        let distX = a.x - b.x
        let distY = a.y - b.y
        return sqrt(distX * distX + distY * distY)
    }
    
    func placeAPiece(cor: (Int, Int), number n: ModelPoint) {

        boardView.placeAPiece(cor, number: n)
    }
    
    func startMoveAPiece(cor: (Int, Int)) {
        pieceBeingManipulated = boardView.viewTable[hashPair(cor)]
        if (pieceBeingManipulated !== nil) {
            panBegin = pieceBeingManipulated!.center
            //                panNum = model!.hexagonBoard[hashPair(coordinate)]
        }
    }
    
    func successMoveAPiece(src: (Int, Int), dest: (Int, Int)) {
        pieceBeingManipulated?.removeFromSuperview()
        boardView.viewTable[hashPair(src)] = nil

        pieceBeingManipulated = nil
        // View already placed view place a piece inside the model...
    }
    
    func failMoveAPiece(src: (Int, Int)) {
        pieceBeingManipulated!.center = panBegin!
    }
    
    func removeAPiece(cor: (Int, Int)) {
        boardView.removeAPiece(cor)
    }
    
    func updateAPiece(cor: (Int, Int), number n: ModelPoint) {
        boardView.updateAPiece(cor, number: n)
    }
    
    
    // Drag up, then modify the model.
    // It should be wrapped in the delegate
    // You should call the model to eliminate the hexagon...
    
    // Let the view controller move the view?
    // Judge the type of the action
    // Relative coordinate systems...
    
    @objc(tapRecognizer:)
    func tapCommand(r: UIGestureRecognizer!) {
        let location = r.locationInView(boardView)
        
        println(location.x, location.y)
        println("Up!")
        
        
        
        model?.placeAPiece(pointToCoordinate(location), expected: 4)
        println(pointToCoordinate(location))
//        var selectedView = view.hitTest(location, withEvent: nil)
//        if selectedView != nil {
//            
//            if (selectedView!.isBackground != nil) {
//                println(selectedView!)
//            }
//            
//            
//        }
    }
    
    @objc(panRecognizer:)
    func panCommand(r: UIPanGestureRecognizer!) {
        let location = r.locationInView(boardView)

        println(location.x, location.y)
        switch (r.state) {
        case .Began:
            var coordinate = pointToCoordinate(location)
            panSrc = coordinate
            println(coordinate)
            println("begins!")
            
            model?.startMoveAPiece(coordinate)

            
            
        case .Changed:
            var translation = r.translationInView(boardView)
            if (pieceBeingManipulated != nil) {
                println("hahahaha")
                pieceBeingManipulated!.center = CGPointMake(panBegin!.x + translation.x, panBegin!.y + translation.y)
                // Maybe we should not manipulate the view here directly...
                // We should decouple it and move it to the view...
                // But what is a view controller doing?
            }
//            // move the view
//        case .Cancelled:
            // restore the view
        case .Ended:
            if (pieceBeingManipulated != nil) {
                panEnd = location
                var coordinate = pointToCoordinate(location)
//                model?.removeAPiece(coordinate)
                model?.endMoveAPiece(coordinate)
//                model?.placeAPiece(coordinate)
//                pieceBeingManipulated?.removeFromSuperview()
//                pieceBeingManipulated = nil // Destroy it..
                // place the view
            }
        default:
            println("going!")
        }
    }
}
