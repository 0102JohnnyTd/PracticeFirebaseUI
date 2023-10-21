//
//  ViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/06.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseOAuthUI
import FirebaseGoogleAuthUI



final class ViewController: UIViewController {

    @IBAction func didTapAuthVCButton(_ sender: Any) {
        showAuthVC()
    }
    private let authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func showAuthVC() {
        let authVC = createAuthVC()
        present(authVC, animated: true)
    }

    private func createAuthVC() -> UINavigationController {
        guard let authUI = authUI else { fatalError("AuthUI Error") }
        let authVC = authUI.authViewController()

        setUpAuthVC(authVC: authVC)
        return authVC
    }

    private func setUpAuthVC(authVC: UINavigationController) {
        // フルスクリーンモーダル遷移を設定
        authVC.modalPresentationStyle = .fullScreen
        // NavigationBarを非表示を設定
//        authVC.navigationBar.isHidden = true
    }
}

extension ViewController: FUIAuthDelegate {
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        CustomAuthPickerViewController(authUI: authUI)
    }
}
