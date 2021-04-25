import Foundation

public protocol CollectionCellView: PropsRenderer where Self: View {
    func setHighlighted(_ highlighted: Bool)
    func setSelected(_ selected: Bool)
    func prepareForReuse()
}

public extension CollectionCellView {
    func setHighlighted(_: Bool) { }
    func setSelected(_: Bool) { }
    func prepareForReuse() { }
}
