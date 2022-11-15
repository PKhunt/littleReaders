//
//  CardViewController.swift
//  littleReaders
//
//  Created by mymac on 29/10/22.
//

import UIKit
import AVFoundation

protocol CardViewControllerDelegate{
    func levelButtonTapped()
}
class CardViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var indexCountLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var subCollectionView: UICollectionView!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!

    //MARK: Variables
    let layout = UICollectionViewFlowLayout()
    var player: AVAudioPlayer?
    var cards: [Card]?
    var level: Level?
    var delegate: CardViewControllerDelegate?
    var flippedArray = [IndexPath]()
    var currentIndex: IndexPath? = IndexPath(item: 0, section: 0){
        didSet{
            updateIndexLabel()
            self.subCollectionView.reloadData()
        }
    }

    var currentDevice = UIDevice.current.userInterfaceIdiom == .phone ? "iphone" : "ipad"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataSetUp()
        buttonSetUp()
        setUpNavigationBar()
        self.mainCollectionView.reloadData()
    }
    
    //MARK: Functions
    //CollectionView setup
    private func collectionViewSetUp(){
        mainCollectionView.register( UINib(nibName: "MainCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCardCollectionViewCell")
        subCollectionView.register( UINib(nibName: "SubCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCollectionViewCell")
       
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.mainCollectionView.collectionViewLayout = layout
       // self.subCollectionView.collectionViewLayout = layout
    }
    
    private func buttonSetUp(){
        guard let levelDetails = level else { return }
        self.flipButton.setImage(UIImage(named: levelDetails.flipButtonDrawable ?? ""), for: .normal)
        self.flipButton.setImage(UIImage(named: levelDetails.flipButtonPressedDrawable ?? ""), for: .highlighted)
        self.soundButton.setImage(UIImage(named: levelDetails.playButtonDrawable ?? ""), for: .normal)
        self.soundButton.setImage(UIImage(named: levelDetails.playButtonPressedDrawable ?? ""), for: .highlighted)
        let currentLevel: Int = levelDetails.number ?? 0
        if currentLevel < appData?.levels?.count ?? 0{
            self.setRightBarButton(title: "Level \( currentLevel + 1)")
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
        self.setLeftBarButton()
    }
    
    func setRightBarButton(title: String){
        let button = UIButton(type: .custom)
        button.setTitle(" \(title)", for: .normal)
    //
        button.titleLabel?.font = UIFont(name: CustomFont.futuraStdMedium.rawValue, size:   currentDevice == "iphone" ? 15 : 25)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "arrow_right"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: currentDevice == "iphone" ? 40 : 65, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left:  currentDevice == "iphone" ? -45 : -65, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(nextLevelAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func dataSetUp(){
        guard let levelDetails = level else { return }
        self.flipButton.isHidden = !(levelDetails.flippable ?? false)
        self.levelTitleLabel.text = levelDetails.title?.uppercased()
        self.levelTitleLabel.textColor = UIColor(hexFromString: levelDetails.color ?? "")
        self.levelTitleLabel.font = UIFont.setAppFont(fontName: .futuraStdCondensedBold, fontSize: .size36)
        self.indexCountLabel.font = UIFont.setAppFont(fontName: .gardenHouseRom, fontSize: .size30)
        updateIndexLabel()
    }
    
    func setUpNavigationBar(){
        //Title
        let navController = navigationController!
        let image = UIImage(named: "logo_levels") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth * 0.5, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func setLeftBarButton(){
        let button = UIButton(type: .custom)
        button.setTitle("Menu", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.futuraStdMedium.rawValue, size: currentDevice == "iphone" ? 15 : 25)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func flip(index: Int){
        guard let levelDetails = level else { return }
        if levelDetails.flippable ?? false == false{
            return
        }
        let indexPath = IndexPath(item: index, section: 0)
        guard let cell = mainCollectionView.cellForItem(at: indexPath) as? MainCardCollectionViewCell else { return }
        if flippedArray.contains(indexPath){
            if let index = flippedArray.firstIndex(of: indexPath){
                flippedArray.remove(at: index)
            }
        }else{
            flippedArray.append(indexPath)
        }
        cell.flipAnimation()
    }
    
    func updateIndexLabel(){
        let cardCount = cards?.count ?? 0
        let index = currentIndex?.item ?? 0
        self.indexCountLabel.text = "\(index+1)/\(cardCount)"
    }
    
    
    func getCurrentIndex() -> Int{
        let visibleRect = CGRect(origin: mainCollectionView.contentOffset, size: mainCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return mainCollectionView.indexPathForItem(at: visiblePoint)?.item ?? 0
    }
    
    func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Actions
    
    @objc func nextLevelAction(){
        self.navigationController?.popViewController(animated: true)
        self.delegate?.levelButtonTapped()
    }
    
    @objc func menuButtonAction(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func flipButtonAction(_ sender: UIButton){
        self.flip(index: currentIndex?.item ?? 0)
    }

    @IBAction func soundButtonAction(_ sender: UIButton){
        let currentIndexPath = IndexPath(item: currentIndex?.item ?? 0, section: 0)
        let isFlipped = flippedArray.contains(currentIndexPath)
        if let fileName = isFlipped ? cards?[currentIndex?.item ?? 0].backSound : cards?[currentIndex?.item ?? 0].frontSound{
            self.playSound(fileName: fileName)
        }
    }
}
//MARK: Extensions
extension CardViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.mainCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCardCollectionViewCell", for: indexPath) as! MainCardCollectionViewCell
            cell.levelDetials = cards?[indexPath.row]
            cell.isFlip = flippedArray.contains(indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCollectionViewCell", for: indexPath) as! SubCollectionViewCell
            cell.selectedColor = UIColor(hexFromString: self.level?.color ?? "")
            cell.text = cards?[indexPath.row].name
            cell.cellSelected = indexPath == currentIndex
            return cell
        }
    }
}

extension CardViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.mainCollectionView{
            self.flip(index: indexPath.row)
        }else{
            currentIndex = indexPath
            self.mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.subCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.mainCollectionView.reloadData()
        }
    }
}

extension CardViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView, collectionView == mainCollectionView{
            self.currentIndex = IndexPath(item: getCurrentIndex(), section: 0)
            self.subCollectionView.scrollToItem(at: currentIndex ?? IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension CardViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mainCollectionView{
            return mainCollectionView.frame.size
        }else{
            return CGSize(width: subCollectionView.frame.size.height, height: subCollectionView.frame.size.height)
        }
    }
}
