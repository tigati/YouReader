import Foundation
import UIKit
import UIComponents

enum GamePage {
    
    typealias Dispatch = (Event) -> Void
    
    struct State {
        var rounds: [Round]
        var currentRoundIndex: Int
        var currentStringPartIndex: Int
        var currentString: String?
        
        struct Round {
            let string: String
            let image: ImageFilename
            let substrings: [StringPart]
            let background: UIColor
        }
        
        func isCorrectNote(note: String) -> Bool {
            if note == rounds[safe: currentRoundIndex]?.substrings[safe: currentStringPartIndex]?.text {
                return true
            }
            return false
        }
        
        func isEndOfPhrase() -> Bool {
            currentStringPartIndex == rounds[currentRoundIndex].substrings.endIndex - 1
        }
        
        var currentStringPart: StringPart? {
            rounds[safe: currentRoundIndex]?.substrings[safe: currentStringPartIndex]
        }
    }
    
    enum Event {
        case noteButtonTapped(StringPart)
        case imageTapped
        case homeButtonTapped
        case pageScrolled(Int)
    }
    
    enum Effect {
        case playNote(String)
    }
    
    static func update(state: inout State, event: Event) -> [Effect] {
        switch event {
        case .noteButtonTapped(let note):
            
//            if state.isCorrectNote(note: note) {
//                if state.isEndOfPhrase() {
//                    state.currentStringPartIndex = 0
//                } else {
//                    state.currentStringPartIndex += 1
//                }
//            }
            
            state.currentString = note.text
            
            return [.playNote(note.text)]
        case .pageScrolled(let pageIndex):
            if pageIndex == state.currentRoundIndex { return [] }
            state.currentRoundIndex = pageIndex
            state.currentStringPartIndex = 0
            state.currentString = nil
            return []
        default:
            return []
        }
    }
    
    static func processEffects(_ effects: [Effect], dispatch: @escaping Dispatch) {
        effects.forEach { effect in
            processEffect(effect, dispatch: dispatch)
        }
    }
    
    static func processEffect(_ effect: Effect, dispatch: @escaping Dispatch) {
        switch effect {
        case .playNote(let note):
            AudioPlayer.shared.playNote(note)
        }
    }
    
}

extension GamePage {
    
    static func mapState(_ state: State, dispatch: @escaping Dispatch) -> GameVC.Props {
        
//        let pages = state.rounds.enumerated().map { index, round -> PageView.Props in
//            mapRound(
//                round: round,
//                index: index,
//                currentStringPart: state.currentString,
//                dispatch: dispatch
//            )
//        }
        
        let didScrollCommand = ViewEventWith<Int> { pageIndex in dispatch(.pageScrolled(pageIndex)) }
        
        let start = (state.currentRoundIndex - 3) > 0 ? state.currentRoundIndex - 3 : 0
        let end = state.currentRoundIndex + 3 < state.rounds.count ? state.currentRoundIndex + 3 : state.rounds.count - 1
        
        let range = start...end
        let pages = range.map { index -> (Int, PageView.Props) in
            let round = state.rounds[index]
            
            let currentStringPart = state.currentRoundIndex == index
                ? state.currentString
                : nil
            
            let mappedRound = mapRound(
                round: round,
                index: index,
                currentStringPart: currentStringPart,
                dispatch: dispatch
            )
            return (index, mappedRound)
        }
        
        let dict = Dictionary(uniqueKeysWithValues: pages)
        
        let view = GameView.Props(
            numberOfPages: state.rounds.count,
            currentPage: state.currentRoundIndex,
            visiblePages: dict, didScroll: didScrollCommand)
        
        return .init(view: view)
    }
    
    static func mapRound(
        round: State.Round,
        index: Int,
        currentStringPart: String?,
        dispatch: @escaping Dispatch
    ) -> PageView.Props
    {
        
        let mapNoteWithDispatch = curry(mapNote)(dispatch)
        let array = round.substrings
        let buttons = array.map(mapNoteWithDispatch)
        
        return .init(
            index: index,
            image: round.image,
            text: round.string,
            currentStringPart: currentStringPart,
            keyboard: .init(
                keys: buttons
            ),
            background: round.background
        )
    }
    
    static func mapNote(dispatch: @escaping Dispatch, note: StringPart) -> KeyView.Props {
        return .init(
            text: note.text,
            onTap: ViewEvent { dispatch(.noteButtonTapped(note)) }
        )
    }
    
}
