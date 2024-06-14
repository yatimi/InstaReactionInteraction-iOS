//
//  InstaCardView.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import UIKit

final class InstaCardView: UIView {
    
    // MARK: - Properties
    
    var selectedReaction: ReactionAction? {
        didSet {
            shareButton.setImage(nil, for: .normal)
            shareButton.setTitle(selectedReaction?.title, for: .normal)
        }
    }
    private let reactionActions: [ReactionAction]
    
    // MARK: - Interface
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .instagram
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var bottomToolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.distribution = .equalCentering
        stackView.addArrangedSubview(leftToolStackView)
        stackView.addArrangedSubview(bookmarkButton)
        // insets
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var leftToolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.leftToolStackViewSpacing
        stackView.addArrangedSubview(heartButton)
        stackView.addArrangedSubview(messageButton)
        stackView.addArrangedSubview(shareButton)
        return stackView
    }()
    
    // Actions
    
    private lazy var heartButton: UIButton = makeButton(systemName: .heart)
    private lazy var messageButton: UIButton = makeButton(systemName: .message)
    private lazy var bookmarkButton: UIButton = makeButton(systemName: .bookmark)
    private lazy var shareButton: UIButton = {
        let button = makeButton(systemName: .paperplane)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonSize)
        let interaction = EmojiReactionActionInteraction(reactionActions: reactionActions)
        button.addInteraction(interaction)
        return button
    }()
    
    // MARK: - Init
    
    init(reactionActions: [ReactionAction]) {
        self.reactionActions = reactionActions
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        isUserInteractionEnabled = true
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        imageView.addSubview(bottomToolStackView)
        NSLayoutConstraint.activate([
            bottomToolStackView.heightAnchor.constraint(equalToConstant: Constants.bottomToolStackViewHeight),
            bottomToolStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            bottomToolStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            bottomToolStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
    }
    
    private func makeButton(systemName: ImageSystemNames) -> UIButton {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: Constants.buttonSize), forImageIn: .normal)
        button.setImage(UIImage(systemName: systemName.rawValue), for: .normal)
        return button
    }
    
    private struct Constants {
        static let leftToolStackViewSpacing: CGFloat = 15
        static let imageHeight: CGFloat = 450
        static let bottomToolStackViewHeight: CGFloat = 50
        static let buttonSize: CGFloat = 25
    }
    
}

extension InstaCardView {
    enum ImageSystemNames: String {
        case heart, message, bookmark, paperplane
    }
}
