//
//  MDPianoSound.swift
//  MrDudets
//
//  Created by RomanPanichkin on 09/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import Foundation

enum MDNote {
    case mdNoteC
    case mdNoteD
    case mdNoteE
    case mdNoteF
    case mdNoteG
    case mdNoteA
    case mdNoteB
    case mdNoteCsharp
    case mdNoteDsharp
    case mdNoteEsharp
    case mdNoteFsharp
    case mdNoteGsharp
    case mdNoteAsharp
    case mdNoteBsharp
}

class MDPianoSound: NSObject {
    var octave: Int = 0
    var note: MDNote
    var soundUrl: URL?
    
    init(octave: Int, note: MDNote) {
        self.octave = octave
        self.note = note
  
        super.init()
    }
    
    func getSoundURL() -> URL {
        let noteString = self.stringValueForNote(self.note)
        let octaveString = self.stringValueForOctave(self.octave)
        let soundName = noteString + octaveString
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3", inDirectory: "Piano Sounds")!)
        
        return url
    }
    
    func stringValueForNote(_ note: MDNote) -> String {
        switch note {
        case .mdNoteC:
            return "C"
            
        case .mdNoteD:
            return "D"
            
        case .mdNoteE:
            return "E"
            
        case .mdNoteF:
            return "F"
            
        case .mdNoteG:
            return "G"
            
        case .mdNoteA:
            return "A"
            
        case .mdNoteB:
            return "B"
            
        case .mdNoteCsharp:
            return "C#"
            
        case .mdNoteDsharp:
            return "D#"
            
        case .mdNoteEsharp:
            return "E#"
            
        case .mdNoteFsharp:
            return "F#"
            
        case .mdNoteGsharp:
            return "G#"
            
        case .mdNoteAsharp:
            return "A#"
            
        case .mdNoteBsharp:
            return "B"
        }
    }
    
    func stringValueForOctave(_ octave: Int) -> String {
        return "\(octave)"
    }
}


