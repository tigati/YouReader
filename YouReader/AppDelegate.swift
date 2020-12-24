//
//  AppDelegate.swift
//  YouReader
//
//  Created by Timur Gayfulin on 10.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let vc = GameVC()
    
    var store = Store<GamePage.State, GamePage.Event, GamePage.Effect>.init(
        reducer: GamePage.reducer,
        initialState: .data,
        effectPerformer: GamePage.processEffect,
        effects: []
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        
        store.subscribe { state, dispatch in
            self.vc.props = GamePage.mapState(state, dispatch: dispatch)
        }
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
        return true
    }

}
