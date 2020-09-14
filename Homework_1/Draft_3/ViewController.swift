import UIKit

class ViewController: UIViewController{
    
    // this is a model, will be used
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var newGameButton: [UIButton]!
    
    @IBOutlet var background: UIView!
    
    var alreadyChoseTheme = false
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if alreadyChoseTheme == false {
            chooseTheme()
            alreadyChoseTheme = true
        }
        
        game.flipCount += 1
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber)
            
            scoreLabel.text = "Score: \(game.score)"
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardBottons")
        }
    }
    
    var colorOfButtons = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var colorOfBackground = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    func updateViewFromModel() {
        
        let gameButton = newGameButton[0]
        
        gameButton.backgroundColor = colorOfButtons
        gameButton.setTitleColor(colorOfBackground, for: UIControl.State.normal)
        flipCountLabel.textColor = colorOfButtons
        scoreLabel.textColor = colorOfButtons
        background.backgroundColor = colorOfBackground

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9818583131, green: 0.9282233715, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : colorOfButtons
            }
        }
    }
    
    var emojiChoices = [String]()
    
    func chooseTheme () {
        let theme = ["faces" :     ["😀","😅","😂","🥰","🤪","😙","😇","😩","😭","😡"],
                     "halloween" : ["👿","👹","🤡","💩","👻","💀","☠️","🎃","🤖","👺"],
                     "gestures" :  ["🤲","👏","🤝","👍","👎","👊","👌","✌️","👉","🙏"],
                     "animals" :   ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐸"],
                     "birds" :     ["🐧","🐦","🐤","🐣","🐥","🦆","🦅","🦉","🦇","🐔"],
                     "clothes" :   ["👠","👗","👘","👟","👑","💍","👜","🧣","👒","🧢"]]
        
        let themeBackgroundColor = ["faces" :     #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                                    "halloween" : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
                                    "gestures" :  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
                                    "animals" :   #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                                    "birds" :     #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                                    "clothes":    #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
        let themeColorOfCard =  ["faces" :     #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
                                 "halloween" : #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),
                                 "gestures" :  #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),
                                 "animals" :   #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
                                 "birds" :     #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
                                 "clothes":    #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)]
        
        let themeKeys = Array(theme.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = Array(theme.values)[themeIndex]
        colorOfBackground = Array(themeBackgroundColor.values)[themeIndex]
        colorOfButtons = Array(themeColorOfCard.values)[themeIndex]
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        game.mismatchedCards = Array(emoji.keys)
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        
        game.flipCount = 0
        flipCountLabel.text = "Flips: 0"
        game.score = 0
        scoreLabel.text = "Score: 0"
        emojiChoices += emoji.values
        emoji = [Int:String]()
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil
        }
        
        chooseTheme()
        updateViewFromModel()
    }
}
