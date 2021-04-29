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
    @IBOutlet weak var ivTime: UIView!


    
    //MARK: - variable
    var quizManagr: QuizManager!

    //MARK: - life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManagr = QuizManager()
        getNewQuiz()
    }

   //MARK: - action
    @IBAction func showHideSoundBar(_ sender: Any) {
        ivSoundBar.isHidden = !ivSoundBar.isHidden
    }

    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }

    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManagr.checkAnswer(sender.title(for: .normal)!)
        getNewQuiz()
    }

    //MARK: - methods
    func getNewQuiz() {
        let round =  quizManagr.genereteRandonQuiz()
        for i in 0..<round.options.count {
            btOptions[i].setTitle(round.options[i].name, for: .normal)

        }
    }
}

