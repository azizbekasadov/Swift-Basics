//
//  ViewController.swift
//  Actors-Example
//
//  Created by Azizbek Asadov on 14/01/23.
//

import UIKit

// MARK: - Usage
final class ViewController: UIViewController {

    private lazy var imageView = UIImageView(
        frame: CGRect(x: 20, y: 20, width: view.frame.width - 40.0, height: 200.0)
    )
    
    private var imageCache = ImageCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Task {
            await self.retrieveImages()
        }
    }

    private func retrieveImages() async {
        let uuid = UUID()
        
        Task.detached {
            await self.imageCache.save(image: UIImage(), with: uuid)
        }
        
        self.imageView.image = await imageCache.getImage(for: uuid)
    }

}

