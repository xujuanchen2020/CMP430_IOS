import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    // init score
    var score = 0
    
    // create an array to record cards have been flipped before
    var chosenFlipped = [Int]()
    
    func chooseCard(at index: Int){
        
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    //score the game by giving 2 points for every match
                    score += 2
                    
                }
                    
                else{
                    // penalizing 1 point for every previous;y seen card
                    // that is involved in a mismatch
                    for chosenIdentifier in chosenFlipped.indices{
                        if cards[index].identifier == chosenFlipped[chosenIdentifier] || cards[matchIndex].identifier == chosenFlipped[chosenIdentifier]{
                            score -= 1
                        }
                    }
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil

            }
            else{
                // 0 or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            
            }
        }
    }
    
    init (numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // shuffle the cards
        cards.shuffle()

    }
}
