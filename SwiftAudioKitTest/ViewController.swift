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
    
    
    var audioPlayerPool : AudioPlayerPool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayerPool =  AudioPlayerPool(pitchShift: 300.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var playButton: UIButton!
    @IBAction func playButtonPressed(sender: AnyObject) {
        //print("playButtonPressed")
        //audioPlayerPool.playFile(name: "a440", volume: 1.0)
        audioPlayerPool.playFile(name: "a440", volume: 1.0, playerIndex: 0)
        
    }
    
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopButtonPressed(sender: AnyObject) {
        audioPlayerPool.stopFile(name: "voice-unrooted-076")
    }
    
    @IBOutlet weak var playButton2: UIButton!
    @IBAction func playButton2Pressed(sender: AnyObject) {
       audioPlayerPool.playFile(name: "voice-unrooted-076", volume: 1.0, playerIndex: 1)
    }
    
    @IBOutlet weak var stopButton2: UIButton!
    @IBAction func stopButton2Pressed(sender: AnyObject) {
        //audioPlayer2.stop()
    }
    
    @IBOutlet weak var playButton3: UIButton!
    @IBAction func playButton3Pressed(sender: AnyObject) {
        audioPlayerPool.playFile(name: "voice-unrooted-076", volume: 1.0, playerIndex: 2)
    }
    
    @IBOutlet weak var stopButton3: UIButton!
    @IBAction func stopButton3Pressed(sender: AnyObject) {
        //audioPlayer3.stop()
    }


    
 
    

}

