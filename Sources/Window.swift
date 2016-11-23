import Foundation


struct Point {
	var x: Int
	var y: Int
}

typealias Size = Point


class Buffer {

	let bufferWidth:  Int
	let bufferHeight: Int

	var scrollOffset: Point

	var buffer: [Tile]

	init(width: Int, height: Int) {
		buffer = [Tile](repeating: Tiles.Wall, count: width * height)
		bufferWidth = width
		bufferHeight = height
		scrollOffset = Point(x: 0, y: 0)
	}

	func bufferForDimensions(_ dimensions: Size) -> [Tile] {
		var output = [Tile]()

		for y in 0 ..< dimensions.y {
			for x in 0 ..< dimensions.x {
				let offsetX = x + scrollOffset.x
				let offsetY = y + scrollOffset.y

				if offsetX >= bufferWidth || offsetY >= bufferHeight || offsetX < 0 || offsetY < 0 {
					output.append(Tiles.OutOfBounds)
				} else {
					let idx = offsetX + (offsetY * bufferWidth)
					output.append(buffer[idx])
				}
			}
		}
        return output
	}


}
