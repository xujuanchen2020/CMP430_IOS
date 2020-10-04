import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    private var game = SetGame()
    
    private var selectedButton = [UIButton]()
    private var hintedButton = [UIButton]()
    
    @IBOutlet var cardButtonCollection: [UIButton]!
    
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var threeMoreButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        
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
    
    private func chooseButton(at card: UIButton){
        
        if selectedButton.contains(card) {
            
            card.layer.borderWidth = 3.0
            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectedButton.remove (at: selectedButton.firstIndex(of: card)!)
            
            return
            
        } else if selectedButton.count == 3 {
            
            cardButtonCollection.forEach() {
                
                $0.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
            }
            
            selectedButton.removeAll()
            updateScore()
        }
        
        selectedButton += [card]
        // the border shows up when click on the cards
        card.layer.borderWidth = 3.0
        card.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        card.layer.cornerRadius = 8.0

    }
    
    private func updateScore() {
        
        scoreLabel.text = "\(game.score)"
    }
    
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        
        game.hint()
        
        if game.hintCard.count > 0 {
            
            for hint in 0...2 {
                
                let index = game.hintCard[hint]
                
                cardButtonCollection[index].layer.borderWidth = 3.0
                cardButtonCollection[index].layer.borderColor = UIColor.blue.cgColor
                cardButtonCollection[index].layer.cornerRadius = 8.0
                hintedButton.append(cardButtonCollection[index])
            }
            
            hintedButton.removeAll()
        }
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
            
        game = SetGame()
        resetButton()
        updateViewFromModel()
        hiddenButton()
        updateScore()
        selectedButton.removeAll()
        hintedButton.removeAll()
        
    }
    
    @IBAction func threeMoreButtonPressed(_ sender: UIButton) {
        
        game.draw()
        updateViewFromModel()
        hiddenButton()
    }
    
    private func hiddenButton() {

            if game.cardOnTable.count == 24 || game.numberOfCard == 0 {
                threeMoreButton.isHidden = true
                
            } else {
                threeMoreButton.isHidden = false
            }
        }

        private func resetButton() {
            
            for button in cardButtonCollection {
                
                let nsAttributedString = NSAttributedString(string: "")
                button.setAttributedTitle(nsAttributedString, for: .normal)
                button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
  
            }
            
        }
    
        private func updateViewFromModel() {

            for index in game.cardOnTable.indices {
                
                cardButtonCollection[index].titleLabel?.numberOfLines = 0
                cardButtonCollection[index].setAttributedTitle(setCardImage(with: game.cardOnTable[index]), for: .normal)
                cardButtonCollection[index].backgroundColor = #colorLiteral(red: 0.6327940226, green: 0.5182620287, blue: 0.3670437336, alpha: 1)
                
            }
        }
        
        private func setCardImage(with card: Card) -> NSAttributedString {

            let attributes: [NSAttributedString.Key: Any] = [
                .strokeColor: ModelOfCard.colors[card.color]!,
                .strokeWidth: ModelOfCard.strokeWidth[card.shade]!,
                .foregroundColor: ModelOfCard.colors[card.color]!.withAlphaComponent(ModelOfCard.alpha[card.shade]!),

                ]
            
            var cardTitle = ModelOfCard.shapes[card.shape]!
            
            switch card.count {
            case .two: cardTitle = "\(cardTitle)\n\(cardTitle)"
            case .three: cardTitle = "\(cardTitle)\n\(cardTitle)\n\(cardTitle)"
            default:
                break
            }

            return NSAttributedString(string: cardTitle, attributes: attributes)
        }
    
    }


    struct ModelOfCard {

        static let shapes : [Card.Shapes: String] = [.circle: "●", .triangle: "▲", .square: "■"]
        static var colors : [Card.Colors: UIColor] = [.red: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), .purple: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), .green: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
        static var alpha : [Card.Shades: CGFloat] = [.solid: 1.0, .empty: 0.60, .stripe: 0.15]
        static var strokeWidth : [Card.Shades: CGFloat] = [.solid: -10, .empty: 10, .stripe: -10]

    }
