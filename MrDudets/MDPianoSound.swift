//
//  MDPianoSound.swift
//  MrDudets
//
//  Created by RomanPanichkin on 09/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import Foundation

enum MDNote {
    case MDNoteC
    case MDNoteD
    case MDNoteE
    case MDNoteF
    case MDNoteG
    case MDNoteA
    case MDNoteB
    case MDNoteCsharp
    case MDNoteDsharp
    case MDNoteEsharp
    case MDNoteFsharp
    case MDNoteGsharp
    case MDNoteAsharp
    case MDNoteBsharp
}

class MDPianoSound: NSObject {
    var octave: Int = 0
    var note: MDNote
    var soundUrl: NSURL?
    
    init(octave: Int, note: MDNote) {
        self.octave = octave
        self.note = note
  
        super.init()
    }
    
    func getSoundURL() -> NSURL {
        let noteString = self.stringValueForNote(self.note)
        let octaveString = self.stringValueForOctave(self.octave)
        let soundName = noteString.stringByAppendingString(octaveString)
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3", inDirectory: "Piano Sounds")!)
        
        return url
    }
    
    func stringValueForNote(note: MDNote) -> String {
        switch note {
        case .MDNoteC:
            return "C"
            
        case .MDNoteD:
            return "D"
            
        case .MDNoteE:
            return "E"
            
        case .MDNoteF:
            return "F"
            
        case .MDNoteG:
            return "G"
            
        case .MDNoteA:
            return "A"
            
        case .MDNoteB:
            return "B"
            
        case .MDNoteCsharp:
            return "C#"
            
        case .MDNoteDsharp:
            return "D#"
            
        case .MDNoteEsharp:
            return "E#"
            
        case .MDNoteFsharp:
            return "F#"
            
        case .MDNoteGsharp:
            return "G#"
            
        case .MDNoteAsharp:
            return "A#"
            
        case .MDNoteBsharp:
            return "B"
        }
    }
    
    func stringValueForOctave(octave: Int) -> String {
        return "\(octave)"
    }
}


