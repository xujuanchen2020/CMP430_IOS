import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    var flipCount = 0{
        didSet{
           flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    var emojiChoices = ["👻","🎃","💍","👘"]
    
    var emoji = [Int : String]()
        
    func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }else{
//           return "?"
//        }
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIdenx = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIdenx)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle (emoji(for:card), for:UIControl.State.normal )
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle ("", for:UIControl.State.normal )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }
}

