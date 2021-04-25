import UIKit

open class Button: UIControl {
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

    open func setHighlighted(_ isHighlighted: Bool) { }

    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setHighlighted(true)
        return true
    }

    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setHighlighted(isHighlighted)
        return true
    }

    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        setHighlighted(false)
    }

}
