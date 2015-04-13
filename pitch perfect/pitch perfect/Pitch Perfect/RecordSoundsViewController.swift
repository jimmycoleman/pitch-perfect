//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by jimmy on 09/04/2015.
//  Copyright (c) 2015 udacityNano. All rights reserved.
//

import UIKit
import AVFoundation

var audioRecorder:AVAudioRecorder!
var recordedAudio:RecordedAudio!


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgessLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        tapToRecord.hidden = false
        recordingInProgessLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgessLabel.hidden = false
        stopButton.hidden = false
        tapToRecord.hidden = true
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive (true, error:nil)
        var documents: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [documents, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        var str = documents.stringByAppendingPathComponent("recordTest.caf")
        
        
    }
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop()
        recordButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
        performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording Not Succesfull")
            stopButton.hidden = true
            tapToRecord.hidden = false
            recordingInProgessLabel.hidden = true
        }
        recordButton.enabled = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
        var playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data

        }
    }
}

