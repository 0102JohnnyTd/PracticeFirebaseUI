//
//  UIView+.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/30.
//

import Foundation
import UIKit

extension UIView {
    func descendant<T: UIView>( _ type: T.Type = T.self) -> [T] {
        switch self {
        // 引数として入力した値に該当するsubViewを持っていた場合に実行される？
        case let me as T:
            return [me]
        // 引数として入力した値に該当するsubViewを持っていなかった場合に実行される？
        case _:
            // 無限ループ?
            return subviews.flatMap { $0.descendant() }
        }
    }
}
