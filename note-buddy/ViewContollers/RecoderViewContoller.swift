//
//  RecoderViewContoller.swift
//  note-buddy
//
//  Created by Franklin Ye on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import UIKit

class RecoderViewContoller: UIViewController {
    
    
    @IBOutlet weak var timeElasped: UILabel!
    
    @IBOutlet weak var timeElapsed: UILabel!
    var transcription = Transcription()
    var timer = Timer()
    var time = 0
    
    var recording: Bool?
    
    override func viewDidLoad() {
        timeElapsed.text = "00:00"
        super.viewDidLoad()
        recording = false
        timer = Timer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func record(_ sender: Any) {
        guard let safeRecording = recording else { return }
        if safeRecording {
            transcription.stop()
            performSegue(withIdentifier: "viewTranscript", sender: nil)
        } else {
            recording = true
            Timer.scheduledTimer(timeInterval: 1,
                                 target: self, selector: #selector(updateTimeElapsed), userInfo: nil, repeats: true)
            transcription.start()
        }
    }
    
    @objc func updateTimeElapsed() {
        time += 1
        let seconds = String(time % 60)
        let minutes = String(time / 60)
        timeElapsed.text = "\(seconds):\(minutes)"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "viewTranscript" {
            guard let dest = segue.destination as? TranscriptViewController else { return }
            dest.transcription = transcription
            dest.inputRawText = transcription.finalString
            dest.viewDidLoad()
        }
    }
    
    @IBAction func unwindToRecorder(segue:UIStoryboardSegue) { }
}
