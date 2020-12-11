//import Foundation
//import UIKit
//
//public class ScreenManager {
//    
////    public typealias Dispatch = (Action) -> Void
////    public typealias MapStateToProps<Props> = (_ state: State, _ dispatch: Dispatch) -> Props
//    
//    private var screens: [String: Reader<(App.State, Map.Dispatch), Void>] = [:]
//    private var routes: [String: RoutableVC.Type] = [:]
//    
//    func register<VC: RoutableVC>(
//        _ vcClass: VC.Type,
//        route: Route
//    )
//    {
//        self.routes[route.rawValue] = vcClass
//    }
//    
//    func newVC(for route: Route) -> UIViewController? {
//        guard let vcClass = self.routes[route.rawValue] else { return nil }
//        let vc = vcClass.init()
//        vc.route = route.rawValue
//        return vc
//    }
//    
//    var screenUpdates: [String : Reader<(App.State, Map.Dispatch), Void>] = [:]
//    
//    func registerScreenForStateUpdate<T: Screen>(vc: T) {
//        
//        let key = vc.id
//        self.screenUpdates[key] = Reader<(App.State, Map.Dispatch), Void> { state, dispatch in
//            vc.props = vc.map(state, dispatch)
//        }
//        
//        app.store.dispatch(.noop)
//    }
//    
//    func unregisterScreen(id: String) {
//        print("unregistering vc with id \(id)")
//        self.screenUpdates.removeValue(forKey: id)
//    }
//    
//    func updateViewControllers(state: App.State, dispatch: @escaping Map.Dispatch) {
//        let args = (state, dispatch)
//        
//        DispatchQueue.main.async {
//            self.screenUpdates.values.forEach { value in value.runReader(r: args) }
//        }
//    }
//    
//}
