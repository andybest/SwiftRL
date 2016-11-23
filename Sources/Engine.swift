//
//  Engine.swift
//  SwiftRL
//
//  Created by Andy Best on 22/11/2016.
//
//

import Foundation
import CTermbox


enum EngineStatus {
    case None
    case Quit
}

struct Event {

    enum EventType {
        case Unknown
        case Key
        case Resize
        case Mouse
    }

    let type: EventType
    let mod: UInt8
    let key: UInt16
    let char: UInt32
    let w: Int32
    let h: Int32
    let x: Int32
    let y: Int32
}

class Engine {
    var done = false
    var buf: Buffer

    var screenNeedsUpdate = false

    var screenWidth: Int = 10
    var screenHeight: Int = 10

    init() {
        buf = Buffer(width: 40, height: 40)
        initScreen()
        recalculateScreenBounds()
        screenNeedsUpdate = true
    }

    deinit {
        // Restore terminal
        tb_shutdown()
    }

    // MARK - Screen handling

    func initScreen() {
        tb_init()
    }

    func recalculateScreenBounds() {
        screenWidth = Int(tb_width())
        screenHeight = Int(tb_height())
    }

    func refresh() {
        refresh()
    }

    // MARK - Input

    func getEvent(blocking: Bool) -> Event? {
        let cEvent = UnsafeMutablePointer<tb_event>.allocate(capacity: 1)
        defer {
            cEvent.deallocate(capacity: 1)
        }

        if blocking {
            tb_poll_event(cEvent)
        } else {
            tb_peek_event(cEvent, 10)
        }

        if cEvent.pointee.type < 0 {
            return nil
        }

        let type: Event.EventType = cEvent.pointee.type == 1 ? .Key :
                cEvent.pointee.type == 2 ? .Resize :
                        cEvent.pointee.type == 3 ? .Mouse :
                                .Unknown

        return Event(type: type, mod: cEvent.pointee.mod, key: cEvent.pointee.key,
                char: cEvent.pointee.ch, w: cEvent.pointee.w, h: cEvent.pointee.h,
                x: cEvent.pointee.x, y: cEvent.pointee.y)
    }

    func keyToString(_ keyCode: UInt32) -> String {
        return "\(UnicodeScalar(Int(keyCode))!)"
    }

    func handleKey(key: String) -> EngineStatus {
        if key == "q" {
            return EngineStatus.Quit
        } else if key == "h" {
            self.buf.scrollOffset.x += 1
            screenNeedsUpdate = true
        } else if key == "l" {
            self.buf.scrollOffset.x -= 1
            screenNeedsUpdate = true
        } else if key == "k" {
            self.buf.scrollOffset.y += 1
            screenNeedsUpdate = true
        } else if key == "j" {
            self.buf.scrollOffset.y -= 1
            screenNeedsUpdate = true
        }

        return EngineStatus.None
    }

    // MARK - Engine Events

    func quit() {
        done = true
    }

    // MARK - Rendering

    func renderBuf() {
        let renderBuf = buf.bufferForDimensions(Size(x: screenWidth, y: screenHeight))

        for y in 0 ..< screenHeight {
            for x in 0 ..< screenWidth {
                let idx = x + (screenWidth * y)
                let t: Tile = renderBuf[idx]

                tb_change_cell(Int32(x), Int32(y), UInt32(t.character), 0x08, 0x00)
            }
        }

        tb_present()
    }

    // MARK - Main Loop

    func mainLoop() {
        while (!done) {
            if screenNeedsUpdate {
                renderBuf()
            }

            if let event = getEvent(blocking: true) {
                switch event.type {
                case .Key:
                    let keyStr = keyToString(event.char)
                    let status = handleKey(key: keyStr)

                    if(status == .Quit) {
                        done = true
                    }
                    break

                case .Resize:
                    recalculateScreenBounds()
                    break

                default:
                    break
                }
            }

            usleep(1000)
        }
    }

}
