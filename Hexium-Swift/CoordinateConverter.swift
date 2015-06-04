import Foundation

let ubound = 100

func hashPair(pair: (Int, Int)) -> Int {
    return ubound * (pair.0 + ubound + 1) + (pair.1 + ubound + 1)
}


class CoordinateConverter: NSObject {
    
    let dimension: Int
    
    //    var reverseIndex: [[(Int, Int)]]  // Decoupling?
    var reverseIndex = [Int: (Int, Int)]()
    
    init (dimension d: Int) {
        dimension = d
        //        reverseIndex = [[(Int, Int)]](count: dimension, repeatedValue:[(Int, Int)] (count: dimension, repeatedValue:(0, 0)))
        
        for i in (0 - d)...(d) {
            for j in (0 - d)...(d) {
                println("\(i) and \(j)")
                //                reverseIndex[hashPair((i, j))] = _twoToHex((i, j))
                reverseIndex[hashPair(_twoToHex((i, j)))] = (i, j)
                println("Hex cor is \(_twoToHex((i, j))), Two dim cartesian is \(((i, j)))")
            }
        }
        
        
    }
    
    func twoToHex(cor: (x: Int, y: Int)) -> (Int, Int) {
        return _twoToHex((cor.x, cor.y))
    }
    
    func neighborIndex (cor: (x: Int, y: Int)) -> [(Int, Int)] {
        let (tx, ty) = (hexToTwo(cor))
        let twoNeighbors = [(tx + 1, ty), (tx - 1, ty), (tx + 1, ty + 1), (tx, ty + 1), (tx, ty - 1), (tx - 1, ty - 1)]
        return twoNeighbors.map{(var cor) -> (Int, Int) in
            return self.twoToHex(cor)
        }
    }
    
    
    
    func hexToTwo(cor: (x: Int, y: Int)) -> (Int, Int) {
        
        return reverseIndex[hashPair(cor)]!
        
    }
    
    
    
}

func _twoToHex(cor: (x: Int, y: Int)) -> (Int, Int) {
    var (cX, cY): (Int, Int)
    let (x, y) = cor
    switch x {
    case let tx where tx > 0:
        cX = x
        switch y {
        case let ty where ty < 0:
            cX = x - y
            cY = (6 * cX) - (0 - y)
        case let ty where ty > x:
            //                cX = x + (y - x)
            cX = y
            cY = 2 * y - x
        default:
            cY = y
        }
    case let tx where tx < 0:
        cX = 0 - x
        switch y {
        case let ty where ty > 0:
            cX = 0 - x + y
            cY = (2 * cX) + y
        case let ty where ty < x:
            //                cX = (- x) + (x - y)
            cX = 0 - y
            cY = 5 * cX + x
        default:
            cY = (3 * (0 - x)) + (0 - y)
        }
    case let tx where tx == 0:
        switch y {
        case let ty where ty == 0:
            cX = 0
            cY = 0
        case let ty where ty > 0:
            cX = y
            cY = 2 * y
        case let ty where ty < 0:
            cX = -y
            cY = 5 * cX
        default: // nonsense
            cX = 0
            cY = 0
        }
    default:
        cX = 0
        cY = 0
    }
    return (cX, cY)
}