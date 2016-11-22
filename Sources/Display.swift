import Foundation
import Darwin.ncurses


class Display {
    
    init() {
        // Init window
        initscr()
        
        // Disable key echo
        noecho()
        
        // Disable cursor display
        curs_set(0)
    }
    
    deinit {
        // Restore terminal
        endwin()
    }
    
    func getKey(blocking: Bool) -> Int32? {
        if(!blocking) {
            nodelay(stdscr, true)
            defer { nodelay(stdscr, false) }
        }
        
        let c = getch()
        return c == ERR ? nil : c
    }
    
    func keyToString(_ keyCode: Int32) -> String {
        return "\(UnicodeScalar(Int(keyCode))!)"
    }
    
    func refresh() {
        refresh()
    }
    
    
}
