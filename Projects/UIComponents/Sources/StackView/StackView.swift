import UIKit
import Core

/// Generic версия UIStackView
/// Нельзя добавлять arrangesSubviews вручную, только через props
public final class StackView<TCell: UIView & PropsRenderer>: UIStackView, PropsRenderer {
    public typealias Props = [TCell.Props]

    private var cells: [TCell] = []
    public var cellStyler: ((TCell) -> Void)?

    public func render(_ props: [TCell.Props]) {
        updateArrangedSubviewsAmount(for: props)

        self.arrangedSubviews.enumerated().forEach { index, view in
            if let cell = view as? TCell {
                let cellProps = props[index]
                cell.render(cellProps)
            }
        }
    }

    private func updateArrangedSubviewsAmount(for props: Props) {
        let diff = props.count - self.arrangedSubviews.count

        if diff > 0 {
            for _ in abs(diff) {
                let newView = TCell()
                if let cellStyler = cellStyler {
                    newView.style(cellStyler)
                }
                addArrangedSubview(newView)
            }
        } else if diff < 0 {
            for _ in abs(diff) {
                arrangedSubviews.last?.removeFromSuperview()
            }
        }
    }
}
