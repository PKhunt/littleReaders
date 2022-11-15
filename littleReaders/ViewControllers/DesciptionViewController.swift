//
//  DesciptionViewController.swift
//  littleReaders
//
//  Created by mymac on 28/10/22.
//

import UIKit

class DesciptionViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UITextView!
    @IBOutlet weak var startButton: UIButton!

    var currentDevice = UIDevice.current.userInterfaceIdiom == .phone ? "iphone" : "ipad"
    
    //MARK: Variables
    var levelDetails: Level?
   

    //MARK: View controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setUpNavigationBar()
        uiAndTextSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        //UI-SetUp
        self.startButton.round()
        self.startButton.titleLabel?.font = UIFont.setAppFont(fontName: .futuraStdCondensedBold, fontSize: .size26)
    }
    
    
    //MARK: Functions
    func uiAndTextSetup(){
        self.levelLabel.font = UIFont.setAppFont(fontName: .futuraStdCondensedBold, fontSize: .size36)
        self.titleNameLabel.font = UIFont.setAppFont(fontName: .gardenHouseRom, fontSize: .size34)
        guard let details = levelDetails else { return }
        self.levelLabel.text = details.title?.uppercased()
        self.levelLabel.textColor = UIColor(hexFromString: details.color ?? "")
        self.titleNameLabel.text = details.subtitle?.uppercased()
        self.startButton.backgroundColor = UIColor(hexFromString: details.color ?? "")
        self.detailDescriptionLabel.text = details.detailDescription()
        self.detailDescriptionLabel.font = UIFont.setAppFont(fontName: .futuraStdMedium, fontSize: .size20)
        
        let currentLevel: Int = details.number ?? 0
        //TODO: Uncomment after upload
        if currentLevel < appData?.levels?.count ?? 0{
            self.setRightBarButton(title: "Level \( currentLevel + 1)")
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
        self.setLeftBarButton()
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
    
    func setRightBarButton(title: String){
        let button = UIButton(type: .custom)
        button.setTitle(" \(title)", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.futuraStdMedium.rawValue, size: currentDevice == "iphone" ? 15 : 25)
        
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "arrow_right"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: currentDevice == "iphone" ? 40 : 65, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: currentDevice == "iphone" ? -45 : -65, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(nextLevelAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
    
    //MARK: Actions
    @IBAction func startButtonAction(_ sender: UIButton){
        let cardViewController = self.storyboard?.instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
        cardViewController.cards = levelDetails?.cards
        cardViewController.level = levelDetails
        cardViewController.delegate = self
        self.navigationController?.pushViewController(cardViewController, animated: true)
    }
    
    @objc func nextLevelAction(){
        guard let currentLevel = levelDetails else {return}
        if let currentLevelIndex = appData?.levels?.firstIndex(where: {$0.number ?? 0 == currentLevel.number ?? 0}) {
            let newLevel = appData?.levels?[currentLevelIndex+1]
            self.levelDetails = newLevel
            self.viewWillAppear(true)
        }
    }
    
    @objc func menuButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }

}

extension DesciptionViewController: CardViewControllerDelegate{
    func levelButtonTapped() {
        self.nextLevelAction()
    }
    
    
}
