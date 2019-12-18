//
//  AuthVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-10-26.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func signInWithFBPressed(_ sender: Any) {
    }
    
    @IBAction func signInWithGooglePressed(_ sender: Any) {
    }
    
}
