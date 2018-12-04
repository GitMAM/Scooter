//
//  SideMenuVC.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 20/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import SideMenu


final class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let data = [SlidMenu(title: "How to Ride", imageName: "kick-scooter"), SlidMenu(title: "Free Rides", imageName: "free"), SlidMenu(title: "Ride History", imageName: "history"), SlidMenu(title: "Payment", imageName: "hand"),SlidMenu(title: "Request Free Helmet", imageName: "Helmet"), SlidMenu(title: "Safety", imageName: "shield"), SlidMenu(title: "Settings", imageName: "settings"), SlidMenu(title: "Become an Owner", imageName: "kick-scooter"),
                SlidMenu(title: "Become a Charger", imageName: "charger")]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primary.withAlphaComponent(0.6)
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 85, height: 85)
        imageView.image = UIImage(named: "user")
//        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let nib = UINib(nibName: "SourcesTableViewCell", bundle: .main)
        self.tableView.register(nib, forCellReuseIdentifier: "SourcesTableViewCell")

    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesTableViewCell", for: indexPath) as? SourcesTableViewCell else {
            return UITableViewCell()
        }
        cell.topicName.text = data[indexPath.row].title
        cell.icon.image = UIImage(named: data[indexPath.row].imageName)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.present(OnBoardingVC(), animated: true, completion: nil)
        } else if indexPath.row == 5 {
            navigationController?.pushViewController(SettingsViewController(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(RideHistoryVC(), animated: true)
        } else if indexPath.row == 6 {
            navigationController?.pushViewController(BecomeViewController(), animated: true)
        } else if indexPath.row == 8 {
            navigationController?.pushViewController(BecomeViewController(), animated: true)
        } else if indexPath.row == 3 {
            navigationController?.pushViewController(PaymentViewController(), animated: true)
        } else if indexPath.row == 4 {
            navigationController?.pushViewController(BecomeViewController(), animated: true)

        }
    }
}
