import Foundation

public typealias ViewEvent = ViewEventWith<Void>

public final class ViewEventWith<TValue>: Equatable {

    public static func == (lhs: ViewEventWith<TValue>, rhs: ViewEventWith<TValue>) -> Bool {
        return true
    }

    public init(action: @escaping (TValue) -> Void) {
        self.action = action
    }

    private let action: (TValue) -> Void

    public func perform(with value: TValue) {
        action(value)
    }

    public static var empty: ViewEventWith {
        return ViewEventWith { _ in print("empty command performed") }
    }

}

extension ViewEventWith where TValue == Void {
    public func perform() {
        perform(with: ())
    }
}
