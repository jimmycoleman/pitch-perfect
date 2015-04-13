//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by jimmy on 09/04/2015.
//  Copyright (c) 2015 udacityNano. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    var recievedAudio:RecordedAudio!
    var audioPlayer = AVAudioPlayer()
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!


    override func viewDidLoad() {
        super.viewDidLoad()
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
    }
    

    @IBAction func PlaySlowSound(sender: AnyObject) {
        playAudioWithRate(0.5)
    }
    
    @IBAction func playDarthVadar(sender: UIButton) {
        playAudioWithPitch(-1000)

    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithPitch(1000)
    }
    @IBAction func PlayFastSound(sender: UIButton) {
        playAudioWithRate(1.5)
    }
    
    @IBAction func stopAllSounds(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playAudioWithRate(rate: Float) {
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        audioPlayer.play()
}
 func playAudioWithPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var audioPitch =  AVAudioUnitTimePitch()
        audioPitch.pitch = pitch
        audioEngine.attachNode(audioPitch)
        audioEngine.connect(audioPlayerNode, to:audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: nil)
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl,error: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
}
