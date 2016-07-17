//
//  Digraph.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/12/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

class Digraph<T: AnyObject, U> {
    
    // MARK: - Properties
    
    private let nodes: Array<T>
    private var edges = Array<Edge<T, U>>()
    
    // MARK: - Initializer
    
    init(nodes: Array<T>) {
        self.nodes = nodes
    }
    
    // MARK: - Adding Arc
    
    func add(arc: Edge<T, U>) {
        edges.append(arc)
    }
    
    // MARK: Getting Arcs
    
    func arcs(fromNode node: T) -> [Edge<T, U>] {
        return edges.filter { $0.sourceNode === node }
    }
        
}
