//
//  StateMachineDelegate.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

public protocol StateMachineDelegate: class {
    
    func stateMachine(stateMachine: StateMachine, didFailPerformingTransitionWithError error: NSError)
    
}
