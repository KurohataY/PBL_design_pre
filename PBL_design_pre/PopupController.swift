//
//  PopupController.swift
//  PBL_design_pre
//
//  Created by KurohataY on 2019/12/11.
//  Copyright © 2019 KurohataY. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    //ラベル
    @IBOutlet weak var playerNum: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 閉じるボタンがタップされた時
    @IBAction func onTapCancel(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    // ポップアップの外側をタップした時にポップアップを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        var tapLocation: CGPoint = CGPoint()
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)

        let popUpView: UIView = self.view.viewWithTag(100)! as UIView

        if !popUpView.frame.contains(tapLocation) {
            self.dismiss(animated: false, completion: nil)
        }
    }

}
