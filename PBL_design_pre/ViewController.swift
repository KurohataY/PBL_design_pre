//
//  ViewController.swift
//  PBL_design_pre
//
//  Created by KurohataY on 2019/12/11.
//  Copyright © 2019 KurohataY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //左方チームメンバー
    @IBOutlet weak var left0: UIButton!
    @IBOutlet weak var left1: UIButton!
    @IBOutlet weak var left2: UIButton!
    @IBOutlet weak var left3: UIButton!
    @IBOutlet weak var left4: UIButton!
    @IBOutlet weak var left5: UIButton!
    //右方チームメンバー
    @IBOutlet weak var right6: UIButton!
    @IBOutlet weak var right7: UIButton!
    @IBOutlet weak var right8: UIButton!
    @IBOutlet weak var right9: UIButton!
    @IBOutlet weak var right10: UIButton!
    @IBOutlet weak var right11: UIButton!
    
    //両チーム背番号
    var leftnumbers = [1, 2, 3, 4, 5, 10]
    var rightnumbers = [12, 4, 2, 1, 9, 11]
    
    //ボタン配列(lazyつけないとエラー発生)
    lazy var leftbuttons: [UIButton] = [left0,left1,left2,left3,left4,left5]
    lazy var rightbuttons: [UIButton] = [right6,right7,right8,right9,right10,right11]
    
    @IBOutlet weak var score: UILabel!
    
    var scoretext = "0 VS 0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //カウント用
        var i = 0
        //ナビゲーションバーのタイトル
        self.navigationItem.title = "審判代行システム"
        //ナビゲーションバーのアイテムの色
        self.navigationController?.navigationBar.tintColor = .white
        //ナビバーの背景色(黒)
        self.navigationController?.navigationBar.barTintColor = .brown
        //ナビバーの半透明化
        self.navigationController?.navigationBar.isTranslucent = true
        //ナビバーのテキストの色
        self.navigationController?.navigationBar.titleTextAttributes = [
        // ナビバーの文字の色
            .foregroundColor: UIColor.white
        ]
        
        //ボタンに選手背番号の挿入
        for value in leftnumbers {
            let number = String(format: "%01d",value)
            leftbuttons[i].setTitle(number, for: .normal) // ボタンのタイトル
            i += 1
            if (i == 6){
                i = 0
            }
        }
        //ボタンに選手背番号の挿入
        for value in rightnumbers {
            let number = String(format: "%01d",value)
            rightbuttons[i].setTitle(number, for: .normal) // ボタンのタイトル
            i += 1
        }
        
        //初期スコアの代入
        score.text = scoretext
        
    }


}

