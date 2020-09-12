mport UIKit

class ViewController: UIViewController {
    
//    var flipCount: Int = 0
    var flipCount = 0
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(withEmoji: "👻", on: sender)
        flipCount += 1
        flipCountLabel.text = "Flips: \(flipCount)"
    }
    
    @IBAction func secondTouchCard(_ sender: UIButton) {
        flipCard(withEmoji: "🎃", on: sender)
        flipCount += 1
        flipCountLabel.text = "Flips: \(flipCount)"
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    func flipCard(withEmoji emoji: String, on button:UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor =  colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor =  colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }    
    
}
