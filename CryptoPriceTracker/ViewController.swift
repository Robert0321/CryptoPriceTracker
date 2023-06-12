//
//  ViewController.swift
//  CryptoPriceTracker
//
//  Created by LI,JYUN-SIAN on 12/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btcPrice: UILabel!
    @IBOutlet weak var ethPrice: UILabel!
    @IBOutlet weak var audPrice: UILabel!
    @IBOutlet weak var usdPrice: UILabel!
    @IBOutlet weak var lastUpdatedPrice: UILabel!
    
    // 產生網址
    let urlString = "https://api.coingecko.com/api/v3/exchange_rates"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchData()
        
        let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    // 刷新數據
    @objc func refreshData() -> Void {
        
        fetchData()
    }// 刷新後返回void代表沒有值
    
    // 獲得數據
    func fetchData() {
        
        let url = URL(string: urlString)// 轉換成URL
        let defaultSession = URLSession(configuration: .default)//發送接收網路資料
        let dataTask = defaultSession.dataTask(with: url!) { (data: Data?, response: URLResponse?,error: Error?) in
            
            if (error != nil) {
                print(error)
                return
            }
            
            do {
                
                let json = try JSONDecoder().decode(Rates.self, from: data!)
                self.setPrices(currency: json.rates)// 讓控制器讀現在價格
                
            }
            catch {
                
                print(error)
                return
                
            }
            
        }//讓我數據任務收到網路資料，請求URL內容
        
        dataTask.resume()//如果運作不正常，讓dataTask重新啟動
    }
    
    //價格改變
    func setPrices(currency: Currency) {
        
        DispatchQueue.main.async {
            
            self.btcPrice.text = self.formatPrice(currency.btc)
            self.ethPrice.text = self.formatPrice(currency.eth)
            self.audPrice.text = self.formatPrice(currency.aud)
            self.usdPrice.text = self.formatPrice(currency.usd)
            self.lastUpdatedPrice.text = self.formatDate(date: Date())
            
        }//更快更新UI價格變化
    }
    
    //調整價格字串格式
    func formatPrice(_ price: Price) -> String {
        
        return String(format: "%@ %.4f", price.unit,price.value)// 傳回小數點第四位的價格格式
        
    }
    //日期初始化
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter() // 日期轉換格式
        formatter.dateFormat = "dd mm y HH:mm:ss" // 接收日期格式
        return formatter.string(from: date) // 回傳當前日期
    }
}

