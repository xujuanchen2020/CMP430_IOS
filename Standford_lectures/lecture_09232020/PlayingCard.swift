import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var description: String {
        return "\(rank) \(suit)"
    }
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        case clubs    = "♣️"
        case diamonds = "♦️"
        case hearts   = "❤️"
        case spades   = "♠️"
        
        static var all = [Suit.clubs, .diamonds, .hearts, .spades]
        
        var description: String {
            return self.rawValue
        }
    }
    
    enum Rank: CustomStringConvertible {
        case ace
        case face (String)
        case numeric (Int)
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let value): return value
//                case .face(let faceKind):
//                    if faceKind == "J" {
//                        return 11
//                    }else if faceKind == "Q"{
//                        return 12
//                    }else{
//                        return 13
//                }
                
                case .face(let faceKind) where faceKind == "J": return 11
                case .face(let faceKind) where faceKind == "Q": return 12
                case .face(let faceKind) where faceKind == "K": return 13
                
                default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for value in 2...10{
                allRanks.append(.numeric(value))
            }
            allRanks += [.face("J"),.face("Q"),.face("K")]
            
            return allRanks
        }
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric (let value): return String(value)
            case .face (let faceKind): return faceKind
            
            }
        }
    }  
    
}
