//
//  SecondaryActionInteraction.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import UIKit

final class EmojiReactionActionInteraction: NSObject, UIInteraction {
    
    // MARK: - Properties
    
    private lazy var longPressGesture = UILongPressGestureRecognizer(
        target: self,
        action: #selector(handleLongPress)
    )
    
    private let reactionActions: [ReactionAction]
    
    // MARK: - Interface
    
    private(set) weak var view: UIView?
    private weak var activeOptionView: UIView?
    
    private let reactionContainer: ReactionContainerView = {
        let view = ReactionContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    // MARK: - Init
    
    init(reactionActions: [ReactionAction]) {
        self.reactionActions = reactionActions
        super.init()
        reactionContainer.setupActions(reactionActions: reactionActions)
    }
    
    // MARK: - Lifecycle
    
    func willMove(to newView: UIView?) {
        guard let view else { return }
        reactionContainer.removeFromSuperview()
        view.removeGestureRecognizer(longPressGesture)
    }
    
    func didMove(to newView: UIView?) {
        view = newView
        
        guard let newView else { return }
        
        newView.addSubview(reactionContainer)
        NSLayoutConstraint.activate([
            reactionContainer.bottomAnchor.constraint(equalTo: newView.bottomAnchor),
            reactionContainer.leadingAnchor.constraint(equalTo: newView.leadingAnchor)
        ])
        
        newView.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: - User action
    
    @objc private func handleLongPress(
        _ gesture: UILongPressGestureRecognizer
    ) {
        switch gesture.state {
        case .began:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            
            reactionContainer.applyPinTransform(scale: 0.1)
            performAnimation { [self] in
                reactionContainer.alpha = 1.0
                reactionContainer.applyPinTransform(scale: 1.0)
            }
            
        case .changed:
            if let optionView = reactionContainer.actionsStackView.arrangedSubviews.first(
                where: {
                    let location = gesture.location(in: $0)
                    let enlargedBounds = $0.bounds.insetBy(dx: 0, dy: -25)
                    return enlargedBounds.contains(location)
                }
            ) {
                guard activeOptionView != optionView else { return }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                
                performAnimation { [self] in
                    activeOptionView?.transform = .identity
                    activeOptionView = optionView
                    let transform = CGAffineTransform(translationX: .zero, y: -10.0)
                        .scaledBy(x: 1.5, y: 1.5)
                    optionView.transform = transform
                    
                }
            } else if !reactionContainer.actionsStackView.point(
                inside: gesture.location(in: reactionContainer.actionsStackView),
                with: nil
            ) {
                performAnimation { [self] in
                    activeOptionView?.transform = .identity
                    activeOptionView = nil
                }
            }
            
        case .cancelled:
            performAnimation { [self] in
                reactionContainer.alpha = .zero
                reactionContainer.applyPinTransform(scale: 0.1)
            }
            
        case .ended:
            performAnimation { [self] in
                let actionViews = reactionContainer.actionsStackView.arrangedSubviews
                if
                    let activeOptionView,
                    let index = actionViews.firstIndex(of: activeOptionView)
                {
                    activeOptionView.transform = .identity
                    let action = reactionActions[index]
                    action.handler(action)
                    self.activeOptionView = nil
                }
                reactionContainer.alpha = .zero
                reactionContainer.applyPinTransform(scale: 0.1)
            }
        default:
            break
        }
    }
    
    private func performAnimation(_ animations: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.2,
            delay: .zero,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.15,
            animations: animations
        )
    }
}
