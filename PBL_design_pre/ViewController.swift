//
//  ViewController.swift
//  PBL_design_pre
//
//  Created by KurohataY on 2019/12/11.
//  Copyright © 2019 KurohataY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //変数
    var leftScore = 0
    var rightScore = 0
    var resultPlayData = ""
//
//    let playData:[String] = [
//        "アウト",
//        "ワンタッチ",
//        "コートイン",
//        "ネットタッチ"
//    ]
    
    //API取得構造体（json）
    struct JsonData: Codable {
        let data: String
    }
    
    //テーブルビューラベル
    @IBOutlet weak var detailsScore: UITableView!
    //点数ラベル
    @IBOutlet var ResultScore: UILabel!
    
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
    
    //スコア表示
    @IBOutlet weak var score: UILabel!
    
    //ローテーションが必要か判別するためのフラッグ
    var rotationLeft = 0
    var rotationright = 1
    //スコアの初期化（サーバーから習得？）
    var scoretext = "0 VS 0"
    
//    // インスタンス変数（FireBase関連）
//    var DBRef:DatabaseReference!
    
    //タイマーメソッド
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                //APIの値を取得
        self.get()
//        self.add()
        
        //FireBase関連
        //インスタンスを作成
//        DBRef = Database.database().reference()
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
            leftbuttons[i].layer.cornerRadius = 5.0
            leftbuttons[i].titleLabel?.baselineAdjustment = .alignCenters
            //ボタンタグを背番号に変更
            leftbuttons[i].tag = value
            i += 1
            if (i == 6){
                i = 0
            }
        }
        //ボタンに選手背番号の挿入
        for value in rightnumbers {
            let number = String(format: "%01d",value)
            rightbuttons[i].setTitle(number, for: .normal) // ボタンのタイトル
            rightbuttons[i].layer.cornerRadius = 5.0
            rightbuttons[i].titleLabel?.baselineAdjustment = .alignCenters
            //ボタンタグを背番号に変更
            rightbuttons[i].tag = value
            i += 1
            if (i == 6){
                i = 0
            }
        }
        
        //初期スコアの代入
        score.text = scoretext
        
        self.ResultScore.text = "\(leftScore) VS \(rightScore)";
        

        
    }
    
    //FioreBase
//    func add() {
//        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { (timer) in
//            let defaultPlace = self.DBRef.child("data")
//            defaultPlace.observe(.value) { (snap: DataSnapshot) in self.resultPlayData = (snap.value! as AnyObject).description
//            }
//
//            //ランダムなチームにた得点を入れる
//            let number = Int.random(in: 1 ... 2)
//
//            if number == 1{
//                self.leftScoreAdd()
//            }else if number == 2{
//                self.rightScoreAdd()
//            }else{
//                print("エラー")
//            }
//        })
//        
//    }
    
    
    // ポップアップを表示がタップされた時
    @IBAction func onTapShowPopup(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let button = sender
        
        let btnNumber = button.tag

        let popupView: PopupViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! PopupViewController
        popupView.modalPresentationStyle = .overFullScreen
        popupView.modalTransitionStyle = .crossDissolve
        popupView.num = String(format: "%01d",btnNumber)

        self.present(popupView, animated: false, completion: nil)
    }
    
    //左の得点に１点加える
    func leftScoreAdd(){
        leftScore += 1
        if rotationright == 0{
            rotationLeft = 1
        }else{
            rotationLeft = 1
            rotationright = 0
            changeRotationLeft()
        }
        
        self.displayScore()
        self.resultPlayDataText()
        left2.backgroundColor = .white
        right11.backgroundColor = .none
    }

    //右の得点に１点加える
    func rightScoreAdd(){
        rightScore += 1
        if rotationLeft == 0{
            rotationright = 1
        }else{
            rotationright = 1
            rotationLeft = 0
            changeRotationRight()
        }
        self.displayScore()
        self.resultPlayDataText()
        right11.backgroundColor = .white
        left2.backgroundColor = .none
    }
    

    //得点を更新する
    func displayScore(){
        self.ResultScore.text = "\(leftScore) VS \(rightScore)";
    }

    //左チームのローテーション
    
    func changeRotationLeft(){
        var count = 0
        while count < 5 {
            for n in 0 ... 4{
                leftnumbers.swapAt(n, 5)
            }
            count += 1
        }
        var i = 0
        for value in leftnumbers {
            let number = String(format: "%01d",value)
            leftbuttons[i].setTitle(number, for: .normal) // ボタンのタイトル
            leftbuttons[i].layer.cornerRadius = 5.0
            leftbuttons[i].titleLabel?.baselineAdjustment = .alignCenters
            //ボタンタグを背番号に変更
            leftbuttons[i].tag = value
            i += 1
            if (i == 6){
                i = 0
            }
        }
    }
    
    //右チームのローテーション
    func changeRotationRight(){
        var count = 0
        while count < 5 {
            for n in 0 ... 4{
                rightnumbers.swapAt(n, 5)
            }
            count += 1
        }
        var i = 0
        //ボタンに選手背番号の挿入
        for value in rightnumbers {
            let number = String(format: "%01d",value)
            rightbuttons[i].setTitle(number, for: .normal) // ボタンのタイトル
            rightbuttons[i].layer.cornerRadius = 5.0
            rightbuttons[i].titleLabel?.baselineAdjustment = .alignCenters
            //ボタンタグを背番号に変更
            rightbuttons[i].tag = value
            i += 1
            if (i == 6){
                i = 0
            }
        }
    }

    //テーブルビューの設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = resultPlayData
        
        return cell
    }
    
    //ジャッジ内容をランダムでテーブルビューに表示
    func resultPlayDataText(){
//        resultPlayData = playData[Int.random(in: 0 ... playData.count - 1)]
        detailsScore.reloadData()
    }
    

    
//    //APIの内容の取得
    func get(){
        //一定時間ごとに処理の実行
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { (timer) in
            let jsonUrlString = "http://127.0.0.1:5000/api"
            guard let url = URL(string: jsonUrlString) else {return}

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}

                do{
                    let json = try JSONDecoder().decode(JsonData.self, from: data)
                    print(json.data)
                    if json.data == "change"{
                        self.change()
                        self.resultPlayData = json.data
                    }else{
                        self.resultPlayData = json.data
                    }
                } catch let jsonError{
                    print("error", jsonError)
                }
            }.resume()
            var number = 0
            //ランダムなチームにた得点を入れる
            if self.resultPlayData != ""{
                number = Int.random(in: 1 ... 2)
            }
            if number == 0{
                return
            }else if number == 1{
                self.leftScoreAdd()
            }else if number == 2{
                self.rightScoreAdd()
            }else{
                print("エラー")
            }
        })
    }
    
//    //交代メソッド
    func change(){
        let changeNumberIndex = Int.random(in: 0 ... 5)
        leftbuttons[changeNumberIndex].tag = Int.random(in: 1 ... 12)
    }
}

