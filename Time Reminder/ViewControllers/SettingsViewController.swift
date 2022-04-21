//
//  SettingsViewController.swift
//  Time Reminder
//
//  Created by Maxence Gama on 04/02/2021.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TimeList: TimeList!
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    @IBOutlet var saveBUtton: UIBarButtonItem!
    
    var activeScheduledNotificationsList = [] as [Bool]

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generator.prepare()
        
        if UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") != nil {
            activeScheduledNotificationsList = UserDefaults.standard.object(forKey: "activeScheduledNotificationsList") as! [Bool]
        } else {
            for _ in 0...23 {
                activeScheduledNotificationsList.append(true)
            }
        }
//        print(activeScheduledNotificationsList)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        setUpConstraints()
        
        title = "Notifications"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        save()
    }
    
    @objc func close() {
//        generator.impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
//        generator.impactOccurred()
        UserDefaults.standard.setValue(activeScheduledNotificationsList, forKey: "activeScheduledNotificationsList")
        print(activeScheduledNotificationsList)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let attributedText = NSMutableAttributedString(string: "Notification de \(indexPath.row < 10 ? "0" : "")\(indexPath.row):\(indexPath.row < 10 ? "0" : "")\(indexPath.row)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        cell.textLabel?.attributedText = attributedText
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(activeScheduledNotificationsList[indexPath.row], animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
        activeScheduledNotificationsList[sender.tag] = Bool(sender.isOn)
//        print(activeScheduledNotificationsList)
  }
}
