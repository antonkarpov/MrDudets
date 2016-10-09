//
//  NSFileManagerExtension.swift
//  AudioRecorder
//
//  Created by Anton on 08/10/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import Foundation

extension NSFileManager {
    
    class func generateURLsForRecords(count: Int) -> [NSURL] {
        var urls: [NSURL] = []
        
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask)[0]
        
        for index in 0..<count {
            let url = documentsDirectory.URLByAppendingPathComponent("record-\(index).m4a")
            
            urls.append(url)
        }
        
        return urls
    }
}