//
//  ReactionAction.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import Foundation

struct ReactionAction {
    let title: String
    let handler: (ReactionAction) -> Void
}
