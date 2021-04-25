import SnapKit
import UIKit

public final class GenericCollectionCell<CellView: CollectionCellView & PropsRenderer>: UICollectionViewCell {
    public lazy var cellView = CellView()
    private weak var edgesConstraint: Constraint?

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override public var isHighlighted: Bool {
        didSet {
            cellView.setHighlighted(isHighlighted)
        }
    }

    override public var isSelected: Bool {
        didSet {
            cellView.setSelected(isSelected)
        }
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        cellView.prepareForReuse()
    }
}

private extension GenericCollectionCell {
    func addSubviews() {
        contentView.addSubview(cellView)
    }

    func makeConstraints() {
        cellView.snp.makeConstraints { make in
            self.edgesConstraint = make.edges.equalToSuperview().constraint
        }
    }
}

extension GenericCollectionCell: PropsRenderer {
    public typealias Props = CellView.Props

    public func render(_ props: CellView.Props) {
        cellView.render(props)
    }
}
