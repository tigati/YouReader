import UIKit

protocol RoutableVC: UIViewController {
    var route: String { get set }
}

protocol Screen: RoutableVC {
    associatedtype Props
    var id: String { get }
    var props: Props? { get set }
}

class SwelmViewController<Props, View: SwelmView>: UIViewController, Screen {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var route: String = ""
    var id: String = UUID.init().uuidString
    var props: Props? = nil {
        didSet {
            if let props = props {
                self.render(oldProps: oldValue, props: props)
            }
        }
    }
    
    internal func render(oldProps: Props?, props: Props) {
        
    }
    
    let v: View = View()
    
    override func loadView() {
        self.view = v
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SwelmView: UIView {

    required init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        makeConstraints()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addSubviews() {
    }
    
    internal func makeConstraints() {
    }
    
    internal func setup() {
    }
}
