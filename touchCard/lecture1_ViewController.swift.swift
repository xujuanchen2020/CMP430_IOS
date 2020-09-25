import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0{
        didSet{
           flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["👻","🎃","💍","👘"]
     
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
//        let cardNumber = cardButtons.firstIndex(of: sender)!
//        print("cardNumber: \(cardNumber)")
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    func flipCard (withEmoji emoji:String, on button:UIButton){
        if button.currentTitle == emoji{
            button.setTitle("", for:UIControl.State.normal )
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    } 
}

