//
//  DetayViewController.swift
//  SwiftJsonParse
//
//  Created by developersancho on 19.02.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

extension UIImageView{ // Resim gösterebilmek için internetten bir extension bulup olduğu gibi ekledim
    func downloadedFrom(url:URL,contentMode mode: UIViewContentMode = .scaleAspectFit){
        contentMode=mode
        URLSession.shared.dataTask(with: url){
            data,response,error in guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data:data)
                else {return}
            DispatchQueue.main.async() {
                
                self.image=image
            }
            
            }.resume()
    }
    
    func downloadedFrom(link:String,contentMode mode: UIViewContentMode = .scaleAspectFit)
    {
        guard let url = URL(string:link) else {return}
        downloadedFrom(url:url,contentMode:mode)
    }
    
}

class DetayViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var predictionLabel: UILabel!
    
    var detay:DetailConst?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = detay?.weather_state_name
        //nameLabel olarak tanımladığım label a json çıktısındanweather_state_name tanıttım
        predictionLabel.text = String(describing:detay?.predictability);
        //predictionLabel olarak tanımladığım label a json çıktısından predictability tanıttım
        let urlString = "https://www.metaweather.com/static/img/weather/png/64/" + (detay?.weather_state_abbr)! + ".png"
        // resimleri alacağımız url i tanıtıyoruz(kullandığım json da weather_state_abbr etiketine hangi değer gelirse onun adındaki resim dosyasına ulaşıyoruz)
        let url = URL(string:urlString)
        imageView.downloadedFrom(url: url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
