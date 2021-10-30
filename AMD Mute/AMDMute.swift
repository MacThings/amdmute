//
//  ViewController.swift
//  macOS Unlocker
//
//  Created by Prof. Dr. Luigi on 11.11.20.
//

import Cocoa

class AMDMute: NSViewController {
        
    let scriptPath = Bundle.main.path(forResource: "/script/script", ofType: "command")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
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
        let alert = NSAlert()
            alert.messageText = NSLocalizedString("Done!", comment: "")
            alert.informativeText = NSLocalizedString("Completed the creation of the SSDT. You can find it on yout desktop. Good luck.\n\nSSDT-MUTE-GENERIC-RADEON.aml", comment: "")
            alert.alertStyle = .informational
            let Button = NSLocalizedString("Ok", comment: "")
            alert.addButton(withTitle: Button)
            alert.runModal()
            return
    }
    
    
    func syncShellExec(path: String, args: [String] = []) {
        let process            = Process()
        process.launchPath     = "/bin/bash"
        process.arguments      = [path] + args
        process.launch() // Start process
        process.waitUntilExit() // Wait for process to terminate.
    }
}
