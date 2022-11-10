//
//  HomeViewController.swift
//  littleReaders
//
//  Created by mymac on 21/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var levelCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightContraint: NSLayoutConstraint!
    
    //MARK: View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        descriptionLabelSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func descriptionLabelSetup(){
       // self.descriptionLabel.font = UIFont.setAppFont(fontName: .futuraStdLight, fontSize: .size16)
    }
    
    
   
    
   
   //MARK: Functions
    //Attributes text setup
    func setTitleText(text: String, hasSubscript: Bool = false, fontSize: CGFloat = 20.0) -> NSAttributedString{
        let firstLetterAttributes = [NSAttributedString.Key.font: CustomFont.gardenHouseRom.font(size: fontSize), .foregroundColor: UIColor.systemPink ]
        let myString = NSMutableAttributedString(string: "\(String(text.prefix(1)))", attributes: firstLetterAttributes)
        var subString = text.dropFirst().map{ " \(String($0))" }.joined()
        //For set TM as subscript
        if hasSubscript{
            subString = subString.replacingOccurrences(of: " M", with: "M")
        }
        let attrString = NSMutableAttributedString().characterSubscriptAndSuperscript(
            string: "\(subString)",
            characters:["T","M"],
            type: .aSuper,
            fontSize: fontSize - 3,
            fontColor: UIColor.systemPink,
            scriptFontSize: 8,
            offSet: 10,
            length: [1,1],
            alignment: .left)
        myString.append(attrString)
        return myString
    }
    
    //Collection View SetUp
   private func collectionViewSetUp(){
        self.levelCollectionView.register( UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LevelCollectionViewCell")
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0
        let cellHeight = ((self.levelCollectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow)/1.2
       self.collectionViewHeightContraint.constant = CGFloat(Int(appData?.levels?.count ?? 0/2)) * cellHeight
    }
}

//Extension for Collection view
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appData?.levels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCollectionViewCell", for: indexPath) as! LevelCollectionViewCell
        cell.level = appData?.levels?[indexPath.row]
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Remove after release
        if indexPath.row > 1{
            return
        }
        let descriptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "DesciptionViewController") as! DesciptionViewController
        descriptionViewController.levelDetails = appData?.levels?[indexPath.row]
        self.navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width/1.3)
    
    }
}
