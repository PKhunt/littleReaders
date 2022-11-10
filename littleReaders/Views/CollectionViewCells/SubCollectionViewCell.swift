//
//  subCollectionViewCell.swift
//  littleReaders
//
//  Created by mymac on 03/11/22.
//

import UIKit

class SubCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var selectedColor: UIColor = .white
    var text: String?{
        didSet{
            textLabel.text = text
        }
    }
    
    var cellSelected: Bool?{
        didSet{
            textLabel.textColor = cellSelected ?? false ? .white : .gray
            bgView.backgroundColor = cellSelected ?? false ? self.selectedColor : .white
            bgView.layer.borderColor = cellSelected ?? false ? self.selectedColor.cgColor : UIColor.gray.cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setCornerRadius(10)
        bgView.setBorderWidth(0.8)
        textLabel.font = UIFont.setAppFont(fontName: .gardenHouseRom, fontSize: .size28)
    }
    
    

}
