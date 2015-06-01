//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gil Ferreira on 5/26/15.
//  Copyright (c) 2015 Gil Ferreira. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receiveAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio(speed: Float)
    {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        println("Snail pressed")
        
        //Stop all audio
        stopAllAudio()
        playAudio(0.5)
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        println("Rabbit pressed")
        
        //Stop all audio
        stopAllAudio()
        playAudio(1.5)
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
    
        stopAllAudio()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        println("Chipmunk pressed")
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        println("Darth Vader pressed")
        playAudioWithVariablePitch(-1000)
    
    }
    
    func playAudioWithVariablePitch(pitch: Float){
    
        //Stop all audio
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func stopAllAudio()
    {
        //Stop all audio
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
