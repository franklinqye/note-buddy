//
//  MainFunction.swift
//  note-buddy
//
//  Created by Haotian Ye on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation


class MainFunction {
    
    var timer = Timer()
    var time = 0
    var returnSummary = ""
    var returnVocab = [String]()
    var runMain = Transcription()
    var running = true //stop button
    
    init() {}
    
    func main() -> String {
        runMain.start()
        while (running) {
            resetTimer()
        }
        resetTimer()
        return returnSummary
    }
    
    func resetTimer() {
        if (time % 60 == 0 && running) {
            returnSummary += runMain.summarize()
            for i in runMain.vocabWords {
                returnVocab.append(i)
            }
            runMain = Transcription()
            runMain.start()
        } else if (!running) {
            returnSummary += runMain.summarize()
            for i in runMain.vocabWords {
                returnVocab.append(i)
            }
        }
    }
}
