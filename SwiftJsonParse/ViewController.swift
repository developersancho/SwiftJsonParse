//
//  ViewController.swift
//  SwiftJsonParse
//
//  Created by developersancho on 19.02.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var detaylar = [DetailConst]() // Detay sabitleri sınıfından gelen bilgiler.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJson { // Aşağıda oluşturduğumuz fonksiyonu burada çağırıyoruz.
            self.tableView.reloadData()
        }
        
        tableView.delegate=self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detaylar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // listelemede hicrelere gelecek metini seçiyoruz.
        
        cell.textLabel?.text = String((detaylar[indexPath.row].created).dropFirst(11).dropLast(11))
        return cell // ben hücrelerde tarih bilgisi gösterdiğim için dropFirst ve dropLast
        // methodlarıyla string i kısalttım.
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detayGoster", sender: self) // row a tıklandığında
    }                                                             // detayGoster segue e gitmesi
    // gerektiğini söylüyoruz
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // hangi satır seçildi?
        if let destination = segue.destination as? DetayViewController{
            destination.detay = detaylar[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    func downloadJson(completed:@escaping ()->())
    {
        let url = URL(string: "https://www.metaweather.com/api/location/2343732/2018/1/27/")
        // URL yi tanıtıyoruz.
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                do{
                    self.detaylar = try JSONDecoder().decode([DetailConst].self, from: data!)
                    // JsonDecoder ile detaySabitleri'nde gelen bilgileri decode ederek alıyoruz.
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }catch {
                    print("JSON Hata") // Json dan veri alamazsak hata mesajımız yazacak
                }
            }
        }.resume()
    }

}

