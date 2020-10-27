import Foundation

struct Concentration {
    
    //
    var numOfSets = 3 // I have to manually set the value to 2 or 3
    
    private(set) var deck = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0

    private(set) var cardOnTable = [Card]()
    private var selectedCard = [Card]()

    var numberOfCard: Int {
        return deck.count
    }

    mutating func chooseCard(at index: Int) {
        
        flipCount += 1
        
        if numberOfCard >= numOfSets {

            if selectedCard.contains(cardOnTable[index]) {
                selectedCard.remove(at: selectedCard.firstIndex(of: cardOnTable[index])!)
                return

            }
            if selectedCard.count == numOfSets {
                if isSet(on: selectedCard) {
                    for cards in selectedCard {
                        cardOnTable.remove(at: cardOnTable.firstIndex(of: cards)!)
                    }
                    // if correct, draw 3 cards, and increment scores
                    selectedCard.removeAll()
                    draw()
                    score += 3

                } else {
                    // otherwise decrement scores
                    score -= 5
                    selectedCard.removeAll()
                }
            }
            selectedCard += [cardOnTable[index]]
        }
        else{
            if cardOnTable.count > 0{
                
                if selectedCard.count == numOfSets {
                    if isSet(on: selectedCard){
                        for cards in selectedCard {
//                            selectedCard[cards].isMatched = true
                            cardOnTable[cardOnTable.firstIndex(of: cards)!].isMatched = true
//                            cardOnTable.remove(at: cardOnTable.firstIndex(of: cards)!)
                        }
                        selectedCard.removeAll()
                        score += 3
                    }
                    else{
                        score -= 5
                        selectedCard.removeAll()
                    }
                }
                selectedCard += [cardOnTable[index]]
            }
        }
    }
    
    mutating func isSet(on selectedCard : [Card]) -> Bool {

        let shape = Set(selectedCard.map{ $0.shape }).count
        return shape == 1

    }

    mutating func draw() {

        if deck.count > 0 {

            for _ in 1...numOfSets {
                cardOnTable += [deck.remove(at: deck.randomIndex)]
            }
        }
    }
    
    init(numberOfCardToMatch: Int) {
        
        assert(numberOfCardToMatch > 0,
               "Concentration.init(\(numberOfCardToMatch)) : You must have at least one pair of cards")

        for count in 1...numberOfCardToMatch {
            for shape in Card.Shapes.all {
                deck += [Card(shape: shape, count: count)]
            }
        }
       
        // initial how many cards to start the game
        for _ in 1...20 {
            cardOnTable += [deck.remove(at: deck.randomIndex)]
        }
    }
}
    
extension Array {

    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))

    }

}

