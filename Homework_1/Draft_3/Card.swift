import Foundation
/**
 struct has no inheritance
 struct is a value type, not a reference type
 copy the value when modified inside a method
 nothing happened if only called without changing anything
*/
struct Card {

    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
