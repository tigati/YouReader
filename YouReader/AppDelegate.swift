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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        
        
        
        // Override point for customization after application launch.
        return true
    }

}

//extension GamePage.State.Play {
//    static let data = GamePage.State.Play(
//        currentRound: .init(
//            word: <#T##String#>,
//            image: <#T##ImageFilename#>,
//            parts: <#T##[WordPart]#>
//        ),
//        log: <#T##String#>,
//        nextRounds: <#T##[GamePage.State.Round]#>
//    )
//}
//
//extension GamePage.State.Round {
//    
//    static let first = GamePage.State.Round(
//        word: "машина",
//        image: "",
//        parts: [
//            .init(text: "ма", sound: <#T##SoundFilename#>)
//        ]
//    )
//    
//}
