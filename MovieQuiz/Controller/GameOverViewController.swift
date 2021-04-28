//
//  GameOverViewController.swift
//  MovieQuiz
//
//  Created by Gilmar Queiroz on 28/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    //MARK: - outlet
    @IBOutlet weak var lbScore: UILabel!

     //MARK: - life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion:nil)
    }
}
