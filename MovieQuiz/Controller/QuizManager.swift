//
//  QuizManager.swift
//  MovieQuiz
//
//  Created by Gilmar Queiroz on 28/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import Foundation


typealias Round = (quiz:Quiz , options:[QuizOption])
class QuizManager {
    var quizes: [Quiz]
    let quizOption: [QuizOption]
    var score: Int
    var round: Round?

    init() {
        score = 0
        let quizeURL = Bundle.main.url(forResource: "quizes", withExtension: "json")!
        do {
            let quizesData = try Data(contentsOf: quizeURL)
            quizes = try JSONDecoder().decode([Quiz].self,from: quizesData)
            let quizesOptionURL = Bundle.main.url(forResource: "options",withExtension: "json")!
            let quizesOptionData = try Data(contentsOf: quizesOptionURL)
            quizOption = try JSONDecoder().decode([QuizOption].self, from: quizesOptionData)
        } catch {
            print(error.localizedDescription)
            quizes = []
            quizOption = []
        }
    }

    func genereteRandonQuiz() -> Round {
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let quiz = quizes[quizIndex]
        var indexes: Set<Int> = [quizIndex]

        while indexes.count < 4 {
            let index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }

        let option = indexes.map({quizOption[$0]})
        round = (quiz,option)
        return round!
    }

    func checkAnswer(_ answer: String) {
        guard let round = round else { return }
        if answer == round.quiz.name{
            self.score += 1
        }
    }
}

//MARK: - QUIZ
struct Quiz: Codable {
    let name: String
    let number: Int
}

struct QuizOption: Codable {
    let name: String
}
