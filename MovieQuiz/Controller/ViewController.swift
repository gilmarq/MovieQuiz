//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Gilmar Queiroz on 27/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var ivSoundBar: UIView!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet weak var ivQuiz: UIImageView!
    @IBOutlet weak var ivTime: UIView!

    //MARK: - variable
    var quizManagr: QuizManager!
    var quizPlayer: AVAudioPlayer!

    //MARK: - life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManagr = QuizManager()
        getNewQuiz()
        starTime()
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
        playQuiz()
    }

    func playQuiz() {
        guard let round = quizManagr.round else { return }
        ivQuiz.image = UIImage(named: "movieSound")
        if let url = Bundle.main.url(forResource:"quote\(round.quiz.number)", withExtension: "mp3") {
            do {
       quizPlayer = try  AVAudioPlayer(contentsOf:url)
                quizPlayer.volume = 1
                quizPlayer.delegate = self
                quizPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        }

    }

    func  starTime() {
        ivTime.frame = view.frame
        UIView.animate(withDuration:60.0 , delay: 0.0, options: .curveLinear, animations: {
            self.ivTime.frame.size.width = 0
            self.ivTime.frame.origin.x = self.view.center.x
        }) { (success) in
            self.gameOver()
        }
    }

    func gameOver() {
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
        quizPlayer.stop()
    }
}

extension ViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        ivQuiz.image = UIImage(named: "movieSoundPause")
    }
}


