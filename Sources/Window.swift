
import Foundation


struct Point {
    var x: Int
    var y: Int
}

typealias Size = Point


class Window {
    
    let bufferWidth: UInt
    let bufferHeight: UInt
    
    let windowWidth: UInt
    let windowHeight: UInt
    
    let scrollOffset: Point
    
    var buffer: [String]
    
    func bufferForDimensions(_ dimensions: Size) {
        
    }
    
}
