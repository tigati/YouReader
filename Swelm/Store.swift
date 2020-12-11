import Foundation

public struct Reducer<S, A, C> {
    let reduce: (inout S, A) -> [C]
    
    public init(_ reduce: @escaping (inout S, A) -> [C]) {
        self.reduce = reduce
    }
}

precedencegroup MonoidAppend {
    associativity: left
}

infix operator <>: MonoidAppend
public protocol Monoid {
    static var empty: Self { get }
    static func <> (lhs: Self, rhs: Self) -> Self
}

extension Reducer: Monoid {
    public static var empty: Reducer<S, A, C> {
        return Reducer { _, _ in return []}
    }
    
    public static func <>(lhs: Reducer<S, A, C>, rhs: Reducer<S, A, C>) -> Reducer<S, A, C> {
        return Reducer { s, a in
            let cmdA = lhs.reduce(&s, a)
            let cmdB = rhs.reduce(&s, a)
            return cmdA + cmdB
        }
    }
}

public class Store<S, A, C> {
    public typealias Dispatch = (A) -> Void
    public typealias EffectPerformer = (C, @escaping Dispatch) -> Void
    typealias Subscriber = (S, @escaping Dispatch) -> Void
    
    private let reducer: Reducer<S, A, C>
    private let effectPerformer: EffectPerformer
    private var subscribers: [Subscriber] = []
    private(set) var state: S {
        didSet {
            self.subscribers.forEach { $0(self.state, self.dispatch) }
        }
    }
    
    public init(reducer: Reducer<S, A, C>, initialState: S, effectPerformer: @escaping EffectPerformer, effects: [C]) {
        self.reducer = reducer
        self.state = initialState
        self.effectPerformer = effectPerformer
        self.perform(effects)
    }
    
    public func dispatch(_ action: A) -> Void {
        let effect = self.reducer.reduce(&self.state, action)
        self.perform(effect)
    }
    
    func perform(_ effects: [C]) {
        effects.forEach { effect in
            self.effectPerformer(effect, self.dispatch)
        }
    }
    
    public func subscribe(_ subscriber: @escaping (S, @escaping Dispatch) -> Void) {
        self.subscribers.append(subscriber)
        subscriber(self.state, self.dispatch)
    }
    
    deinit {
        print("deinit store")
    }
}

public struct Prism<A, B> {
    public let preview: (A) -> B?
    public let review: (B) -> A
    
    public init(preview: @escaping (A) -> B?, review: @escaping (B) -> A) {
        self.preview = preview
        self.review = review
    }
}


public extension Reducer {
    
    func lift<T>(state: WritableKeyPath<T, S>) -> Reducer<T, A, C> {
        return Reducer<T, A, C> { t, a in
            self.reduce(&t[keyPath: state], a)
        }
    }
    
    func lift<B>(action: Prism<B, A>) -> Reducer<S, B, C> {
        return Reducer<S, B, C> { s, b in
            guard let a = action.preview(b) else { return [] }
            let cmdA = self.reduce(&s, a)
            return cmdA
        }
    }
    
    func lift<T, B>(state: WritableKeyPath<T, S>, action: Prism<B, A>) -> Reducer<T, B, C> {
        return Reducer<T, B, C> { stateT, actionB in
            guard let actionA = action.preview(actionB) else { return [] }
            let cmdA = self.reduce(&stateT[keyPath: state], actionA)
            return cmdA
        }
    }
    
    func lift<T, B>(state: Lens<T, S>, action: Prism<B, A>) -> Reducer<T, B, C> {
        return Reducer<T, B, C> { stateT, actionB in
            guard let actionA = action.preview(actionB) else { return [] }
            var stateS = state.view(stateT)
            let cmdA = self.reduce(&stateS, actionA)
            state.mutatingSet(&stateT, stateS)
            return cmdA
        }
    }
}

public struct Lens<A, B> {
    let view: (A) -> B
    let mutatingSet: (inout A, B) -> Void
    
    func set(_ whole: A, _ part: B) -> A {
        var result = whole
        self.mutatingSet(&result, part)
        return result
    }
}


func both<A, B, C>(_ lhs: Lens<A, B>, _ rhs: Lens<A, C>) -> Lens<A, (B, C)> {
    return Lens<A, (B, C)>(
        view: { (lhs.view($0), rhs.view($0)) },
        mutatingSet: { whole, parts in
            lhs.mutatingSet(&whole, parts.0)
            rhs.mutatingSet(&whole, parts.1)
    })
}


func lens<A, B>(_ keyPath: WritableKeyPath<A, B>) -> Lens<A, B> {
    return Lens<A, B>(
        view: { $0[keyPath: keyPath] },
        mutatingSet: { whole, part in whole[keyPath: keyPath] = part }
    )
}

