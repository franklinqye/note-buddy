//
//  Transcription.swift
//  note-buddy
//
//  Created by Lily Yang on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import Reductio
import Speech

class Transcription {
    
    var finalString = ""
    let audioEngine = AVAudioEngine()
    let speechInstance = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    init() {}
    
    func start() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [unowned self] (buffer, _) in self.request.append(buffer)}
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print("Error!")
        }
        recognitionTask = speechInstance?.recognitionTask(with: request) { [unowned self] (result, _) in
            if let result = result {
                self.finalString = result.bestTranscription.formattedString
            }
        }
    }
    
    func stop() {
        audioEngine.stop()
        request.endAudio()
        recognitionTask?.finish()
    }
    
    func summarize() -> String {
        var summaryLst = [[String]]()
        var summaryString = ""
        if (finalString != "") {
            Reductio.summarize(text: finalString, compression: 0.80) {
                phrases in summaryLst.append(phrases)
            }
            for i in 0...summaryLst.count {
                for j in summaryLst[i] {
                    summaryString += j
                }
            }
        }
        return summaryString
    }
    
    func vocabWords() -> [String] {
        let wordArray = finalString.components(separatedBy: " ")
        var wordCount = [String : Int]()
        var commonWords = [String]()
        for i in wordArray {
            if i == "a" || i == "of" || i == "the" || i == "is" || i == "and" || i == "or" || i == "but" || i == "to" || i == "in" || i == "an" || i == "it" || i == "its" {
                continue
            } else if wordCount[i] == nil {
                wordCount[i] = 1
            } else {
                wordCount[i] = wordCount[i]! + 1
            }
        }
        for _ in 0...5 {
            let maximum = wordCount.values.max()
            let temp = allKeys(val: maximum!, dict: wordCount)
            for j in temp {
                commonWords.append(j)
                wordCount[j] = 0
            }
        }
        return commonWords
    }
    
    func allKeys(val: Int, dict: Dictionary<String, Int>) -> [String] {
        return dict.filter { $1 == val }.map { $0.0 }
    }
}
