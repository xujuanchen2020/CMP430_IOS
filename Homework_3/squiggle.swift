
import UIKit

@IBDesignable class SetCardView: UIView {
    
    // Attributes
    var shape: SetCard.Shapes = SetCard.Shapes.diamond {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    var shade: SetCard.Shades = SetCard.Shades.outlined {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    var color: SetCard.Colors = SetCard.Colors.red {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var count: Int = 3 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isSelected: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable var isMisMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    
    
   /*************************************************/
   /*               drawSquiggle()                  */
   /*************************************************/

    private func drawSquiggle() -> UIBezierPath {
        let squiggle = UIBezierPath()
        
        squiggle.move(to: squiggleBottomLeft)
        squiggle.addCurve(to: squiggleTopLeft,
                          controlPoint1: squiggleControlLeftOne,
                          controlPoint2: squiggleControlLeftTwo)
        
        squiggle.addArc(withCenter: squiggleTopCenter,
                        radius: squiggleTopRadius,
                        startAngle: CGFloat.pi,
                        endAngle: 0.0,
                        clockwise: true)
        
        squiggle.addCurve(to: squiggleBottomRight,
                          controlPoint1: squiggleControlRightOne,
                          controlPoint2: squiggleControlRightTwo)
        
        squiggle.addArc(withCenter: squiggleBottomCenter,
                        radius: squiggleBottomRadius,
                        startAngle: 0.0,
                        endAngle: CGFloat.pi,
                        clockwise: true)
        
        squiggle.close()
        
        return squiggle
    }
    
    
   /*************************************************/
   /*               drawOval()                      */
   /*************************************************/

    private func drawOval() -> UIBezierPath {
        let oval = UIBezierPath()
        oval.move(to: squiggleBottomLeft)
        oval.addLine(to: squiggleTopLeft)
        oval.addArc(withCenter: squiggleTopCenter, radius: squiggleTopRadius, startAngle: CGFloat.pi, endAngle: 0.0, clockwise: true)
        oval.addLine(to: squiggleBottomRight)
        oval.addArc(withCenter: squiggleBottomCenter, radius: squiggleBottomRadius, startAngle: 0.0, endAngle: CGFloat.pi, clockwise: true)
        oval.close()
        return oval
    }
    
   /*************************************************/
   /*               drawDiamond()                   */
   /*************************************************/

    private func drawDiamond() -> UIBezierPath {
        let diamond = UIBezierPath()
        diamond.move(to: squiggleBottomCenter)
        diamond.addLine(to: CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * SquiggleRatios.widthPercentage), y: bounds.height/2 ))
        diamond.addLine(to: squiggleTopCenter)
        diamond.addLine(to: CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * SquiggleRatios.widthPercentage), y: bounds.height/2))

        diamond.close()
        return diamond
    }
    
    /*************************************************/
    /*               draw()                          */
    /*************************************************/
   
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds,
                                       cornerRadius: 16)
        roundedRect.addClip()
        roundedRect.lineWidth = 5.0

        if isSelected {
            UIColor.black.setStroke()
        } else if isMatched {
            UIColor.green.setStroke()
        } else if isMisMatched {
            UIColor.red.setStroke()
        } else {
            UIColor.white.setStroke()
        }
        
        UIColor.white.setFill()
        roundedRect.fill()
        roundedRect.stroke()
        
        
        let path = UIBezierPath()
        switch shape {
        case .squiggle:
            path.append(drawSquiggle())
        case .oval:
            path.append(drawOval())
        case .diamond:
            path.append(drawDiamond())
        }
        
        showPath(path)
    }

    
   /*************************************************/
   /*               showPath()                      */
   /*************************************************/

    private func showPath(_ path: UIBezierPath) {
        var path = replicatePath(path)
        colorForPath.setStroke()
        path = shadePath(path)
        path.lineWidth = 2.0
        path.fill()
        path.stroke()
    }
    
    
   /*************************************************/
   /*               replicatePath()                 */
   /*************************************************/

    private func replicatePath(_ path: UIBezierPath) -> UIBezierPath {
        let replicatedPath = UIBezierPath()
        
        if count == 1 {
            replicatedPath.append(path)
        } else if count == 2 {
            let leftPath = UIBezierPath()
            leftPath.append(path)
            let leftTransform = CGAffineTransform(translationX: leftTwoPathTranslation.x, y: leftTwoPathTranslation.y)
            leftPath.apply(leftTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path)
            let rightTransform = CGAffineTransform(translationX: rightTwoPathTranslation.x, y: rightTwoPathTranslation.y)
            rightPath.apply(rightTransform)
            
            replicatedPath.append(leftPath)
            replicatedPath.append(rightPath)
        } else if count == 3 {
            let leftPath = UIBezierPath()
            leftPath.append(path)
            let leftTransform = CGAffineTransform(translationX: leftThreePathTranslation.x, y: leftThreePathTranslation.y)
            leftPath.apply(leftTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path)
            let rightTransform = CGAffineTransform(translationX: rightThreePathTranslation.x, y: rightThreePathTranslation.y)
            rightPath.apply(rightTransform)
            
            replicatedPath.append(leftPath)
            replicatedPath.append(path)
            replicatedPath.append(rightPath)
        }
        
        
        return replicatedPath
    }
    
    
   /*************************************************/
   /*               replicatePath()                 */
   /*************************************************/

    private func shadePath(_ path: UIBezierPath) -> UIBezierPath {
        let shadedPath = UIBezierPath()
        shadedPath.append(path)
        
        switch shade {
        case .filled:
            colorForPath.setFill()
        case .striped:
            UIColor.clear.setFill()
            shadedPath.addClip()
            var start = CGPoint(x: 0.0, y: 0.0)
            var end   = CGPoint(x: self.bounds.size.width, y: 0.0)
            let dy: CGFloat = self.bounds.size.height / 10.0
            while start.y <= self.bounds.size.height {
                shadedPath.move(to: start)
                shadedPath.addLine(to: end)
                start.y += dy
                end.y += dy
            }
        case .outlined:
            UIColor.clear.setFill()
        }
        
        return shadedPath
    }
    
   /*************************************************/
   /*               colorForPath()                  */
   /*************************************************/

    private var colorForPath: UIColor {
        switch color {
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        }
    }
}


extension SetCardView {
    //
    // all the squiggle ratios and locations
    //
    private struct SquiggleRatios {
        static let offsetPercentage:                    CGFloat = 0.20
        static let widthPercentage:                     CGFloat = 0.15
        static let controlHorizontalOffsetPercentage:   CGFloat = 0.10
        static let controlVerticalOffsetPercentage:     CGFloat = 0.40
    }
    
    private var squiggleTopLeft: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height * SquiggleRatios.offsetPercentage)
    }
    
    private var squiggleBottomLeft: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.offsetPercentage))
    }
    
    private var squiggleControlLeftOne: CGPoint {
        let topLeft = squiggleTopLeft
        return CGPoint(x: topLeft.x + (self.bounds.size.width * SquiggleRatios.controlHorizontalOffsetPercentage),
                       y: self.bounds.size.height * SquiggleRatios.controlVerticalOffsetPercentage)
    }
    
    private var squiggleControlLeftTwo: CGPoint {
        let topLeft = squiggleTopLeft
        return CGPoint(x: topLeft.x - (self.bounds.size.width * SquiggleRatios.controlHorizontalOffsetPercentage),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.controlVerticalOffsetPercentage))
    }
    
    private var squiggleTopRight: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height * SquiggleRatios.offsetPercentage)
    }
    
    private var squiggleBottomRight: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * SquiggleRatios.widthPercentage/2.0),
                       y: self.bounds.size.height - (self.bounds.size.height * SquiggleRatios.offsetPercentage))
    }
    
    private var squiggleControlRightOne: CGPoint {
        let controlLeftTwo = squiggleControlLeftTwo
        return CGPoint(x: controlLeftTwo.x + (self.bounds.size.width * SquiggleRatios.widthPercentage),
                       y: controlLeftTwo.y)
    }
    
    private var squiggleControlRightTwo: CGPoint {
        let controlLeftOne = squiggleControlLeftOne
        return CGPoint(x: controlLeftOne.x + (self.bounds.size.width * SquiggleRatios.widthPercentage),
                       y: controlLeftOne.y)
    }
    
    private var squiggleTopCenter: CGPoint {
        let topLeft = squiggleTopLeft
        let topRight = squiggleTopRight
        return CGPoint(x: (topLeft.x + topRight.x)/2.0,
                       y: topLeft.y)
    }
    
    private var squiggleBottomCenter: CGPoint {
        let bottomLeft = squiggleBottomLeft
        let bottomRight = squiggleBottomRight
        return CGPoint(x: (bottomLeft.x + bottomRight.x)/2.0,
                       y: bottomLeft.y)
    }
    
    private var squiggleTopRadius: CGFloat {
        let topLeft = squiggleTopLeft
        let topRight = squiggleTopRight
        return (topRight.x - topLeft.x)/2.0
    }
    
    private var squiggleBottomRadius: CGFloat {
        let bottomLeft = squiggleBottomLeft
        let bottomRight = squiggleBottomRight
        return (bottomRight.x - bottomLeft.x)/2.0
    }
}

extension SetCardView {
    //
    // constants and ratios for path replication
    //
    private var leftTwoPathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * -0.15,
                       y: 0.0)
    }
    
    private var rightTwoPathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * 0.15,
                       y: 0.0)
    }
    
    private var leftThreePathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * -0.25,
                       y: 0.0)
    }
    
    private var rightThreePathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * 0.25,
                       y: 0.0)
    }

}
