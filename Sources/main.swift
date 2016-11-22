import Foundation
import Cncurses
import Darwin.ncurses


enum Signal:Int32 {
    case INT = 2
    case WINCH = 28
}

typealias SignalHandler = @convention(c)(Int32) -> Void

func trap(_ signum:Signal, action:SignalHandler) {
    signal(signum.rawValue, action)
}

trap(.INT) { signal in
    endwin()
    exit(0)
}

func main() {
    
    initscr()
    noecho()
    curs_set(0)
    
    move(0, 0)
    addstr("UL")
    
    move(23, 78)
    addstr("LR")
    
    refresh()
    
    select(0, nil, nil, nil, nil)

}

main()
