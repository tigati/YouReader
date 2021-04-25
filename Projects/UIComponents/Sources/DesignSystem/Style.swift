import UIKit

public struct Style {

    // MARK: - Label styles

    // MARK: Fonts

    public static func largeTitle(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }

    public static func title1(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }

    public static func title2(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .title2)
    }

    public static func title3(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }

    public static func headline(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .headline)
    }

    public static func body(_ label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .body)
    }

    public static func monoTitle1(_ label: UILabel) {
        label.font = UIFont(descriptor: .preferredMonoFontDescriptor(withTextStyle: .title1), size: 0)
    }

    public static func monoTitle2(_ label: UILabel) {
        label.font = UIFont(descriptor: .preferredMonoFontDescriptor(withTextStyle: .title2), size: 0)
    }

    // MARK: Other

    public static func centerAligned(_ label: UILabel) {
        label.textAlignment = .center
    }

    public static func multilined(_ label: UILabel) {
        label.numberOfLines = 0
    }

}

extension UIAppearance {
    public typealias Styler = (Self) -> Void

    @discardableResult
    public func style(_ styler: Styler) -> Self {
        styler(self)
        return self
    }
}
