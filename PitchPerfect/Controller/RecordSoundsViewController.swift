//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Lubna Ali on 17/11/2024.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: AVAudioPlayerDelegate

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    private var audioRecorder: AVAudioRecorder!
    
    // MARK: - View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(stateIsRecording: false)
    }
    
    // MARK: - IBActions
    @IBAction func recordAudio(_ sender: AnyObject) {
        configureUI(stateIsRecording: true)
        recordAudio()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(stateIsRecording: false)
        audioRecorder.stop()
        stopAudioSession()
    }
    
    // MARK: - Navigation
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        goToPlaySoundsVC()
     }
}

// MARK: - Extension
extension RecordSoundsViewController {
    
    // MARK: - UI Configuration
    func configureUI(stateIsRecording: Bool) {
        if stateIsRecording == true {
            recordingLabel.text = "Recording in progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        } else {
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
        }
    }
    
    // MARK: - Audio Methods and Delegation
    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Navigate to the next VC
    func goToPlaySoundsVC() {
        let playSoundsVC = storyboard?.instantiateViewController(withIdentifier: "PlaySoundsViewController") as! PlaySoundsViewController
        playSoundsVC.recordedAudioURL = audioRecorder.url
        navigationController?.pushViewController(playSoundsVC, animated: true)
    }
}
 
