//
//  ObjectStateMachine.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import UIKit

typealias ViewStateMachine = ObjectStateMachine<UIView>

public class ObjectStateMachine<T: AnyObject>: StateMachine {
    
    // MARK: Initializer
    
    override init(initialState: State, finalStates: [State], states: [State]) {
        super.init(initialState: initialState, finalStates: finalStates, states: states)
    }
    
    // MARK: Properties
    
    public weak var object: T!
    
}
