//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Lubna Ali on 17/11/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("Button pressed")
        recordingLabel.text = "Recording in progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Button pressed")
    }
    
}

