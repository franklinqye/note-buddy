//
//  TranscriptViewController.swift
//  note-buddy
//
//  Created by Franklin Ye on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import UIKit

class TranscriptViewController: UIViewController {
    

    
    @IBOutlet weak var rawText: UILabel!
    var inputRawText: String?
    var transcription: Transcription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeText = inputRawText {
            if (safeText.count > 100) {
                rawText.text = String(safeText.prefix(100))
            } else {
                rawText.text = safeText
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func confirmText(_ sender: Any) {
        performSegue(withIdentifier: "transcriptVocab", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        print("hi")
        if id == "transcriptVocab" {
            guard let dest = segue.destination as? NotesViewContoller else { return }
            print("sleep")
//            dest.inputNotes = transcription!.summarize()
            dest.inputNotes = "hi"
//            dest.viewDidLoad()
            print("done")
        }
    }
}
