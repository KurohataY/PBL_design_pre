import UIKit

class PopupViewController: UIViewController {

    //ラベル
    @IBOutlet weak var playerNum: UITextView!
    
    //プレイヤーの背番号を取得
    var num = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerNum.text = "背番号：\(num)\n身長：\n特徴：・・・・・"
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

        
    }
    
    

}
