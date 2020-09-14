import UIKit

class ViewController: UIViewController {
    
    // init game
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
    // init Dictionary
    var emoji = [Int: String]()
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBAction func restartButton(_ sender: UIButton) {
        // to reset game, everything goes back the the original condition
        flipCount = 0
        game.score = 0
        emojiChoices += emoji.values
        emoji = [Int: String]()
        flipCountLabel.text = "Flips: 0"
        scoreCountLabel.text = "score: 0"

        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil

        }
        // choose a theme when restart
        chooseTheme()
        updateViewFromModel()
    }
    
    // make 6 different themes
    var emojiChoices = [String]()
    
    func chooseTheme() {
        // choose a theme for the game
        let theme = ["faces" :     ["😀","😅","😂","🥰","🤪","😙","😇","😩","😭","😡"],
                     "halloween" : ["👿","👹","🤡","💩","👻","💀","☠️","🎃","🤖","👺"],
                     "gestures" :  ["🤲","👏","🤝","👍","👎","👊","👌","✌️","👉","🙏"],
                     "animals" :   ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐸"],
                     "birds" :     ["🐧","🐦","🐤","🐣","🐥","🦆","🦅","🦉","🦇","🐔"],
                     "clothes" :   ["👠","👗","👘","👟","👑","💍","👜","🧣","👒","🧢"],
                     "worms" :     ["🐛","🦋","🐌","🐞","🐝","🦟","🦗","🕷","🕸","🐜"],
                     "organs" :    ["💄","💋","👄","🦷","👅","👁","👀","🧠","👣","👃"]]

        // create an array of themeKeys, choose random one as themeIndex
        let themeKeys = Array(theme.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))

        // choose a random theme
        emojiChoices = Array(theme.values)[themeIndex]

    }
    
    var alreadyChoseTheme = false
    
    @IBAction func touchCard(_ sender: UIButton) {
        // check if chose a theme
        if alreadyChoseTheme == false{
            chooseTheme()
            alreadyChoseTheme = true
        }
        
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            
            // set score label
//            scoreCountLabel.text = "Score: \(game.score)"
            
            updateViewFromModel()

        }
        else{
            print ("chosen card was not in cardNumber!")
        }
    }
    
    func updateViewFromModel(){
        
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                
                if card.isMatched{
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                }
                else{
                   button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                }
                
            }
            
        }
    }
    
    func emoji(for card: Card) -> String{
        
        game.chosenFlipped = Array(emoji.keys)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
           
            let randomIndex = Int (arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
        
    }
}
