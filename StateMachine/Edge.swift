//
//  Edge.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/13/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

class Edge<T, U> {
    
    let sourceNode: T
    let destinationNode: T
    let arc: U
    
    init(sourceNode: T, destinationNode: T, arc: U) {
        self.sourceNode = sourceNode
        self.destinationNode = destinationNode
        self.arc = arc
    }
    
}
