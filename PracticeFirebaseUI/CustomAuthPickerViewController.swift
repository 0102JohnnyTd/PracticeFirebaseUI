//
//  CustomAuthPickerViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/13.
//

import Foundation
import FirebaseAuthUI

final class CustomAuthPickerViewController: FUIAuthPickerViewController {
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var titleLabel =  {
        let label = UILabel()
        label.text = "🍅ようこそ🍅"
        label.font = UIFont(name: "Hiragino Sans", size: 40)
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SignInIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var descriptionLabel =  {
        let label = UILabel()
        label.text = "ログイン&アカウント作成"
        label.font = UIFont(name: "Hiragino Sans", size: 16)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("hogehoge")
        guard let buttons = self.view.subviews.first?.subviews.first?.subviews.first?.subviews else { return }
        if let googleButton = buttons[0] as? UIButton {
//            // アイコンにアクセスするコード
//            print(googleButton.subviews)
//            // ラベルにアクセスするコード
//            print(googleButton.titleLabel)
        }
        configureStackView()
        configureButtons()
        authUI.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }

    /// ラベルを生成して画面中央に配置
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        // 😼この一行で全てのAutoLayoutに.isActive = trueを一括で指定できる
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
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

        guard let googleButton = buttons[0] as? UIButton else { return }
        let googleIcon = googleButton.subviews[0]
        let googleLabel = googleButton.subviews[1]
        googleIcon.translatesAutoresizingMaskIntoConstraints = false
        // 😨Labelの.translatesAutoresizingMaskIntoConstraintsにfalseを代入した時点で『Unable to simultaneously satisfy constraints.』が発生するようになる。
//        googleLabel.translatesAutoresizingMaskIntoConstraints = false

        guard let appleButton = buttons[1] as? UIButton else{ return }
        let appleIcon = appleButton.subviews[0]
        let appleLabel = appleButton.subviews[1]
        appleIcon.translatesAutoresizingMaskIntoConstraints = false
        // 😨Labelの.translatesAutoresizingMaskIntoConstraintsにfalseを代入した時点で『Unable to simultaneously satisfy constraints.』が発生するようになる。
//        appleLabel.translatesAutoresizingMaskIntoConstraints = false

        // AutoLayoutを実装
        NSLayoutConstraint.activate([
            googleIcon.centerYAnchor.constraint(equalTo: googleButton.centerYAnchor),
            googleIcon.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor, constant: 40),
//            googleLabel.centerYAnchor.constraint(equalTo: googleButton.centerYAnchor),
//            googleLabel.leadingAnchor.constraint(equalTo: googleIcon.trailingAnchor),

            appleIcon.centerYAnchor.constraint(equalTo: appleButton.centerYAnchor),
            appleIcon.leadingAnchor.constraint(equalTo: appleButton.leadingAnchor, constant: 40),
//            appleLabel.centerYAnchor.constraint(equalTo: appleButton.centerYAnchor),
//            appleLabel.leadingAnchor.constraint(equalTo: appleIcon.trailingAnchor)
        ])
    }

    private func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CustomAuthPickerViewController: FUIAuthDelegate {
    // サインイン・サインアップ完了後に実行する処理
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let _ = user {
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
