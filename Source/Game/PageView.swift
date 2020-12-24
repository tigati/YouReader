import SnapKit
import UIKit
import DifferenceKit

final class PageView: SwelmView {
    
    private lazy var imageView: UIImageView = {
        let view = ImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let logFont = UIFont(name: "GillSans", size: 40)
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = logFont
        label.textAlignment = .center
        return label
    }()
    private lazy var dummyLabel: UILabel = {
        let label = UILabel()
        label.text = "TEXT"
        label.font = logFont
        label.isHidden = true
        return label
    }()
    private let keyboardView = KeyboardView()
    
    var props: Props = .initial {
        didSet {
            print(oldValue)
            render(props: props)
        }
    }
    
    override func addSubviews() {
        addSubview(imageView)
        addSubview(typeLabel)
        addSubview(keyboardView)
        addSubview(dummyLabel)
    }
    
    override func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Size.m)
            make.leading.trailing.equalToSuperview().inset(Size.m)
        }
        
        dummyLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Size.l)
            make.leading.trailing.equalToSuperview().inset(Size.m)
        }
    
        dummyLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        typeLabel.snp.makeConstraints { make in
            make.edges.equalTo(dummyLabel)
        }
        
        keyboardView.snp.makeConstraints { make in
            make.top.equalTo(dummyLabel.snp.bottom).offset(Size.xl)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Size.l)
            make.leading.trailing.equalToSuperview().inset(Size.m)
            make.height.equalTo(160)
        }
    }
    
    override func setup() {
        backgroundColor = Palette.background
        
    }
}

extension PageView {
    func render(props: Props) {
        imageView.image = UIImage.init(named: props.image)
        typeLabel.text = props.type
        keyboardView.props = props.keyboard
    }
}

extension PageView {
    struct Props: Equatable, Differentiable {
        let index: Int
        let image: ImageFilename
        let type: String
        let keyboard: KeyboardView.Props
        
        static let initial = Props(
            index: 0,
            image: .empty,
            type: .empty,
            keyboard: .initial
        )
        
        var differenceIdentifier: Int {
            return index
        }
    }
}

final class ImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        return .init(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
}

final class PageViewCell: UICollectionViewCell {
    
    let pageView = PageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(pageView)
        
        pageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
