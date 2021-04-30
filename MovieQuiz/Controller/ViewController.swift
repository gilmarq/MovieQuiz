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
    var backgroundMusicPlayer: AVPlayer!
    var playerItem: AVPlayerItem!
    
    
    //MARK: - life cyclo
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManagr = QuizManager()
        getNewQuiz()
        starTime()
         ivSoundBar.isHidden = true
    }
    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameOverViewController
        vc.score = quizManagr.score
    }
    
    //MARK: - action
    @IBAction func showHideSoundBar(_ sender: Any) {
        ivSoundBar.isHidden = !ivSoundBar.isHidden
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
        if  backgroundMusicPlayer.timeControlStatus ==  .paused {
            backgroundMusicPlayer.play()
            sender.setImage(UIImage(named: "pause" ), for: .normal)
        } else {
            backgroundMusicPlayer.pause()
             sender.setImage(UIImage(named: "play" ), for: .normal)
        }
    }
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
        backgroundMusicPlayer.seek(to: CMTime(seconds: Double(sender.value) * playerItem.duration.seconds, preferredTimescale: 1))
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
    
    @IBAction func playQuiz() {
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
    
    func playBackgroundMusic() {
        let musicURL = Bundle.main.url(forResource:"MarchaImperial", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: musicURL)
        backgroundMusicPlayer = AVPlayer(playerItem: playerItem)
        backgroundMusicPlayer.volume = 0.1
        backgroundMusicPlayer.play()
        backgroundMusicPlayer.addPeriodicTimeObserver(forInterval:CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil) { (time) in
            let precent = time.seconds / self.playerItem.duration.seconds
            
            self.slMusic.setValue(Float(precent), animated: true)
            
        }
    }
}

extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        ivQuiz.image = UIImage(named: "movieSoundPause")
    }
}


