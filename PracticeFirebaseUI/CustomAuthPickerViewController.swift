//
//  CustomAuthPickerViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/13.
//

import Foundation
import FirebaseAuthUI

final class CustomAuthPickerViewController: FUIAuthPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        authUI.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }

    private func configureButtons() {
        guard let buttons = self.view.subviews.first?.subviews.first?.subviews.first?.subviews else { return }
        let titles = ["Googleでログイン", "Appleでログイン"]

        for (index, _) in zip(titles.indices, titles) {
            if let button = buttons[index] as? UIButton {
                button.setTitle(titles[index], for: .normal)
                button.layer.cornerRadius = 20.0
                button.layer.masksToBounds = true
            }
        }
    }

    private func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CustomAuthPickerViewController: FUIAuthDelegate {
    // サインイン・サインアップ完了後に実行する処理
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let result = user {
            // ログイン成功処理
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController

            homeVC.modalTransitionStyle = .crossDissolve
            homeVC.modalPresentationStyle = .fullScreen

            present(homeVC, animated: true)
        } else {
            // ログイン失敗処理
            print("LoginFailure")
        }
    }
}
