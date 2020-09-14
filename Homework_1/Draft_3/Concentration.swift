
class Concentration{
    
    // init cards, flipCount, score, and card index
    var cards =  [Card]()
    var score = 0
    var flipCount = 0
    var indexOfOneAndOnlyFaceUpCard: Int?

    // create an array to record cards have been flipped before
    var mismatchedCards = [Int]()
    
    // create a method chooseCard
    func chooseCard(at index: Int) {
        
        // ignore card that is already been matched
        // if not match
        if !cards[index].isMatched {
            
            // if there is one card face up, and now need to match
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // increase score by 2 points
                    score += 2
                    
                }
                else {
                    // if the card has been chosen before
                    for chosenIdentifier in mismatchedCards.indices {
                        
                        // decrease score if cards not match
                        if cards[index].identifier == mismatchedCards[chosenIdentifier] {
                            score -= 1
                        }
                        // decrease scores if cards had already been seen before
                        if cards[matchIndex].identifier == mismatchedCards[chosenIdentifier] {
                            score -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
   
                // for 0 or 2 cards not match are face up, flip them face down
                for flipDownIndex in cards.indices {
                    
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        
        for _ in 1...numberOfPairsOfCards {
            
            let card = Card()
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
            
// the other way to copy the pairs into cards[]
//            let card = Card()
//            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        cards.shuffle()
        
    }
}
