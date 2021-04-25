import UIKit
import UIComponents

final class GameVC: ViewController<GameView> {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension GameVC: PropsRenderer {
    struct Props {
        let view: GameView.Props
    }
    
    func render(_ props: Props) {
        v.render(props.view)
    }
}

