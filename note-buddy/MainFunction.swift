//
//  MainFunction.swift
//  note-buddy
//
//  Created by Haotian Ye on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation


class MainFunction: Transcription {
    
    var timer = Timer()
    var time = 0
    var returnSummary = ""
    var returnVocab = [String]()
    var runMain = Transcription()
    var running = true //stop button
    
    override init() {}
    
    func main() {
        runMain.start()
        while (running) {
            resetTimer()
        }
        resetTimer()
    }
    
    func resetTimer() {
        if (time % 60 == 0 && running) {
            returnSummary += runMain.summarize()
            for i in runMain.vocabWords() {
                returnVocab.append(i)
            }
            runMain = Transcription()
            runMain.start()
        } else if (!running) {
            returnSummary += runMain.summarize()
            for i in runMain.vocabWords() {
                returnVocab.append(i)
            }
        }
    }
}
