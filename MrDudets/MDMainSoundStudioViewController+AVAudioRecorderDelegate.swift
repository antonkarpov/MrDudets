//
//  MDMainSoundStudioViewController+AVAudioRecorderDelegate.swift
//  MrDudets
//
//  Created by Anton on 18/12/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import AVFoundation

extension MDMainSoundStudioViewController : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
                                         successfully flag: Bool) {
        print("finished recording \(flag)")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
    
}
