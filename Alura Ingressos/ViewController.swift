//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 24/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imagemBanner: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
    }


}

