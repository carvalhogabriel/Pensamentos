//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Gabriel Carvalho Guerrero on 19/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var imageViewPhotoBackground: UIImageView!
    @IBOutlet weak var labelQuotes: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    
    let config = Configuration.shared
    
    let quotesManager = QuotesManager()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        labelQuotes.textColor = config.colorScheme == 0 ? .black : .white
        labelAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        prepareQuote()
    }
    
    func prepareQuote() {
        timer?.invalidate()
        if config.autoRefresh {
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { (timer) in
                self.showRandomQuote()
            }
        }
        showRandomQuote()
    }
    
    func showRandomQuote() {
        let quote = quotesManager.getRandomQuote()
        labelQuotes.text = quote.quote
        labelAuthor.text = quote.author
        imageViewPhoto.image = UIImage(named: quote.image)
        imageViewPhotoBackground.image = UIImage(named: quote.image)
        
        labelQuotes.alpha = 0.0
        labelAuthor.alpha = 0.0
        imageViewPhoto.alpha = 0.0
        imageViewPhotoBackground.alpha = 0.0
        constraintTop.constant = 50
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.labelQuotes.alpha = 1.0
            self.labelAuthor.alpha = 1.0
            self.imageViewPhoto.alpha = 1.0
            self.imageViewPhotoBackground.alpha = 0.25
            self.constraintTop.constant = 10
            self.view.layoutIfNeeded()
        }
    }
}
