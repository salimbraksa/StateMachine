//
//  State
//  StateMachine
//
//  Created by Salim Braksa on 7/3/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

public class State {
    
    // MARK: Properties
    
    weak var machine: StateMachine!
    
    // MARK: Initializer
    
    public init() {
        
    }
    
    // MARK: State Lifecycle
    
    public func willEnter(fromState state: State) {
    }
    
    public func didEnter(fromState state: State) {        
    }
    
    public func willExit(toState state: State) {
    }
    
    public func didExit(toState state: State) {
    }
    
}
