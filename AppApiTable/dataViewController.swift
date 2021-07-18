//
//  dataViewController.swift
//  AppApiTable
//
//  Created by Admin on 17.07.2021.
//
import SnapKit
import Kingfisher
import UIKit


class dataViewController: UIViewController {

    var structData:structJson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            initialize()
        }
    
    
    private func initialize(){
        let url = structData?.image_url
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.kf.indicatorType = .activity
        image.kf.setImage(with:URL(string: url!), placeholder: nil, options: [.transition(.fade(0.7))], completionHandler: nil)
        view.addSubview(image)
        image.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(50)
            maker.left.equalToSuperview().inset(20)
            maker.top.equalToSuperview().inset(250)
            maker.bottom.equalToSuperview().inset(120)
        }
    
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        let label = UILabel()
       // print(structData?.ingredients.yeast)
        label.text = structData?.name
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(50)
            maker.top.equalToSuperview().inset(150)
        }
        // Do any additional setup after loading the view.
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
