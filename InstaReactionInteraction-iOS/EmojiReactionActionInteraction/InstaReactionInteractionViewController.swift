//
//  InstaReactionInteraction.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import UIKit

final class InstaReactionInteractionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let emojis: [String] = ["👀", "🙉", "😁", "🙏", "😢"]
    
    private lazy var reactionActions: [ReactionAction] = emojis.map {
        ReactionAction(title: $0) { self.selectedReaction = $0 }
    }
    
    private var selectedReaction: ReactionAction? {
        didSet { instaCardView.selectedReaction = selectedReaction }
    }
    
    // MARK: - Interface
    
    private lazy var instaCardView = InstaCardView(reactionActions: reactionActions)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(instaCardView)
        instaCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            instaCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            instaCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            instaCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

#Preview {
    InstaReactionInteractionViewController()
}
