import AVFoundation

final class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    static let shared = AudioPlayer()
    
    private var players: [AVAudioPlayer] = []
    
    func playSound(_ sound: SoundFilename) {
        guard
            let path = Bundle.main.path(forResource: sound, ofType: nil),
            let player = try? AVAudioPlayer.init(contentsOf: URL(fileURLWithPath: path))
        else {
            print("Soundfile \(sound) not found")
            return
        }
        player.delegate = self
        players.append(player)
        player.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        if let index = players.firstIndex(of: player) {
//            players.remove(at: index)
//        }
    }
}
