//
//  ViewController.swift
//  SwiftAudioKitTest
//
//  Created by Hans Tutschku on 4/22/16.
//  Copyright © 2016 Hans Tutschku. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var audioPlayer: AKAudioPlayer! // the exclamation mark makes it an implicit unwrapped optional
                                    // if not initialized and called it will crash the app
    
    var audioPlayer2: AKAudioPlayer! // the exclamation mark makes it an implicit unwrapped optional
    // if not initialized and called it will crash the app
 
    var audioPlayer3: AKAudioPlayer!
   
    var timePitch : AKTimePitch!
    var timePitch2 : AKTimePitch!
    var timePitch3 : AKTimePitch!
    
    var mixer : AKMixer!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = makeConfiguredAudioPlayer(name: "a440", volume: 0.3, loops: true)
        timePitch = makeConfiguredTimePitchNode(cents: 900.0, audioPlayer: audioPlayer)
        audioPlayer2 = makeConfiguredAudioPlayer(name: "voice-unrooted-076", volume: 0.5, loops: true)
        timePitch2 = makeConfiguredTimePitchNode(cents: -500.0, audioPlayer: audioPlayer2)
        audioPlayer3 = makeConfiguredAudioPlayer(name: "a440", volume: 0.1, loops: true)
        timePitch3 = makeConfiguredTimePitchNode(cents: -100.0, audioPlayer: audioPlayer3)
        mixer = AKMixer(timePitch, timePitch2, timePitch3)
        AudioKit.output = mixer
        AudioKit.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var playButton: UIButton!
    @IBAction func playButtonPressed(sender: AnyObject) {
        //print("playButtonPressed")
        audioPlayer.play()
    }
    
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopButtonPressed(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    @IBOutlet weak var playButton2: UIButton!
    @IBAction func playButton2Pressed(sender: AnyObject) {
        audioPlayer2.play()
    }
    
    @IBOutlet weak var stopButton2: UIButton!
    @IBAction func stopButton2Pressed(sender: AnyObject) {
        audioPlayer2.stop()
    }
    
    @IBOutlet weak var playButton3: UIButton!
    @IBAction func playButton3Pressed(sender: AnyObject) {
        audioPlayer3.play()
    }
    
    @IBOutlet weak var stopButton3: UIButton!
    @IBAction func stopButton3Pressed(sender: AnyObject) {
        audioPlayer3.stop()
    }


    
    func pathForAudioFile(name name: String) -> String? {
        let bundle = NSBundle.mainBundle()
        return bundle.pathForResource(name, ofType: "caf") // this string is nil if no file was found
    }

    
    func makeConfiguredTimePitchNode(cents cents: Double, audioPlayer : AKAudioPlayer) -> AKTimePitch {
        let timePitch = AKTimePitch(audioPlayer)            //this becomes a local variable
        timePitch.rate = 1.0
        timePitch.pitch = cents
        timePitch.overlap = 8.0
        return timePitch                                    // return local timePitch object
    }
    

    func makeConfiguredAudioPlayer(name name: String, volume: Double = 1.0, loops: Bool = false) -> AKAudioPlayer? {       // we don't know if it holds a real file path
        
        guard let path = pathForAudioFile(name: name) else {
            return nil                                              // if the path is not valid, we don't create an audio player
        }
    
        let audioPlayer = AKAudioPlayer(path) // local audioPlayer
        audioPlayer.volume = volume
        audioPlayer.looping = loops
        return audioPlayer
    }

    

}

