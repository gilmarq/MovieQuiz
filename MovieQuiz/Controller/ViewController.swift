//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Gilmar Queiroz on 27/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var ivSoundBar: UIView!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet weak var ivQuiz: UIImageView!

    //MARK: - life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   //MARK: - action
    @IBAction func showHideSoundBar(_ sender: Any) {
    }

    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }

    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
    }
}

