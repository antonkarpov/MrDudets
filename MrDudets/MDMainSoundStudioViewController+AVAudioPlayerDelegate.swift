//
//  MDMainSoundStudioViewController+AVAudioPlayerDelegate.swift
//  MrDudets
//
//  Created by Anton on 18/12/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import AVFoundation

extension MDMainSoundStudioViewController : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
        
        let url = player.url
        var index = 0
        
        for i in 0..<dataSource.count {
            let item = dataSource[i]
            if item[MDCellData.url] as? URL == url {
                index = i
            }
        }
        
        let indexPath = IndexPath.init(row: index, section: 0)
        let musicCell = collectionView.cellForItem(at: indexPath) as! MDMusicStudioCell
        
        musicCell.updateCellState(MDCellState.default)
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
        
    }
}
