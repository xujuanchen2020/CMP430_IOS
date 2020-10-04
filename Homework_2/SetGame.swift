import Foundation

struct SetGame{
    
    private(set) var deck = [Card]()
    private(set) var score = 0

    private(set) var cardOnTable = [Card]()
    private var selectedCard = [Card]()

    var hintCard = [Int]()

    var numberOfCard: Int {
        return deck.count
    }

     mutating func chooseCard(at index: Int) {
        if selectedCard.contains(cardOnTable[index]) {
            selectedCard.remove(at: selectedCard.firstIndex(of: cardOnTable[index])!)
            return
        }
        if selectedCard.count == 3 {
            if isSet(on: selectedCard) {
                for cards in selectedCard {
                    cardOnTable.remove(at: cardOnTable.firstIndex(of: cards)!)
                }
                selectedCard.removeAll()
                draw()
                score += 3

            } else {
                score -= 5
                selectedCard.removeAll()

            }
        }
        selectedCard += [cardOnTable[index]]
    }

    mutating func isSet(on selectedCard : [Card]) -> Bool {

        let color = Set(selectedCard.map{ $0.color }).count
        let shape = Set(selectedCard.map{ $0.shape }).count
        let count = Set(selectedCard.map{ $0.count }).count
        let shade = Set(selectedCard.map{ $0.shade }).count

        return color != 2 && shape != 2 && count != 2 && shade != 2
    }

    mutating func hint() {

        hintCard.removeAll()
        for i in 0..<cardOnTable.count {
            for j in (i + 1)..<cardOnTable.count {
                for k in (j + 1)..<cardOnTable.count {
                    let hint = [cardOnTable[i], cardOnTable[j], cardOnTable[k]]
                    if isSet(on: hint) {
                        hintCard += [i, j, k]
                    }
                }
            }
        }
    }

    mutating func draw() {

        if deck.count > 0 {

            for _ in 1...3 {
                cardOnTable += [deck.remove(at: deck.randomIndex)]

            }
        }
    }
    
    
    
    
    
    
    init() {
        for color in Card.Colors.all {
            for count in Card.Numbers.all{
                for shape in Card.Shapes.all {
                    for shade in Card.Shades.all {
                        deck += [Card(color: color, count: count, shape: shape, shade: shade)]
                    }
                }
            }
        }
        
        // initial 4x3 = 12 cards
        for _ in 1...4 {

            draw()

            }
        
        }
    
    }
    
extension Array {
    
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
    
}

