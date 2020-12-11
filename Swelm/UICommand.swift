import Foundation

typealias UICommand = UICommandWith<Void>

final class UICommandWith<T>: Equatable {
    
    static func == (lhs: UICommandWith<T>, rhs: UICommandWith<T>) -> Bool {
//        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
        return true
    }
    
    init(action: @escaping (T) -> ()) {
        self.action = action
    }
    
    private let action: (T) -> ()
    
    func perform(with value: T) {
        action(value)
    }
    
    static var nop: UICommandWith { return UICommandWith() { _ in print("empty command performed") } }
    
}

extension UICommandWith where T == Void {
    func perform() {
        perform(with: ())
    }
}

