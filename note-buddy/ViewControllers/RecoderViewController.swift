//
//  RecoderViewController.swift
//  note-buddy
//
//  Created by Franklin Ye on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import UIKit

class RecoderViewContoller: UIViewController {
    
    @IBOutlet weak var timeElapsed: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
//    var transcription = Transcription()
    var timer: Timer?
    
    var recording: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recording = false
        timer = Timer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func record(_ sender: Any) {
        guard let safeRecording = recording else { return }
        if safeRecording {
            performSegue(withIdentifier: "viewTranscript", sender: nil)//send transcription obj
        } else {
            recording = true
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "viewTranscript" {
            guard let dest = segue.destination as? TranscriptViewController else { return }
            guard let safeImage = imageToSend else { return }
            let timeOfSend = NSDate()
            let snap = Snap(time: timeOfSend, unread: true, image: safeImage, feed: selectedFeed!, user: User.name)
            user.addSnap(snap: snap)
            dest.viewDidLoad()
            user.refreshHome?()
    }
}
}
