import Foundation
import Core
import UIKit
import SnapKit

public final class KeyboardView: View {
    private var keyViews: [KeyView] = []
    
    private let cellSize = CGSize(width: 60, height: 60)
    private let interHSpace = Space.space04
    private let interVSpace = Space.space04
    
    public override var intrinsicContentSize: CGSize {
        let width = bounds.width
        let maxElementsInRow = Int((width + interHSpace) / (cellSize.width + interHSpace))
        if maxElementsInRow == 0 { return .zero }
        let numberOfRows = Int(ceil(Double(keyViews.count) / Double(maxElementsInRow)))
        let height: CGFloat = CGFloat(numberOfRows) * cellSize.height + CGFloat(numberOfRows - 1) * interVSpace
        return .init(width: UIView.noIntrinsicMetric, height: height)
    }
}

extension KeyboardView: PropsRenderer {
    public struct Props: Equatable {
        public let keys: [KeyView.Props]

        public init(keys: [KeyView.Props]) {
            self.keys = keys
        }
    }

    public func render(_ props: Props) {
        updateKeyViewsAmount(for: props)
        props.keys.enumerated().forEach { index, keyViewProps in
            let keyView = keyViews[index]
            keyView.render(keyViewProps)
        }
    }
    
    public override func layoutSubviews() {
        
        let width = bounds.width
        
        let maxElementsInRow = Int((width + interHSpace) / (cellSize.width + interHSpace))
        
        let rows = keyViews.chunked(into: maxElementsInRow)
        
        rows.enumerated().forEach { rowIndex, row in
            let margin = (
                width - CGFloat(row.count)
                * cellSize.width - CGFloat(row.count - 1)
                * interHSpace
            ) / 2
            
            let y = CGFloat(rowIndex) * (interVSpace + cellSize.height)
            
            row.enumerated().forEach { columnIndex, keyView in
                let x = margin + CGFloat(columnIndex) * (cellSize.width + interHSpace)
                let origin = CGPoint(x: x, y: y)
                
                keyView.frame = CGRect(origin: origin, size: cellSize)
            }
            
        }
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateKeyViewsAmount(for props: Props) {
        let diff = props.keys.count - self.keyViews.count

        if diff > 0 {
            for _ in abs(diff) {
                let newView = KeyView()
                keyViews.append(newView)
                addSubview(newView)
            }
        } else if diff < 0 {
            for _ in abs(diff) {
                let keyView = keyViews.removeLast()
                keyView.removeFromSuperview()
            }
        }
        
        if diff != 0 {
            setNeedsLayout()
        }
    }
}
