import UIKit

final class GameVC: SwelmViewController<GameView.Props, GameView> {
    
    override func render(oldProps: GameView.Props?, props: GameView.Props) {
        v.props = props
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


