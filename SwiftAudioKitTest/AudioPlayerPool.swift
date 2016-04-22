//
//  AudioPlayerPool.swift
//  SwiftAudioKitTest
//
//  Created by Hans Tutschku on 4/22/16.
//  Copyright © 2016 Hans Tutschku. All rights reserved.
//

import Foundation
import AudioKit

class AudioPlayerPool {
  
    
    //var audioPlayer: AKAudioPlayer! // the exclamation mark makes it an implicit unwrapped optional
    // if not initialized and called it will crash the app
    
    //var audioPlayer2: AKAudioPlayer! // the exclamation mark makes it an implicit unwrapped optional
    // if not initialized and called it will crash the app
    
    //var audioPlayer3: AKAudioPlayer!
    
    var timePitch : AKTimePitch!
    var timePitch2 : AKTimePitch!
    var timePitch3 : AKTimePitch!
    
    var audioPlayers: [AKAudioPlayer] = []
    var mixer : AKMixer!
    
    var pitchShift : Double
    
    init(pitchShift: Double = 0.0){
        print("initialize AudioPlayerPool")
        self.pitchShift = pitchShift
        
        // generate audioPlayers
        
        
        //timePitch = makeConfiguredTimePitchNode(audioPlayer: audioPlayer)
        
        mixer = AKMixer()
        populateAudioPlayers()
        for audioPlayer in audioPlayers { mixer.connect(audioPlayer) }
        
        //mixer = AKMixer(audioPlayer)
        AudioKit.output = mixer
        AudioKit.start()
        //audioPlayer.play()
        
    
    }
    
    private func populateAudioPlayers() {
        for _ in 0..<3 {
            let audioPlayer = makeConfiguredAudioPlayer(name: "voice-unrooted-076", volume: 1.0, loops: false)!
            audioPlayers.append(audioPlayer)
        }
    }

    
    func playFile(name name: String, volume: Double, playerIndex: Int) {
        print("play \(name)")
        //AudioKit.stop() // eek
        
        let audioPlayer: AKAudioPlayer = audioPlayers[playerIndex] // hope its < 3
        audioPlayer.replaceFile(pathForAudioFile(name: name)!)
        stopAudioPlayerIfNecessary(audioPlayer: audioPlayer)
        //audioPlayer = makeConfiguredAudioPlayer(name: name, volume: volume, loops: false)

        //mixer = AKMixer(audioPlayer)
        //mixer.connect(audioPlayer)
        //
        //AudioKit.output = mixer

        //AudioKit.start()
        audioPlayer.play()
    }
    
    
    
    func stopFile(name name: String){
        print("stop \(name)")
        audioPlayers.forEach { $0.stop() }
    }
    
    private func makeConfiguredAudioPlayer(name name: String, volume: Double = 1.0, loops: Bool = false) -> AKAudioPlayer? {       // we don't know if it holds a real file path
        
        guard let path = pathForAudioFile(name: name) else {
            return nil                                              // if the path is not valid, we don't create an audio player
        }
        
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
}
