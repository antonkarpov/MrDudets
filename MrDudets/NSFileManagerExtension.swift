//
//  NSFileManagerExtension.swift
//  AudioRecorder
//
//  Created by Anton on 08/10/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import Foundation

extension FileManager {
    
    class func generateURLsForRecords(_ count: Int) -> [URL] {
        var urls: [URL] = []
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)[0]
        
        for index in 0..<count {
            let url = documentsDirectory.appendingPathComponent("record-\(index).m4a")
            
            urls.append(url)
        }
        
        return urls
    }
}
