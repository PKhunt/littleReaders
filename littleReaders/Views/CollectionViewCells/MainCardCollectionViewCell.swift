//
//  MainCardCollectionViewCell.swift
//  littleReaders
//
//  Created by mymac on 31/10/22.
//

import UIKit
import AVFoundation

class MainCardCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    //@IBOutlet weak var bgView: UIView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    
    //MARK: Varialbes
    var player: AVAudioPlayer?
    var isFlip: Bool?{
        didSet{
            self.frontImageView.alpha = isFlip ?? false ? 0.0 : 1.0
            self.backImageView.alpha = isFlip ?? false ? 1.0 : 0.0
        }
    }
    var levelDetials: Card?{
        didSet{
            self.frontImageView.image = UIImage(named: levelDetials?.frontDrawable ?? "")
            self.backImageView.image = UIImage(named: levelDetials?.backDrawable ?? "")
            //self.animateImage(isFlip: levelDetials?.isFlipped ?? false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // bgView.setCornerRadius(20)
    }
    
    func flipAnimation() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight]
        UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
            self.frontImageView.alpha = self.frontImageView.alpha == 1.0 ? 0.0 : 1.0
            self.backImageView.alpha = self.backImageView.alpha == 1.0 ? 0.0 : 1.0
        }, completion: {
            finished in
        } )
    }
    
    
}
