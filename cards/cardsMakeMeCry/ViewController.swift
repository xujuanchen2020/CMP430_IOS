import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        chooseTheme()
    }
    
    private lazy var game = Concentration(numberOfCardToMatch: numberOfTwoOrThreeSets)
    
    // I have to manually set the value to 2 or 3
    var numberOfTwoOrThreeSets: Int = 3 {
        didSet {
            numberOfTwoOrThreeSets = game.numOfSets
        }

    }
    
    var alreadyChoseTheme = false
    
    private var selectedButton = [UIButton]()
    private var hintedButton = [UIButton]()
    
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet var cardButtonCollection: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var newGameThreeSets: UIButton!
    
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if alreadyChoseTheme == false {
            chooseTheme()
            alreadyChoseTheme = true
        }
        if let cardIndex = cardButtonCollection.firstIndex(of: sender) {
            
            if cardIndex < game.cardOnTable.count {
                game.chooseCard(at: cardIndex)
                chooseButton(at: sender)
                updateViewFromModel()
            }
            
        } else {
            
            print("chosen card was not in cardButtons")
        }
        
    }
    
    private func chooseButton(at button: UIButton){
        if selectedButton.contains(button) {
            button.layer.borderWidth = 3.0
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectedButton.remove (at: selectedButton.firstIndex(of: button)!)
            return
            
        } else if selectedButton.count == numberOfTwoOrThreeSets {
            cardButtonCollection.forEach() {
                $0.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
            }
            selectedButton.removeAll()
            updateScore()
        }
        selectedButton += [button]
        button.layer.borderWidth = 8.0
        button.layer.borderColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        button.layer.cornerRadius = 8.0
    }
    
    private func updateScore() {

        scoreLabel.text = "Score: \(game.score)"
        //scoreLabel.textColor = colorOfButtons
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
            
        game = Concentration(numberOfCardToMatch: numberOfTwoOrThreeSets)
        resetButton()
        updateViewFromModel()
        updateScore()
        selectedButton.removeAll()
        chooseTheme()
        
    }
    
    @IBAction func newGameThreeSetsPressed(_ sender: UIButton) {
        
        game = Concentration(numberOfCardToMatch: numberOfTwoOrThreeSets)
        resetButton()
        updateViewFromModel()
        updateScore()
        selectedButton.removeAll()
        chooseTheme()

    }
    
    private func resetButton() {
     
        for button in cardButtonCollection {
            let nsAttributedString = NSAttributedString(string: "")
            button.setAttributedTitle(nsAttributedString, for: UIControl.State.normal)
            button.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.layer.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.setTitle("", for: UIControl.State.normal)
  
        }
    }
    
    private func updateViewFromModel() {
        
        flipLabel.text = "Flips: \(game.flipCount)"
        //flipLabel.textColor = colorOfButtons
        background.backgroundColor = colorOfBackground
        
        for index in game.cardOnTable.indices {
            
            let card = game.cardOnTable[index]
            let button = cardButtonCollection[index]
            
            if card.isMatched{
                let nsAttributedString = NSAttributedString(string: "")
                button.setAttributedTitle(nsAttributedString, for: UIControl.State.normal)
                button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.setTitle("", for: UIControl.State.normal)
            }else{
                button.backgroundColor = colorOfButtons
                button.setTitle(setCardImage(with: game.cardOnTable[index]), for: UIControl.State.normal)
                button.setTitleColor(colorOfButtons, for: UIControl.State.normal)
            }
        }
    }
    
    
    /*----------------------------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------------------------*/
    // THEMES
    var colorOfBackground = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    var colorOfButtons = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
    
    func chooseTheme () {
        
        let themeColorOfCard =     ["faces" :     #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                                    "halloween" : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
                                    "gestures" :  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
                                    "animals" :   #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                                    "birds" :     #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
                                    "clothes":    #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)]
        let themeBackgroundColor = ["faces" :     #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),
                                    "halloween" : #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),
                                    "gestures" :  #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),
                                    "animals" :   #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
                                    "birds" :     #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
                                    "clothes":    #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)]
        
        let themeKeys = Array(themeBackgroundColor.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        colorOfBackground = Array(themeBackgroundColor.values)[themeIndex]
        colorOfButtons = Array(themeColorOfCard.values)[themeIndex]
    }
    
    private func setCardImage(with card: Card) -> String {
        
//        let randomTheme = [Theme.shape1[card.shape]!,Theme.shape2[card.shape]!,Theme.shape3[card.shape]!,Theme.shape4[card.shape]!,Theme.shape5[card.shape]!,Theme.shape6[card.shape]!]
//        let index = Int(arc4random_uniform(UInt32(randomTheme.count)))
//
//        return randomTheme[index]
        
        return Theme.shape1[card.shape]!  // I have to pick the emoji theme manually,
                                          // Otherwise will run wired
    }

}

struct Theme {
    
    static let shape1 : [Card.Shapes: String] =
    [.a: "🍏", .b: "🍎", .c: "🍐", .d: "🍊", .e: "🍋", .f:"🍌", .g:"🍉", .h:"🍇", .i:"🍓", .j:"🍈", .k:"🍒", .l:"🍑", .m:"🥭", .n:"🥕", .o:"🥝", .p:"🥥", .q:"🥦", .r:"🌶", .s:"🌽", .t:"🧄"]
    
    static let shape2 : [Card.Shapes: String] =
    [.a: "👼", .b: "🤷", .c: "🙆‍♀️", .d: "🙎‍♂️", .e: "🙋🏻‍♂️", .f:"💅", .g:"👯‍♀️", .h:"🙆‍♂️", .i:"💆‍♂️", .j:"💃", .k:"🕺", .l:"🙋‍♀️", .m:"🤳", .n:"👨🏿‍🦼", .o:"🏂", .p:"🪂", .q:"🛷", .r:"🏋️", .s:"🤾‍♂️", .t:"⛹️‍♀️"]
    
    static let shape3 : [Card.Shapes: String] =
    [.a: "💟", .b: "☮️", .c: "✝️", .d: "☪️", .e: "🕉", .f:"⛎", .g:"☸️", .h:"✡️", .i:"🔯", .j:"🕎", .k:"☯️", .l:"☦️", .m:"🛐", .n:"♈️", .o:"♉️", .p:"♊️", .q:"♋️", .r:"♌️", .s:"♍️", .t:"🆔"]
    
    static let shape4 : [Card.Shapes: String] =
    [.a: "🉑", .b: "☢️", .c: "☣️", .d: "📴", .e: "📳", .f:"🈶", .g:"🈚️", .h:"🈸", .i:"🈷️", .j:"🈺", .k:"✴️", .l:"🆚", .m:"💮", .n:"🉐", .o:"🈲", .p:"🅰️", .q:"🅱️", .r:"🆎", .s:"🆑", .t:"🅾️"]
    
    static let shape5 : [Card.Shapes: String] =
    [.a: "❌", .b: "⭕️", .c: "🛑", .d: "🎟", .e: "‼️", .f:"📛", .g:"⁉️", .h:"⛔️", .i:"❔", .j:"🚫", .k:"💯", .l:"🔞", .m:"🐙", .n:"❗️", .o:"♨️", .p:"💢", .q:"❓", .r:"💍", .s:"👠", .t:"❕"]
    
    static let shape6 : [Card.Shapes: String] =
    [.a: "✅", .b: "🈯️", .c: "❎", .d: "💹", .e: "❇️", .f:"✳️", .g:"🛂", .h:"Ⓜ️", .i:"🚻", .j:"🚮", .k:"📶", .l:"🈁", .m:"🅿️", .n:"🏧", .o:"🈂️", .p:"🈳", .q:"♿️", .r:"🚹", .s:"🚹", .t:"🛄"]
    
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
