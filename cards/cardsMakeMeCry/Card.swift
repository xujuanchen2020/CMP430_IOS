import Foundation

struct Card: Equatable{
    
    var isMatched = false
    
    var count: Int
    
    var shape: Shapes
    
    enum Shapes{

        case a
        case b
        case c
        case d
        case e
        case f
        case g
        case h
        case i
        case j
        case k
        case l
        case m
        case n
        case o
        case p
        case q
        case r
        case s
        case t
        
        static var all = [Shapes.a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m, .n, .o, .p, .q, .r, .s, .t]

    }

    init(shape:Shapes, count:Int){
        self.shape = shape
        self.count = count
    }

}

// Equatable
extension Card {

    static func == (lhs: Card, rhs: Card) -> Bool {

        return lhs.shape == rhs.shape && lhs.count == rhs.count

    }

}
