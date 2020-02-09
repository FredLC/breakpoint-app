//
//  AuthVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-10-26.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import GoogleSignIn

class AuthVC: UIViewController {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
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
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile, .userFriends],
            viewController: self
        ) { result in
            let accessToken = AccessToken.current
            guard let accessTokenString = accessToken?.tokenString else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("Could not sign in facebook user", error)
                    return
                }
                guard let uid = user?.user.uid else { return }
                guard let userEmail = user?.user.email else { return }
                DataService.instance.createDBUser(uid: uid, userData: ["email": userEmail])
                print("Successfully signed in facebook user", user)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func signInWithGooglePressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        dismiss(animated: true, completion: nil)
    }
    
}
