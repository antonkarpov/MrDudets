//
//  MDPianoKeyboardViewController.swift
//  MrDudets
//
//  Created by RomanPanichkin on 09/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

class MDPianoKeyboardViewController: UIViewController {
    var player: MDAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let G5Sound = MDPianoSound.init(octave: 3, note: MDNote.mdNoteG)
        let url = G5Sound.getSoundURL()
        
        do {
            try self.player = MDAudioPlayer.init(URL: url, avDelegate: nil)
        }
        catch {
            
        }
        
    }
    
    @IBAction func sdf(_ sender: AnyObject) {
        player.play()
    }
}
