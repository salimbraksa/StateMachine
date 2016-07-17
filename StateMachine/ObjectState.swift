//
//  ObjectState.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import UIKit

typealias AnyObjectState = ObjectState<AnyObject>
typealias ViewState = ObjectState<UIView>

public class ObjectState<T: AnyObject>: State {
    
    // MARK: Properties
    
    public var object: T? {
        return (self.machine as? ObjectStateMachine<T>)?.object
    }
    
    // MARK: Initializer
    
    override public init() {
        super.init()
    }
    
    // MARK: State Lifecycle
    
    public override func willEnter(fromState state: State) {
        super.willEnter(fromState: state)
        update()
    }

    // MARK: Updating Object
    
    func update() {
    }
    
}
