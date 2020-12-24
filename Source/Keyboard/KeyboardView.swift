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
        stackView.spacing = 2
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
        firstButton.isHidden = true
        secondButton.isHidden = true
        thirdButton.isHidden = true
        fourthButton.isHidden = true
        
        if let first = props.first {
            firstButton.props = first
            firstButton.isHidden = false
        }
        
        if let second = props.second {
            secondButton.props = second
            secondButton.isHidden = false
        }
        
        if let third = props.third {
            thirdButton.props = third
            thirdButton.isHidden = false
        }
        
        if let fourth = props.fourth {
            fourthButton.props = fourth
            fourthButton.isHidden = false
        }
    }
    
}

extension KeyboardView {
    struct Props: Equatable {
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
