import Foundation

enum GamePage {
    
    typealias Dispatch = (Event) -> Void
    
    struct State {
        var log: String
        var rounds: [Round]
        var currentRoundIndex: Int
        
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
        case pageScrolled(Int)
    }
    
    enum Effect {
        case playNote(WordPart)
    }
    
    static func update(state: inout State, event: Event) -> [Effect] {
        switch event {
        case .noteButtonTapped(let wordPart):
            let candidate = state.log + wordPart.text
            let word = state.rounds[state.currentRoundIndex].word
            if word.hasPrefix(candidate) {
                state.log += wordPart.text
            } else {
                state.log = wordPart.text
            }
            return [.playNote(wordPart)]
        case .pageScrolled(let pageIndex):
            if pageIndex == state.currentRoundIndex { return [] }
            state.currentRoundIndex = pageIndex
            state.log = .empty
            return []
        default:
            return []
        }
    }
    
    static func processEffect(_ effect: Effect, dispatch: @escaping Dispatch) {
        switch effect {
        case .playNote(let wordPart):
            AudioPlayer.shared.playSound(wordPart.sound)
        }
    }
    
}

extension GamePage {
    
    static func mapState(_ state: State, dispatch: @escaping Dispatch) -> GameVC.Props {
        let pages = state.rounds.enumerated().map { index, round -> PageView.Props in
            var log: String = .empty
            if state.currentRoundIndex == index {
                log = state.log
            }
            return mapRound(round, index: index, log: log, dispatch: dispatch)
        }
        
        let didScrollCommand = UICommandWith<Int> { pageIndex in dispatch(.pageScrolled(pageIndex)) }
        
        return .init(
            pages: pages,
            didScroll: didScrollCommand
        )
    }
    
    static func mapRound(_ round: State.Round, index: Int, log: String, dispatch: @escaping Dispatch) -> PageView.Props {
        
        let mapWordPartWithDispatch = curry(mapWordPart)(dispatch)
        
        let first = round.parts[safe: 0].flatMap(mapWordPartWithDispatch)
        let second = round.parts[safe: 1].flatMap(mapWordPartWithDispatch)
        let third = round.parts[safe: 2].flatMap(mapWordPartWithDispatch)
        let fourth = round.parts[safe: 3].flatMap(mapWordPartWithDispatch)
        
        return .init(
            index: index,
            image: round.image,
            type: log,
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

extension GamePage {
    static let reducer = Reducer<State, Event, Effect>.init { state, event -> [Effect] in
        update(state: &state, event: event)
    }
}
