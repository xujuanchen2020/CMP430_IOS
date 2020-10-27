import Foundation

struct CardDeck {
    
    var deck = [Card]()

    func count() -> Int {
        return deck.count
    }

    func isEmpty() -> Bool {
        return deck.count == 0 ? true : false
    }

    mutating func dealCard() -> Card? {
        
        return self.isEmpty() ? nil : deck.remove(at: 0)
    }

    init(numberOfCardsToMatch: Int) {
        
        for shape in Card.Shapes.all{
            deck += [Card(shape: shape, count: count())]
        }

    }
    
}
