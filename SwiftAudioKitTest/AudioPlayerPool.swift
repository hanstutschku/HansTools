//
//  AudioPlayerPool.swift
//  SwiftAudioKitTest
//
//  Created by Hans Tutschku on 4/22/16.
//  Copyright © 2016 Hans Tutschku. All rights reserved.
//

import Foundation
import AudioKit

public class AudioPlayerPool {
    
    // Deal with these like the audio players
    var timePitch : AKTimePitch!
    var timePitch2 : AKTimePitch!
    var timePitch3 : AKTimePitch!
    
    var audioPlayers: [AKAudioPlayer] = []
    var audioPlayersState: [Bool] = []
    var mixer : AKMixer!
    
    var pitchShift : Double
    
    private let numberOfAudioPlayers = 6
    
    public init(pitchShift: Double = 0.0){
        self.pitchShift = pitchShift
        mixer = AKMixer()
        populateAudioPlayers()
        for audioPlayer in audioPlayers { mixer.connect(audioPlayer) }
        AudioKit.output = mixer
        AudioKit.start()
    }
    
    public func playFile(name name: String, volume: Double, playerIndex: Int) {
        
        returnFreePlayer()
        
        let audioPlayer: AKAudioPlayer = audioPlayers[playerIndex] // hope its < 3
        audioPlayer.replaceFile(pathForAudioFile(name: name)!)
        stopAudioPlayerIfNecessary(audioPlayer: audioPlayer)
        audioPlayer.play()
    }
    
    // currently stops ALL audio players
    public func stopFile(name name: String) {
        audioPlayers.forEach { $0.stop() }
    }
    
    private func returnFreePlayer(){
            for i in 0..<numberOfAudioPlayers {
                print("return free player \(i)")
        }
    }
    
    private func makeConfiguredAudioPlayer(name name: String, volume: Double = 1.0, loops: Bool = false) -> AKAudioPlayer? {       // we don't know if it holds a real file path
        guard let path = pathForAudioFile(name: name) else { return nil }
        let audioPlayer = AKAudioPlayer(path) // local audioPlayer
        audioPlayer.volume = volume
        audioPlayer.looping = loops
        return audioPlayer
    }

    private func makeConfiguredTimePitchNode(audioPlayer audioPlayer : AKAudioPlayer) -> AKTimePitch {
        let timePitch = AKTimePitch(audioPlayer)            //this becomes a local variable
        timePitch.rate = 1.0
        timePitch.pitch = pitchShift
        timePitch.overlap = 8.0
        return timePitch                                    // return local timePitch object
    }
    
    private func pathForAudioFile(name name: String) -> String? {
        let bundle = NSBundle.mainBundle()
        return bundle.pathForResource(name, ofType: "caf") // this string is nil if no file was found
    }
    
    private func stopAudioPlayerIfNecessary(audioPlayer audioPlayer: AKAudioPlayer) {
        if !audioPlayer.isStopped { audioPlayer.stop() }
    }
    
    private func populateAudioPlayers() {
        for _ in 0..<numberOfAudioPlayers {                    // generate 6 players
            let audioPlayer = makeConfiguredAudioPlayer(name: "", volume: 1.0, loops: false)!
            audioPlayers.append(audioPlayer)
        }
    }
}
