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
        do {
            try Auth.auth().signOut()
            showDidLogoutAlertController()
        } catch {
            print("サインアウトに失敗しますた")
        }
    }

    private let authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()
        authUI?.delegate = self
    }

    private func showAuthVC() {
        let authVC = createAuthVC()
        present(authVC, animated: true)
    }

    private func showDidLogoutAlertController() {
        let alertController = UIAlertController(title: "ログアウト完了", message: "また遊びにきてな", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            guard let authVC = self?.createAuthVC() else { return }
            self?.present(authVC, animated: true)
        }))
        present(alertController, animated: true)
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
        // 画面がパッと切り替わるアニメーションの実装
        authVC.modalTransitionStyle = .crossDissolve
    }
}

extension ViewController: FUIAuthDelegate {
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        CustomAuthPickerViewController(authUI: authUI)
    }
}
