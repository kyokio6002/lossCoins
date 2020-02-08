//
//  BalanceViewController.swift
//  MinimumuNoC(number of coins)
//
//  Created by 塩澤響 on 2020/02/05.
//  Copyright © 2020 塩澤響. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    
    //所持金額を右詰めに
    //会計金額を入力する画面にていちいちtextFieldをタップしてキーボードを表示するのは時間がかかるからあらかじめUIBottunを設置してEnterボタンを押して表示するようにする
    //iPhone11以外の機種にも対応させる
    
    let formatter = NumberFormatter()
    var clearButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BalanceLabel.textColor = UIColor.white
        
        //3桁ごとにカンマを打つ
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        //二回層目(2ndView)以降はstoryBordでボタンが追加できないからコードを書いて追加する(https://capibara1969.com/1391/)
        clearButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = clearButton
        self.navigationItem.title = "残金設定"
        
        //Userdefaultsをインスタンス化
        let userdefaults = UserDefaults.standard
        //値の取り出し
        if let BalanceArrayUD:[Int] = userdefaults.array(forKey: "BalanceKey") as? [Int]{
            BalanceArray = BalanceArrayUD
            updateText()
            print(BalanceArray,BalanceArrayUD)
        }
    }
    
    var BalanceArray:[Int] = [0,0,0,0,0,0,0,0,0,0]
    //[10000,5000,2000,1000,500,100,50,10,5,1]
    
    
    @IBOutlet weak var BalanceLabel: UILabel!
    @IBOutlet weak var YenLabel: UILabel!
    
    
    @IBOutlet weak var count10000: UILabel!
    @IBOutlet weak var count5000: UILabel!
    @IBOutlet weak var count1000: UILabel!
    @IBOutlet weak var count2000: UILabel!
    @IBOutlet weak var count500: UILabel!
    @IBOutlet weak var count100: UILabel!
    @IBOutlet weak var count50: UILabel!
    @IBOutlet weak var count10: UILabel!
    @IBOutlet weak var count5: UILabel!
    @IBOutlet weak var count1: UILabel!
    

    
    
    ////////////////////////////////////////////////////////////////
    
    
    func sum(_ x:[Int]) -> String{
        var Num = 0
        Num = x[0]*10000+x[1]*5000+x[2]*2000+x[3]*1000+x[4]*500+x[5]*100+x[6]*50+x[7]*10+x[8]*5+x[9]*1
        return addCamma(str: String(Num))
    }
    
    //カンマをつける関数
    func addCamma(str:String)->String{
        if str != ""{
            return formatter.string(from: NSNumber(value: Int(str)!))!
        }else{
            return ""
        }
    }
    
    ///////////////////////////////////////////////////////////////
    
    @objc func clearButtonTapped(_ sender:UIBarButtonItem){
        let alert = UIAlertController(title: "紙幣・硬貨をクリアしますか？", message: "設定した紙幣・硬貨を全て0にしますか？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            self.BalanceArray = [0,0,0,0,0,0,0,0,0,0]
            self.updateText()
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert,animated: true,completion: nil)
    }
    
    //////////////////////////////////////////////////////////////
    
    func updateText(){
     
        count10000.text = String(BalanceArray[0])
        count5000.text = String(BalanceArray[1])
        count2000.text = String(BalanceArray[2])
        count1000.text = String(BalanceArray[3])
        count500.text = String(BalanceArray[4])
        count100.text = String(BalanceArray[5])
        count50.text = String(BalanceArray[6])
        count10.text = String(BalanceArray[7])
        count5.text = String(BalanceArray[8])
        count1.text = String(BalanceArray[9])
        
        BalanceLabel.text = String(sum(BalanceArray))
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(BalanceArray,forKey: "BalanceKey")
        userDefaults.synchronize()
    }
    
    
    
    /////////////////////////////////////////////////////////////
    
    
    @IBAction func pushUpBottun(_ sender: UIButton) {
        switch sender.tag{
        case 10000:
            BalanceArray[0] += 1
        case 5000:
            BalanceArray[1] += 1
        case 2000:
            BalanceArray[2] += 1
        case 1000:
            BalanceArray[3] += 1
        case 500:
            BalanceArray[4] += 1
        case 100:
            BalanceArray[5] += 1
        case 50:
            BalanceArray[6] += 1
        case 10:
            BalanceArray[7] += 1
        case 5:
            BalanceArray[8] += 1
        case 1:
            BalanceArray[9] += 1
        default:
            print("エラー")
        }
        updateText()
    }
    
    @IBAction func pushDownButton(_ sender: UIButton) {
        switch sender.tag {
        case 10000:
            if BalanceArray[0] - 1 >= 0{
                BalanceArray[0] -= 1
            }else{
            }
        case 5000:
            if BalanceArray[1] - 1 >= 0{
                BalanceArray[1] -= 1
            }else{
            }
        case 2000:
            if BalanceArray[2] - 1 >= 0{
                BalanceArray[2] -= 1
            }else{
            }
        case 1000:
            if BalanceArray[3] - 1 >= 0{
                BalanceArray[3] -= 1
            }else{
            }
        case 500:
            if BalanceArray[4] - 1 >= 0{
                BalanceArray[4] -= 1
            }else{
            }
        case 100:
            if BalanceArray[5] - 1 >= 0{
                BalanceArray[5] -= 1
            }else{
            }
        case 50:
            if BalanceArray[6] - 1 >= 0{
                BalanceArray[6] -= 1
            }else{
            }
        case 10:
            if BalanceArray[7] - 1 >= 0{
                BalanceArray[7] -= 1
            }else{
            }
        case 5:
            if BalanceArray[8] - 1 >= 0{
                BalanceArray[8] -= 1
            }else{
            }
        case 1:
            if BalanceArray[9] - 1 >= 0{
                BalanceArray[9] -= 1
            }else{
            }
        default:
            print("エラー")
        }
        updateText()
    }
    
    
}
