import Foundation
import UIKit

struct Theme {
    let button: UIColor
    let text: UIColor
    let background: UIColor
}

extension GamePage.State {
    static let data = GamePage.State(
        log: .empty,
        rounds: [.first, .les, .second, .third, .fourth],
        currentRoundIndex: 0
    )
}

extension GamePage.State.Round {

    static let first = GamePage.State.Round(
        word: "лужа",
        image: "luzha",
        parts: [
            .init(text: "лу", sound: "luzha-lu.caf"),
            .init(text: "жа", sound: "luzha-zha.caf"),
        ]
    )

    static let second = GamePage.State.Round(
        word: "лимон",
        image: "limon",
        parts: [
            .init(text: "ли", sound: "limon-li.caf"),
            .init(text: "мон", sound: "limon-mon.m4a"),
        ]
    )
    
    static let third = GamePage.State.Round(
        word: "лебедь",
        image: "lebed'",
        parts: [
            .init(text: "ле", sound: "lebed'-le.caf"),
            .init(text: "бе", sound: "lebed'-be.caf"),
            .init(text: "дь", sound: "lebed'-d'.caf"),
        ]
    )
    
    static let fourth = GamePage.State.Round(
        word: "луна",
        image: "luna",
        parts: [
            .init(text: "лу", sound: "luna-lu.caf"),
            .init(text: "на", sound: "luna-na.caf"),
        ]
    )
    
    static let les = GamePage.State.Round(
        word: "лес",
        image: "les",
        parts: [
            .init(text: "ле", sound: "les-le.caf"),
            .init(text: "с", sound: "les-s.caf"),
        ]
    )
}
