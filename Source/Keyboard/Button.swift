import UIKit

final class Button: SwelmView {
    
    var props: Props = .initial {
        didSet {
            render(props: props)
        }
    }
    
    func render(props: Props) {
        button.setTitle(props.text, for: .normal)
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(Palette.primaryText, for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans", size: 60)
//        button.setBackgroundImage(UIImage(named: "button-normal"), for: .normal)
//        button.setBackgroundImage(UIImage(named: "button-pressed"), for: .highlighted)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        return button
    }()
    
    @objc
    private func buttonTapped() {
        props.onTap.perform()
    }
    
    override func addSubviews() {
        addSubview(button)
    }
    
    override func makeConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension Button {
    struct Props: Equatable {
        let text: String
        let onTap: UICommand
        
        static let initial = Props(text: .empty, onTap: .nop)
    }
}

