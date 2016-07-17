//
//  Transition.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/3/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

public class Transition {
        
    // MARK: Internal Properties
    
    weak var machine: StateMachine!
    
    weak var sourceState: State!
    weak var destinationState: State!
    weak var delegate: TransitionDelegate?
    
    // MARK: Properties
    
    /// A string identifying the transition.
    public let identifier: String
    
    // MARK: Initializers
    
    public init(identifier: String) {
        self.identifier = identifier
    }
    
    // MARK: Performing Transition
    
    /// Tells the *sourceState* that it will exit.
    ///
    /// If the caller is **NOT** a subclass of `Transition`, this method will also tells the *destinationState*
    /// that it will enter.
    ///
    /// - parameter sourceState: Trivial.
    /// - parameter destinationState: Trivial.
    public func perform(from sourceState: State, to destinationState: State) {
        beginTransition()
        if self.dynamicType == Transition.self {
            endTransition()
        }
    }
    
    // MARK: Transition Lifecycle
    
    /// Tells the *sourceState* that it will exit, and tells the *destinationState* that it will enter.
    private func beginTransition() {
        destinationState.willEnter(fromState: sourceState)
        sourceState.willExit(toState: destinationState)
    }
    
    /// Tells the *sourceState* that it did exit, and tells the *destinationState* that it did enter.
    public func endTransition() {
        destinationState.didEnter(fromState: sourceState)
        sourceState.didExit(toState: destinationState)
        delegate?.transition(self, finishedFromState: sourceState, to: destinationState)
    }
    
    /// Tells the `delegate` that the transition is cancelled.
    ///
    /// Generally the delegate is the machine.
    public func cancelTransition() {
        delegate?.transition(self, cancelledFromState: sourceState, to: destinationState)
    }
    
}
