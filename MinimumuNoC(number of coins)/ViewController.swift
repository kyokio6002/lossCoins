//
//  ViewController.swift
//  MinimumuNoC(number of coins)
//
//  Created by 塩澤響 on 2020/02/03.
//  Copyright © 2020 塩澤響. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //フォーマットをインスタンス化
    let formatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //3桁ごとにカンマを打つ
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
    }
    
    //////////////////////////////////////////////
    @IBAction func goSetting(_ sender: Any) {
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    ////////////////////////////////////////////
    func addCamma(str:String)->String{
        if str != ""{
            return formatter.string(from: NSNumber(value: Int(str)!))!
        }else{
            return ""
        }
    }
    //////////////////////////////////////////////
    
    @IBOutlet weak var totalFee: UILabel!
    var num:String = "0"
    var Balance = 0
    
    @IBAction func pushedNumButton(_ sender: UIButton) {
        guard let senderdNum = sender.titleLabel?.text else {
            return
        }
        if num == "0" {
            num = senderdNum
        }else{
            num = num + senderdNum
        }
        totalFee.text = addCamma(str: num)
    }
    
    @IBAction func clearButtonPushed(_ sender: UIButton) {
        num = "0"
        totalFee.text = num
    }
    
    /////////////////////////////////////////////////
    
    func lessCoins( _ balanceArray:[Int],_ sumCash:Int){
        var balanceArray:[Int] = balanceArray
        var sumCash:Int = sumCash
        var sumBalance:Int = self.sum(balanceArray)
        var maxOrderSum:Int = String(sumCash).count
        var pay:[Int] = [0,0,0,0,0,0,0,0,0,0]
        
        //一のくらいを比較
        //所持金の一円玉の方が多い場合
        if balanceArray[9] >= sumCash%10{
            pay[9] = sumCash % 10
        }else if balanceArray[9] < sumCash%10{
            
        }
        
        //最大桁の支払いを済ませて残金を更新する
        //最大桁が1万以上、1万円未満千円以上,千円未満百円以上、百円未満十円以上、十円未満で場合わけ
        if maxOrderSum >= 5{
            //会計金額の1万の位(10以上もあり)
            var num10000:Int = sum / 10000
            //会計金額の1万のくらいがて所持金の1万くらい以上あるかどうか？
            if balanceArray[0] >= num10000{
                //所持金,合計金額の更新
                balanceArray[0] -= num10000
                sum -= num10000
                //また関数に入る
                lessCoins(balanceArray, sum)
            }
            //一万円札のみで会計の1万の位を清算できない場合
            else if balanceArray[0] <= num10000{
                //所持金のみで会計の1万の位の会計ができるかどうか
                let sumOver1000:Int = balanceArray[0]*10000+balanceArray[1]*5000+balanceArray[2]*2000+balanceArray[3]*1000
                if sumOver1000 >= num10000{
                    print("紙幣を組み合わせて1万の位の生産を済ませてください")
                    alert出して出す紙幣の数を入力してもらう→所持金の更新
                }else if sumOver1000 < num10000 {
                    alertでしたのやつ表示
                    print("硬貨を使ってまで1万円の清算はしたくない")
                }
            }
            
        }else if (maxOrderSum < 5 && maxOrderSum >= 4){
            //会計金額の千位
            let num1000:Int = sum / 1000
            //所持金、合計金学の更新
            balanceArray[1] -= num1000
        }else if (maxOrderSum < 4 && maxOrderSum >= 3){
            
        }else if (maxOrderSum < 3 && maxOrderSum >= 2){
            
        }else if (maxOrderSum < 2 ){
            
        }else{
            print("error")
        }
        
    }
    
    
    /////////////////////////////////////////////////
    
    func sum(_ x:[Int])->Int{
        var sum = 0
        sum = x[0]*10000+x[1]*5000+x[2]*2000+x[3]*1000+x[4]*500+x[5]*100+x[6]*50+x[7]*10+x[8]*5+x[9]*1
        return sum
    }
    
    @IBAction func enterButtonPushed(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if let BalanceArray:[Int] = userDefaults.array(forKey: "BalanceKey") as? [Int]{
            self.Balance = self.sum(BalanceArray)
        }
        
        //残金より会計金額が多かった場合
        if self.Balance <= (Int(num)!){
            let alert = UIAlertController(title: "残金が不足しています", message: "会計金額が残金を超えています", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert,animated: true,completion: nil)
            print("Balance:\(Balance),num:\(Int(num)!)")
        }
        //会計金額より残金が多かった場合
        else if self.Balance >= Int(num)!{
            
        }
        
    }
    
}

