import UIKit
import SnapKit

final class KeyboardView: SwelmView {
    
    var props: Props = .initial {
        didSet {
            render(props: props)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(thirdButton)
        stackView.addArrangedSubview(fourthButton)
        
        return stackView
    }()
    
    private let firstButton = Button()
    private let secondButton = Button()
    private let thirdButton = Button()
    private let fourthButton = Button()
    
    override func addSubviews() {
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension KeyboardView {
    
    private func render(props: Props) {
        firstButton.props = props.first ?? .initial
        secondButton.props = props.second ?? .initial
        thirdButton.props = props.third ?? .initial
        fourthButton.props = props.fourth ?? .initial
    }
    
}

extension KeyboardView {
    struct Props {
        let first: Button.Props?
        let second: Button.Props?
        let third: Button.Props?
        let fourth: Button.Props?
        
        static let initial = Props(
            first: nil,
            second: nil,
            third: nil,
            fourth: nil
        )
    }
}
