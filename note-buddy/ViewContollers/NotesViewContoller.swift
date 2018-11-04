//
//  NotesViewContoller.swift
//  note-buddy
//
//  Created by Franklin Ye on 11/4/18.
//  Copyright © 2018 Franklin Ye. All rights reserved.
//

import Foundation
import UIKit

class NotesViewContoller: UIViewController {
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
//    private static let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    var inputNotes: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes.text = inputNotes
    }
    
    @IBAction func restart() {
        performSegue(withIdentifier: "backToStart", sender: self)
    }
    
    @IBAction func save() {
        let file = "file.txt" //this is the file. we will write to and read from it
        
        let text = inputNotes //just a text
        
        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)
        
        if let temp = dir.first {
            print(dir[0])
            
            let fileURL = temp.appendingPathComponent(file)
            
            //writing
            do {
                try text!.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {print("oops")}
            
            //reading
            do {
                _ = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {print("yikes")}
        }
//        // Set the file path
//        let path = "myfile.txt"
//
//        // Set the contents
//        let contents = inputNotes
//
//        do {
//            // Write contents to file
//            try contents!.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
//        }
//        catch let error as NSError {
//            print("Ooops! Something went wrong: \(error)")
//        }

    }
    
//    static func unzipFile(atPath path: String) -> Bool
//    {
//        let destString = documentsURL.relativePath
//
//        let success: Void? = try? SSZipArchive.unzipFile(atPath: path, toDestination: documentsURL.relativePath, overwrite: true, password: nil)
//
//        if success == nil
//        {
//            return false
//        }
//
//        return true
//    }

}
