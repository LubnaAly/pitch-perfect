//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Lubna Ali on 17/11/2024.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: - Properties
    private var audioRecorder: AVAudioRecorder!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(isRecording: false)
    }
    
    // MARK: - Actions
    @IBAction func recordAudio(_ sender: AnyObject) {
        configureUI(isRecording: true)
        recordAudio()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(isRecording: false)
        audioRecorder.stop()
        stopAudioSession()
    }
}

// MARK: - AVAudioPlayerDelegate

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        goToPlaySoundsVC()
     }
}

// MARK: - Private Methods

private extension RecordSoundsViewController {
    // MARK: - UI Configuration
    func configureUI(isRecording: Bool) {
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to Record"
        stopRecordingButton.isEnabled = isRecording
    }
    
    // MARK: - Audio Methods
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
    
    // MARK: - Navigation
    func goToPlaySoundsVC() {
        let playSoundsVC = storyboard?.instantiateViewController(withIdentifier: "PlaySoundsViewController") as! PlaySoundsViewController
        playSoundsVC.recordedAudioURL = audioRecorder.url
        navigationController?.pushViewController(playSoundsVC, animated: true)
    }
}
 
