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
        recognitionTask = speechInstance?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                self.finalString = result.bestTranscription.formattedString
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func summarize() -> String {
        var summary = ""
        var result = Reductio.summarize(finalString, compression: 0.80)
        for i in result {
            summary += i
        }
        return summary
    }
    
    func vocabWords() -> [String] {
        var wordArray = finalString!.components(separatedBy: " ")
        var wordCount: [String : Int]
        var commonWords: [String]
        for i in wordArray {
            if i == "a" || i == "of" || i == "the" || i == "is" || i == "and" || i == "or" || i == "but" || i == "to" || i == "in" || i == "an" || i == "it" || i == "its" {
                continue
            } else if wordCount[i] == nil {
                wordCount[i] = 1
            } else {
                [i] += 1
            }
        }
        for _ in 0...5 {
            let maximum = wordCount.values.max()
            var temp = allKeys(val: maximum!, dict: wordCount)
            for j in temp {
                commonWords.append(j)
            }
            wordCount[temp] = 0
        }
        return commonWords
    }
    
    func allKeys(val: Int, dict: Dictionary<String, Int>) -> [String] {
        return dict.filter { $1 == val }.map { $0.0 }
    }
}
