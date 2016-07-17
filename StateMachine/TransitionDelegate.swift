//
//  TransitionDelegate.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

protocol TransitionDelegate: class {
    
    func transition(transition: Transition, cancelledFromState sourceState: State, to destinationState: State)
    
    func transition(transition: Transition, finishedFromState sourceState: State, to destinationState: State)
    
}
