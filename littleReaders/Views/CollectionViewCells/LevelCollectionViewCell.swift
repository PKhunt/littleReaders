//
//  LevelCollectionViewCell.swift
//  littleReaders
//
//  Created by mymac on 28/10/22.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriotionLabel: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.setAppFont(fontName: .futuraStdCondensedBold, fontSize: .size36)
        descriotionLabel.font = UIFont.setAppFont(fontName: .gardenHouseRom, fontSize: .size20)
    }
    
    override func draw(_ rect: CGRect) {
        self.bgView.setCornerRadius(7.5)
    }
    
    
    var level: Level?{
        didSet{
            self.bgView.backgroundColor = UIColor(hexFromString: level?.color ?? "")
            self.titleLabel.text = level?.title?.uppercased()
            self.descriotionLabel.text = level?.subtitle?.uppercased()
        }
    }

}
