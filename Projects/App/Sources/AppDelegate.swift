import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let vc = GameVC()
    
    var store = Store<GamePage.State, GamePage.Event, GamePage.Effect>(
        state: .data,
        updater: GamePage.update,
        subscriptions: [],
        effectPerformer: GamePage.processEffects
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        let dispatch: GamePage.Dispatch = { event in
            self.store.update(with: event)
        }
        
        store.subscribe { state in
            let props = GamePage.mapState(state, dispatch: dispatch)
            self.vc.render(props)
        }
        
        store.update(with: .homeButtonTapped)
        
        
        
        return true
    }

}
