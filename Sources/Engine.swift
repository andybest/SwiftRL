//
//  Engine.swift
//  SwiftRL
//
//  Created by Andy Best on 22/11/2016.
//
//

import Foundation


enum EngineStatus {
    case None
    case Quit
}

class Engine {

    func handleKey(key: String) -> EngineStatus {
        if key == "q" { return EngineStatus.Quit }
        
        return EngineStatus.None
    }
    
}
