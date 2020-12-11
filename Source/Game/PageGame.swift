import Foundation

enum GamePage {
    
    typealias Dispatch = (Event) -> Void
    
    enum State {
        case playing(Play)
        case victory(Play)
        
        struct Play {
            var currentRound: Round
            var log: String
            let nextRounds: [Round]
        }
        
        struct Round {
            let word: String
            let image: ImageFilename
            let parts: [WordPart]
        }
    }
    
    enum Event {
        case noteButtonTapped(WordPart)
        case imageTapped
        case homeButtonTapped
    }
    
    enum Effect {
        case playNote(WordPart)
    }
    
    static func update(state: inout State, event: Event) -> [Effect] {
        return []
    }
    
    static func processEffects(_ effects: [Effect]) {
        effects.forEach { effect in
            processEffect(effect)
        }
    }
    
    static func processEffect(_ effect: Effect) {
        
    }
    
}

extension GamePage {
    
    static func mapState(_ state: State, dispatch: @escaping Dispatch) -> GameVC.Props {
        switch state {
        case .playing(let play):
            return mapPlay(play, dispatch: dispatch)
        case .victory(let play):
            return mapPlay(play, dispatch: dispatch)
        }
    }
    
    static func mapPlay(_ play: State.Play, dispatch: @escaping Dispatch) -> GameView.Props {
        
        let mapWordPartWithDispatch = curry(mapWordPart)(dispatch)
        
        let first = play.currentRound.parts[safe: 0].flatMap(mapWordPartWithDispatch)
        let second = play.currentRound.parts[safe: 0].flatMap(mapWordPartWithDispatch)
        let third = play.currentRound.parts[safe: 0].flatMap(mapWordPartWithDispatch)
        let fourth = play.currentRound.parts[safe: 0].flatMap(mapWordPartWithDispatch)
        
        return .init(
            image: play.currentRound.image,
            type: play.log,
            keyboard: .init(
                first: first,
                second: second,
                third: third,
                fourth: fourth
            )
        )
    }
    
    static func mapWordPart(dispatch: @escaping Dispatch, wordPart: WordPart) -> Button.Props {
        .init(
            text: wordPart.text,
            onTap: UICommand { dispatch(.noteButtonTapped(wordPart)) }
        )
    }
    
}
