//
//  MDMainSoundStudioViewController+Permissions.swift
//  MrDudets
//
//  Created by Anton on 18/12/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import AVFoundation

extension MDMainSoundStudioViewController {
    
    // MARK: Permissions and Session Setup
    
    func requestPermissions() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        // ios 8 and later
        
        if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    print("Permission to record granted")
                    
                    self.setSessionPlayAndRecord()
                    
                } else {
                    print("Permission to record not granted")
                }
            })
        } else {
            print("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayAndRecord() {
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            
            print("could not set session category")
            print(error.localizedDescription)
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            
            print("could not make session active")
            print(error.localizedDescription)
        }
        
    }
    
}
