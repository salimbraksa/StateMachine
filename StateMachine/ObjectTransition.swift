//
//  ObjectTransition.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import UIKit

typealias ViewTransition = ObjectTransition<UIView>

class ObjectTransition<T: AnyObject>: Transition {
    
    // MARK: Initializers
    
    override init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    // MARK: Properties
    
    var object: T? {
        return (self.machine as? ObjectStateMachine<T>)?.object
    }
    
}
