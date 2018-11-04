//
//  Transcription.swift
//  note-buddy
//
//  Created by Lily Yang on 11/3/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import Reductio

class Transcription {
    
    var finalString: String?
    let audioEngine = AVAudioEngine()
    let speechInstance: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
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
    }
    
    func stop() {
        audioEngine.stop()
        request.endAudio()
        recognitionTask?.finish()
    }
    
    func getResult() {
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                finalString = result.bestTranscription.formattedString
            } else if let error = error {
                print("Error!")
            }
        })
    }
    
    func summarize() -> String {
        var summary = ""
        var result = Reductio.summarize(finalString, compression: 0.8)
        for i in result {
            summary += i
        }
        return summary
    }
    
    func vocabWords(String: raw) -> [String] {
        var wordArray = finalString.components(separatedBy: " ")
        var wordCount: [String : Int]
        var commonWords: [String]
        for i in wordArray {
            if i == "a" || i == "of" || i == "the" || i == "is" || i == "and" || i == "or" || i == "but" || i == "to" || i == "in" || i == "an" || i == "it" || i == "its" {
                continue
            } else if dict[i] == nil {
                dict[i] = 1
            } else {
                dict[i] += 1
            }
        }
        for _ in 0...5 {
            let maximum = dict.reduce(0.0) { max($0, $1.1) }
            var temp = dict.allKeys(forValue: maximum)
            commonWords.append(temp)
            dict[temp] = 0
        }
        return commonWords
    }
    
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
