import Foundation
import Cncurses
import Darwin.ncurses

var done = false

enum Signal:Int32 {
    case INT = 2
    case WINCH = 28
}

typealias SignalHandler = @convention(c)(Int32) -> Void

func trap(_ signum:Signal, action: SignalHandler) {
    signal(signum.rawValue, action)
}


func main() {
    
    // Trap SIGINT
    trap(.INT) { signal in
        done = true
    }
    
    let d = Display()
    
    while(!done) {
        
        if let key = d.getKey(blocking: false) {
            let keyStr = d.keyToString(key)
            
            if keyStr == "q" {
                done = true
                break
            }
            
        }
        
        sleep(1)
        
    }

}

main()
