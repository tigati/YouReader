import UIKit

open class ViewController<TView: View>: UIViewController {
    public let v: TView = TView()

    public override func loadView() {
        self.view = v
    }
}
