//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dan Makfinsky on 3/8/15.
//  Copyright (c) 2015 Faktory Studios LLC. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    var receivedAudio:RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error:nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true
    }
    
    @IBAction func playSoundSlow(sender: UIButton) {
        resetAudioEngine()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 0.5
        audioPlayer.stop()
        audioPlayer.play()
    }
    
    @IBAction func playSoundFast(sender: AnyObject) {
        resetAudioEngine()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 1.5
        audioPlayer.stop()
        audioPlayer.play()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
    }
    
    @IBAction func playSoundChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playSoundDarthVader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    func resetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        println("Playing chipmunk")
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
}
