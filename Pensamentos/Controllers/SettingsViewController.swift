//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Gabriel Carvalho Guerrero on 19/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchAutoRefresh: UISwitch!
    @IBOutlet weak var labelTimeInterval: UILabel!
    @IBOutlet weak var sliderTimeInterval: UISlider!
    @IBOutlet weak var segmentedColorScheme: UISegmentedControl!
    
    let config = Configuration.shared
    
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeIntervalLabel(with: value)
        config.timeInterval = value
    }
    
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView() {
        switchAutoRefresh.setOn(config.autoRefresh, animated: false)
        sliderTimeInterval.setValue(Float(config.timeInterval), animated: false)
        segmentedColorScheme.selectedSegmentIndex = config.colorScheme
        changeTimeIntervalLabel(with: config.timeInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        labelTimeInterval.text = "Mudar após \(Int(value)) segundos"
    }

}
