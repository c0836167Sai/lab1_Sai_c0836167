//
//  ViewController.swift
//  lab1_Sai_c0836167
//
//  Created by Sai on 18/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
    }
    

    
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var bt5: UIButton!
    @IBOutlet weak var bt6: UIButton!
    @IBOutlet weak var bt7: UIButton!
    @IBOutlet weak var bt8: UIButton!
    @IBOutlet weak var bt9: UIButton!
    @IBOutlet weak var noughtScore: UILabel!
    @IBOutlet weak var crossScore: UILabel!
   
    
    var tapCheck: UIButton!
    
    var CROSS = "X"
    var NOUGHT = "O"
    
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
        becomeFirstResponder()                  //Shake motion 1st responder
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //SHAKE MOTION BEGAN
    
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        //SHAKE MOTION ENDED
        
        if(motion == .motionShake && currentTurn == Turn.Nought){
            tapCheck.setTitle(nil, for: .normal)
            tapCheck.isEnabled = true
            currentTurn = Turn.Cross
            
        }
        else if(motion == .motionShake && currentTurn == Turn.Cross){
            tapCheck.setTitle(nil, for: .normal)
            tapCheck.isEnabled = true
            currentTurn = Turn.Nought
        }
        
    }
    
    
    func initBoard()
    {
        board.append(bt1)
        board.append(bt2)
        board.append(bt3)
        board.append(bt4)
        board.append(bt5)
        board.append(bt6)
        board.append(bt7)
        board.append(bt8)
        board.append(bt9)
    }
    
    @IBAction func boardTap(_ sender: Any) {
        addToBoard(sender as! UIButton)
        
        if checkForVictory(CROSS)
        {
            crossesScore += 1
            crossScore.text = String(crossesScore)
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(NOUGHT)
        {
            noughtsScore += 1
            noughtScore.text = String(noughtsScore)
            resultAlert(title: "Noughts Win!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        
        if (thisSymbol(bt1, s) && thisSymbol(bt2, s) && thisSymbol(bt3, s)) ||
            (thisSymbol(bt4, s) && thisSymbol(bt5, s) && thisSymbol(bt6, s)) ||
            (thisSymbol(bt7, s) && thisSymbol(bt8, s) && thisSymbol(bt9, s)) ||
            (thisSymbol(bt1, s) && thisSymbol(bt4, s) && thisSymbol(bt7, s)) ||
            (thisSymbol(bt2, s) && thisSymbol(bt5, s) && thisSymbol(bt8, s)) ||
            (thisSymbol(bt3, s) && thisSymbol(bt6, s) && thisSymbol(bt9, s)) ||
            (thisSymbol(bt1, s) && thisSymbol(bt5, s) && thisSymbol(bt9, s)) ||
            (thisSymbol(bt3, s) && thisSymbol(bt5, s) && thisSymbol(bt7, s))
        {
            return true
        }
        return false
    }
    
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
   
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            tapCheck = sender
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
            }
            sender.isEnabled = false
        }
    }
    
    @IBAction func resetGame(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            resetBoard()
            crossesScore = 0
            noughtsScore = 0
            crossScore.text = "0"
            noughtScore.text = "0"
        default:
            break
        }
    }
    
    
    
    
    
    
}

