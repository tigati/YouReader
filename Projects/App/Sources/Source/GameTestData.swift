import Foundation
import UIKit

struct Theme {
    let button: UIColor
    let text: UIColor
    let background: UIColor
}

extension GamePage.State {
    static let data = GamePage.State(
        rounds: rounds,
        currentRoundIndex: 0, currentStringPartIndex: 0
    )
}

extension GamePage.State {

    static let rounds = words.map { phrase -> GamePage.State.Round in
        let sklads = parseBySklads(text: phrase.text)
        sklads.forEach { text in
        }
        return .init(
            string: phrase.text,
            image: phrase.image,
            substrings: sklads,
            background: phrase.background
        )
    }
    
}
