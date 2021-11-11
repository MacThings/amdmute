//
//  ViewController.swift
//  macOS Unlocker
//
//  Created by Prof. Dr. Luigi on 11.11.20.
//

import Cocoa

class AMDMute: NSViewController {
    
    
    @IBOutlet weak var bt_generate: NSButton!
    @IBOutlet weak var bt_quit: NSButton!
    @IBOutlet weak var qualified_text: NSTextField!
   
    
    let scriptPath = Bundle.main.path(forResource: "/script/script", ofType: "command")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
        self.syncShellExec(path: self.scriptPath, args: [""])
        
        let qualified = UserDefaults.standard.string(forKey: "Qualified")
        if qualified == "Yes" {
            self.qualified_text.stringValue = NSLocalizedString("Generate a SSDT to disable GFX audio. Should work for the most systems with one GFX card installed.", comment: "")
        } else {
            self.qualified_text.stringValue = NSLocalizedString("Sorry. Cant find any PCI Path of the HDAU Device in your System. Creation of a SSDT is not possible.", comment: "")
            self.bt_generate.isHidden = true
            self.bt_quit.isHidden = false
        }
    }
        
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "AMD Mute"
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func generate(_ sender: Any) {
        self.syncShellExec(path: self.scriptPath, args: ["generate"])
        self.bt_generate.isHidden=true
        self.bt_quit.isHidden=false
        let alert = NSAlert()
            alert.messageText = NSLocalizedString("Done!", comment: "")
            alert.informativeText = NSLocalizedString("Completed the creation of the SSDT. You can find it on yout desktop. Good luck.\n\nSSDT-MUTE-GENERIC-RADEON.aml", comment: "")
            alert.alertStyle = .informational
            let Button = NSLocalizedString("Ok", comment: "")
            alert.addButton(withTitle: Button)
            alert.runModal()
            return
    }
    
    
    @IBAction func quit(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
   
    func syncShellExec(path: String, args: [String] = []) {
        let process            = Process()
        process.launchPath     = "/bin/bash"
        process.arguments      = [path] + args
        process.launch() // Start process
        process.waitUntilExit() // Wait for process to terminate.
    }
}
