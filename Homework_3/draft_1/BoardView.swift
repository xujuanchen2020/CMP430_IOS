import UIKit

class BoardView: UIView {
    
    // BoardView class is a subView class of the UIView class.
    // Its model is the game's cardViews array Set: [SetCardView]
    // When setting the cardViews array externally, we treat its elements as subviews
    // removing old cards and placing new ones using the Grid class.

    var cardViews = [SetCardView]() {
        willSet { removeSubviews() }
        didSet { addSubviews(); setNeedsLayout() }
    }
    
    private func removeSubviews() {
        for card in cardViews {
            card.removeFromSuperview()
        }
    }
    
    private func addSubviews() {
        for card in cardViews {
            addSubview(card)
        }
    }
    
    // We just need to set the aspect ratio for the SetCardView, the size of the grid, bounds,
    // and specify the number of cells in this grid, so that the Grid class will provide us
    // with a frame for each cell.
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(
            layout: Grid.Layout.aspectRatio(Constant.cellAspectRatio),
            frame: bounds)
        grid.cellCount = cardViews.count
        for row in 0..<grid.dimensions.rowCount {
            for column in 0..<grid.dimensions.columnCount {
                if cardViews.count > (row * grid.dimensions.columnCount + column) {
                    
                    cardViews[row * grid.dimensions.columnCount + column].frame = grid[row,column]!.insetBy(
                                    dx: Constant.spacingDx, dy: Constant.spacingDy)
                }
            }
        }
    }
    
    struct Constant {
        static let cellAspectRatio: CGFloat = 0.7
        static let spacingDx: CGFloat  = 3.0
        static let spacingDy: CGFloat  = 3.0
    }
    
}
