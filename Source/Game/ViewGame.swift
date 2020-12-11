import SnapKit
import UIKit

final class GameView: SwelmView {
    
    private let imageView = UIImageView()
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    private lazy var dummyLabel: UILabel = {
        let label = UILabel()
        label.text = "TEXT"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.isHidden = true
        return label
    }()
    private let keyboardView = KeyboardView()
    
    var props: Props = .initial {
        didSet {
            render(props: props)
        }
    }
    
    override func addSubviews() {
        addSubview(imageView)
        addSubview(typeLabel)
        addSubview(keyboardView)
        addSubview(dummyLabel)
        
        imageView.backgroundColor = .yellow
        typeLabel.backgroundColor = .green
    }
    
    override func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Size.m)
            make.leading.trailing.equalToSuperview().inset(Size.m)
        }
        
        dummyLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Size.l)
            make.leading.trailing.equalToSuperview().inset(Size.m)
            make.bottom.equalTo(keyboardView.snp.top).offset(Size.l)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.edges.equalTo(dummyLabel)
        }
        
        keyboardView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Size.l)
            make.leading.trailing.equalToSuperview().inset(Size.m)
            make.height.equalTo(200)
        }
    }
    
    override func setup() {
        backgroundColor = Palette.background
        
    }
}

extension GameView {
    func render(props: Props) {
        imageView.image = UIImage.init(named: props.image)
        typeLabel.text = props.type
        keyboardView.props = props.keyboard
    }
}

extension GameView {
    struct Props {
        let image: ImageFilename
        let type: String
        let keyboard: KeyboardView.Props
        
        static let initial = Props(
            image: .empty,
            type: .empty,
            keyboard: .initial
        )
    }
}
