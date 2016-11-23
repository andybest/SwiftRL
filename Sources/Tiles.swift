//
// Created by Andy Best on 23/11/2016.
//

import Foundation

struct Tile {
    let walkable: Bool
    let character: UnicodeScalar
}

struct Tiles {
    // Scenery
    static let OutOfBounds = Tile(walkable: false, character: "░")
    static let Floor = Tile(walkable: true, character: " ")
    static let Wall = Tile(walkable: false, character: "▒")

    // Entities
    static let Player = Tile(walkable: false, character: "@")
}
