import Foundation
import UIKit
import SnapKit
import AVFoundation

public final class KeyView: Button {
    private let containerView = UIView()
    private let label = UILabel()

    private var props: Props?
    
    private let font = UIFont(name: "GillSans", size: 30)!

    public override func addSubviews() {
        addSubview(containerView)
        addSubview(label)
    }

    public override func setupViews() {
        containerView.layer.cornerRadius = Space.space01
        containerView.layer.cornerCurve = .continuous
        containerView.backgroundColor = .white
        containerView.alpha = 0.8
        containerView.isUserInteractionEnabled = false
        label.style(Style.monoTitle2)
        label.style(Style.centerAligned)
        label.textColor = .black
        label.font = font
        addTarget(self, action: #selector(didTap), for: .touchDown)
    }

    public override func setHighlighted(_ isHighlighted: Bool) {
        if isHighlighted {
            containerView.alpha = 0.4
        } else {
            containerView.alpha = 0.8
        }
    }
    
    public override func layoutSubviews() {
        containerView.frame = bounds
        label.frame = bounds
    }

    @objc
    func didTap() {
        props?.onTap.perform()
    }
}

extension KeyView: PropsRenderer {
    public struct Props: Equatable {
        let text: String
        let onTap: ViewEvent

        public init(text: String, onTap: ViewEvent) {
            self.text = text
            self.onTap = onTap
        }
    }

    public func render(_ props: Props) {
        self.props = props
        label.text = props.text
    }
}
