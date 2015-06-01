//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gil Ferreira on 5/15/15.
//  Copyright (c) 2015 Gil Ferreira. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,  AVAudioRecorderDelegate {

    //Section for variables
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recording: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        stopBtn.hidden = true
        recordingButton.enabled = true
        recording.text = "Tap to Record"
        
    }
    
    //Beginning of functions section
    @IBAction func recordAudio(sender: UIButton) {
        
        println("Microphone button clicked")
        recording.text = "Recording"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recordingButton.enabled = false
        recording.hidden = false
        stopBtn.hidden = false
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){

        if(flag){
            // Step 1 - Save the recorded audio
            recordedAudio = RecordedAudio(recorder: recorder)

            recordedAudio.filePathUrl = recordedAudio.filePathUrl
            recordedAudio.title = recordedAudio.title
        }
        else
        {
            println("Not successfully saved")
            recording.text = "Unable to save. Click to try again"
            recordingButton.enabled = true
            stopBtn.hidden = true
        }

        // Step 2 - Move to the next scene aka perform segue
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording")
        {
             //Set a variable that will link up the other viewController
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receiveAudio = data
            
        }

    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        println("Stop button clicked")
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        recording.hidden = true
        stopBtn.hidden = true
        recordingButton.enabled = true
    
    }

}

