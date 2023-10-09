//
//  ViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/06.
//

import UIKit
import FirebaseOAuthUI
import FirebaseGoogleAuthUI



final class ViewController: UIViewController, FUIAuthDelegate {

    @IBAction func didTapAuthVCButton(_ sender: Any) {
        showAuthVC()
    }
    private var authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpFirebaseUI()
    }

    private func setUpFirebaseUI() {
        guard let authUI = authUI else { fatalError("AuthUI Error") }
        authUI.delegate = self
        authUI.providers = [
            FUIGoogleAuth(authUI: authUI),
            FUIOAuth.twitterAuthProvider(),
            FUIOAuth.appleAuthProvider()
        ]
    }

    private func showAuthVC() {
        guard let authUI = authUI else { fatalError("AuthUI Error") }
        let authVC = authUI.authViewController()
        present(authVC, animated: true)
    }

}
