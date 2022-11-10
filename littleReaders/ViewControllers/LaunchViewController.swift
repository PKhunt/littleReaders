//
//  LaunchViewController.swift
//  littleReaders
//
//  Created by mymac on 21/10/22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var startButton: UIButton!

    //MARK: View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        //UI-SetUp
        self.startButton.round()
        self.startButton.titleLabel?.font = UIFont.setAppFont(fontName: .futuraStdCondensedBold, fontSize: .size26)
    }
    
    //MARK: Actions
    @IBAction func startButtonAction(_ sender: UIButton){
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.push(viewController: homeViewController, transitionType: .fade ,duration: 1.0)
    }

  

}

