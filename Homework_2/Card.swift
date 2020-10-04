import Foundation

struct Card: Equatable{
    
    var color: Colors
    var count: Numbers
    var shape: Shapes
    var shade: Shades
    
//    var isSelected = false
//    var isMatched = false
//    var isMisMatched = false
    
    enum Colors{
        
        case red
        case green
        case purple
        
        static var all = [Colors.red, .green, .purple]
        
    }
    
    enum Numbers{
        
        case one
        case two
        case three
        
        static var all = [Numbers.one, two, .three]
        
    }
    
    enum Shapes{
        
        case circle
        case square
        case triangle
        
        static var all = [Shapes.circle, .square, .triangle]
    }
    
    enum Shades{
        
        case solid
        case stripe
        case empty
        
        static var all = [Shades.solid, .stripe, .empty]
    }
    
    
    init(color: Colors, count: Numbers, shape: Shapes, shade: Shades) {
        
        self.color = color
        self.count = count
        self.shape = shape
        self.shade = shade
    }
    
}

//Equatable
extension Card {
   
    static func == (lhs: Card, rhs: Card) -> Bool {
        
        return lhs.color == rhs.color &&
                lhs.shape == rhs.shape &&
                lhs.count == rhs.count &&
                lhs.shade == rhs.shade
    }
     
}
