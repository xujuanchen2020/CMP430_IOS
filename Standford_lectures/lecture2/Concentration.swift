import Foundation

class Concentration{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        
        if cards[index].isFaceUp {
            if !cards[index].isMatched {
                if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil  //we have two cards face up, not oneAndOnlyOne card

                }else {
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false  // flip down
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index   // which one face up, this one -- index
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
//            let matchingCard = card
//            cards.append(card)
//            cards.append(matchingCard)
            
            cards += [card,card]
        }
        
        
    }
}
