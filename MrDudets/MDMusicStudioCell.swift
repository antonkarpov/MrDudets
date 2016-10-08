//
//  MDMusicStudioCell.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

class MDMusicStudioCell: UICollectionViewCell {
    
    let redColorHex =        "#EB5757"
    let orangeColorHex =     "#F2994A"
    let yellowColorHex =     "#F2C94C"
    let greenColorHex =      "#219653"
    let lightBlueColorHex =  "#56CCF2"
    let blueColorHex =       "#2D9CDB"
    let silverTreeColorHex = "#6FCF97"
    let eucaliptusColorHex = "#27AE60"
    
    func configurateCell(indexPath: NSIndexPath) {
        self.backgroundColor = self.cellColor(indexPath.row)
    }
    
    func cellColor(indexPathRow: Int) -> UIColor {
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
}
