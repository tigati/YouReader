import Foundation

public final class Store<TState, TEvent, TEffect> {

    public typealias Dispatch = (TEvent) -> Void
    public typealias Subscription = (TState) -> Void
    public typealias Update = (_ state: inout TState, _ event: TEvent) -> [TEffect]
    public typealias EffectPerformer = ([TEffect], @escaping Dispatch) -> Void

    private var subscriptions: [Subscription]
    private let updater: Update
    private let effectPerformer: EffectPerformer

    private var state: TState

    public init(
        state: TState,
        updater: @escaping Update,
        subscriptions: [Subscription],
        effectPerformer: @escaping EffectPerformer
    ) {
        self.state = state
        self.updater = updater
        self.subscriptions = subscriptions
        self.effectPerformer = effectPerformer
    }

    public func update(with event: TEvent) {
        let effects = updater(&state, event)
        subscriptions.forEach { subscription in
            subscription(state)
        }
        effectPerformer(effects, update)
    }

    public func subscribe(_ subscription: @escaping Subscription) {
        subscriptions.append(subscription)
    }
}
