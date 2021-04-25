import UIKit

open class View: UIView {
    required public init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        setupViews()
        makeConstraints()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func addSubviews() { }

    open func setupViews() { }

    open func makeConstraints() { }
}
