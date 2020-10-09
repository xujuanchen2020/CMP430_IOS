import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...52 {
            if let card = deck.draw(){
                print ("\(card)")
            }
        }
    }
}
