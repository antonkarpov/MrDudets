//
//  MDMusicStudioCell.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit


enum MDCellState {
    case `default`
    case recording
    case playing
    case looping
}


class MDMusicStudioCell: UICollectionViewCell {
    
    // MARK: - Variables & outlets
    
    var cellState: MDCellState = .default
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var loopButton: UIButton!
    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var durationLabel: MDDurationLabel!
    
    let redColorHex =        "#EB5757"
    let orangeColorHex =     "#F2994A"
    let yellowColorHex =     "#F2C94C"
    let greenColorHex =      "#219653"
    let lightBlueColorHex =  "#56CCF2"
    let blueColorHex =       "#2D9CDB"
    let silverTreeColorHex = "#6FCF97"
    let eucaliptusColorHex = "#27AE60"
    
    // MARK: - Cell configuration
    
    func configurateCell(_ indexPath: IndexPath) {
        self.backgroundColor = self.cellColor(indexPath.row)
        self.recordingLabel.isHidden = true
    }
    
    func cellColor(_ indexPathRow: Int) -> UIColor {
        let colorsDictionary = [0: redColorHex,
                                1: orangeColorHex,
                                2: yellowColorHex,
                                3: greenColorHex,
                                4: lightBlueColorHex,
                                5: blueColorHex,
                                6: silverTreeColorHex,
                                7: eucaliptusColorHex]
        
        return UIColor.init(hexString: colorsDictionary[indexPathRow]!)
    }
    
    //MARK: - Super Cell states
    
    func updateCellState(_ state: MDCellState) {
        switch state {
            
        case .default:
            recordingLabel.isHidden = true
            
            recordButton.isHidden = false
            playButton.isHidden = false
            loopButton.isHidden = false
            
            durationLabel.stopTimer()
            
            playButton.setImage(UIImage.init(named: "play_button_active"), for: UIControlState())
            loopButton.setImage(UIImage.init(named: "loop_button_active_off"), for: UIControlState())
            
            break
            
        case .recording:
            recordingLabel.isHidden = false
            
            recordButton.isHidden = false
            playButton.isHidden = true
            loopButton.isHidden = true
            
            durationLabel.startTimer()
            
            break
            
        case .playing:
            recordingLabel.isHidden = true
            
            recordButton.isHidden = true
            playButton.isHidden = false
            loopButton.isHidden = false
            
            durationLabel.startTimer()
            
            playButton.setImage(UIImage.init(named: "stop_button"), for: UIControlState())
            
            break
            
        case .looping:
            recordingLabel.isHidden = true
            
            recordButton.isHidden = true
            playButton.isHidden = true
            loopButton.isHidden = false
            
            durationLabel.stopTimer()
            
            loopButton.setImage(UIImage.init(named: "loop_button_active_on"), for: UIControlState())
            
            break
            
        }
        
        cellState = state
    }
    
}
