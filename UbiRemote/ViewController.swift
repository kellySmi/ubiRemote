//
//  ViewController.swift
//  UbiRemote
//
//  Created by Kelly Smith on 6/28/18.
//  Copyright © 2018 Kelly Smith. All rights reserved.
//

import UIKit
import CoreBluetooth
class ViewController: UIViewController {
    var centralManager : CBCentralManager!
    var bltIsEnabled:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    @IBOutlet weak var StatusLabel: UILabel!
    @IBAction func clickScanButton(_ sender: UIButton) {
        let red:CGFloat = CGFloat(drand48())
        //print("\(red)")
        
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        self.view.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        if self.bltIsEnabled{
            self.StatusLabel.text = "Scanning..."
            centralManager.scanForPeripherals(withServices: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var periphText: UITextView!
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        guard let perif:CBPeripheral = peripheral else{
            self.StatusLabel.text = "Nothing Found"
        }
        
       self.StatusLabel.text = "Found \(peripheral.name)"
        print(perif)
        //let rpiServiceCBUUID = CBUUID(string: "0x180D")
    }


}
extension ViewController:CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
            self.bltIsEnabled = false
        case .resetting:
            print("central.state is .resetting")
            self.bltIsEnabled = false
        case .unsupported:
            print("central.state is .unsupported")
            self.bltIsEnabled = false
        case .unauthorized:
            print("central.state is .unauthorized")
            self.bltIsEnabled = false
        case .poweredOff:
            print("central.state is .poweredOff")
            self.bltIsEnabled = false
        case .poweredOn:
            print("central.state is .poweredOn")
            self.bltIsEnabled = true
        }
    }
}

