//
//  ViewController.swift
//  App outline
//
//  Created by Steve on 4/27/24.
//
import UIKit
import Foundation

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var Outs: UIStackView!
    @IBOutlet weak var Points: UILabel!
    @IBOutlet var PositionType: UILabel!
    @IBOutlet weak var Choice1: UITextView!
    @IBOutlet var StatType: UITextField!
    @IBOutlet weak var Choice2: UITextView!
    
 
    
    var earnedRuns: Int = 0
    var outs: Int = 0
    var currentStat: String = ""
    
    var hitters: [Hitter] = []
    var pitchers: [Pitcher] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hitters = loadHitterData()
        pitchers = loadPitcherData()
        loadRandomPlayers()
        // Do any additional setup after loading the view.
    }
    
    
    func loadRandomPlayers() {
         let isPitcher = Bool.random()
         if isPitcher {
             PositionType.text = "Pitcher"
             let player1 = pitchers.randomElement()!
             let player2 = pitchers.randomElement()!
             Choice1.text = "\(player1.playerName) \(player1.season)"
             Choice2.text = "\(player2.playerName) \(player2.season)"
             StatType.text = "WAR"
         } else {
             PositionType.text = "Hitter"
             let player1 = hitters.randomElement()!
             let player2 = hitters.randomElement()!
             Choice1.text = "\(player1.playerName) \(player1.season)"
             Choice2.text = "\(player2.playerName) \(player2.season)"
             StatType.text = "WAR"
         }
     }
    
    @IBAction func choice1selected(_ sender: Any) {
        checkAnswer(selectedPlayer: 1)
    }
    
    
    @IBAction func choice2selected(_ sender: Any) {
        checkAnswer(selectedPlayer: 2)
    }
    

    
    func checkAnswer(selectedPlayer: Int) {
        let isPitcher = PositionType.text == "Pitcher"
        var player1Stat: Double = 0
        var player2Stat: Double = 0
        
        if isPitcher {
            let player1 = pitchers.first { $0.playerName + " " + String($0.season) == Choice1.text }!
            let player2 = pitchers.first { $0.playerName + " " + String($0.season) == Choice2.text }!
            player1Stat = getStatValue(player: player1, stat: currentStat)
            player2Stat = getStatValue(player: player2, stat: currentStat)
        } else {
            let player1 = hitters.first { $0.playerName + " " + String($0.season) == Choice1.text }!
            let player2 = hitters.first { $0.playerName + " " + String($0.season) == Choice2.text }!
            player1Stat = getStatValue(player: player1, stat: currentStat)
            player2Stat = getStatValue(player: player2, stat: currentStat)
        }
        
        guard player1Stat.isFinite, player2Stat.isFinite else {
            print("Invalid stat value encountered")
            return
        }
        
        let isCorrect = (selectedPlayer == 1 && player1Stat > player2Stat) || (selectedPlayer == 2 && player2Stat > player1Stat)
        if isCorrect {
            earnedRuns += 1
            transitionToCorrectView()
        } else {
            outs += 1
            if outs >= 3 {
                handleGameOver()
            } else {
                transitionToWrongView()
            }
        }
    }
    
    func getStatValue(player: Any, stat: String) -> Double {
        if let player = player as? Pitcher {
            switch stat {
            case "WAR":
                return player.WAR
            case "ERA":
                return player.ERA
            case "WHIP":
                return player.WHIP
            default:
                return 0
            }
        } else if let player = player as? Hitter {
            switch stat {
            case "WAR":
                return player.WAR
            case "AVG":
                return player.AVG
            case "OPS":
                return player.OPS
            default:
                return 0
            }
        }
        return 0
    }
    
    func transitionToCorrectView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let correctVC = storyboard.instantiateViewController(withIdentifier: "CorrectViewController")
        present(correctVC, animated: true, completion: nil)
    }
    
    func transitionToWrongView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wrongVC = storyboard.instantiateViewController(withIdentifier: "WrongViewController")
        present(wrongVC, animated: true, completion: nil)
    }
    
    func handleGameOver() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameOverVC = storyboard.instantiateViewController(withIdentifier: "GameOverViewController") as! OutsThreeViewController
        gameOverVC.earnedruns = Points
        present(gameOverVC, animated: true, completion: nil)
    }
}
    
    func loadHitterData() -> [Hitter] {
        guard let path = Bundle.main.path(forResource: "hitdata", ofType: "json") else { fatalError("Couldn't find pitcherdata.json") }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let hitters = try JSONDecoder().decode([Hitter].self, from: data)
            return hitters
        } catch {
            print("Error loading hitter data: \(error)")
            return []
        }
    }

    func loadPitcherData() -> [Pitcher] {
        guard let path = Bundle.main.path(forResource: "pitchdata", ofType: "json") else { fatalError("Couldn't find pitcherdata.json") }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let pitchers = try JSONDecoder().decode([Pitcher].self, from: data)
            return pitchers
        } catch {
            print("Error loading pitcher data: \(error)")
            return []
        }
        
        
    }

    

     // Implement logic for checking the user's choice here
 
        

