//
//  ViewController.swift
//  TAYSEER
//
//  Created by HTS Macbook Air on 07/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loginButton : UIButton!
    @IBOutlet var signupButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello")
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        signupButton.layer.cornerRadius = 20
        signupButton.layer.masksToBounds = true
    }

    
    //MARK:- UIButton Actioons
    @IBAction func onTapCheckRate(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SendingFromVC") as! SendingFromVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


