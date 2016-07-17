//
//  StateMachine.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/3/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

typealias StateMachineEdge = Edge<State, Transition>

// MARK: Main Class
public class StateMachine {
    
    // MARK: Private Properties
    
    private let digraph: Digraph<State, Transition>
    private var analyzer: StateMachineAnalyzer
    
    private let initialState: State
    private let finalStates: [State]
    
    // MARK: Accessing Machine Properties
    
    /// Indicates the current state reached by the machine.
    private(set) public var currentState: State?
    
    /// Indicates that a transition is performing.
    private(set) public var transitioning = false
    
    // MARK: Configurable Properties
    
    public weak var delegate: StateMachineDelegate?
    
    // MARK: Object Lifecycle
    
    public init(initialState: State, finalStates: [State] = [], states: [State]) {
        
        // Merge all states
        let states = [initialState] + finalStates + states
        
        // Setting the directed graph
        self.digraph = Digraph(nodes: states)
        
        // Setting up the machine state
        self.initialState = initialState
        self.finalStates = finalStates
        self.currentState = initialState
        
        // Setting up the analyzer
        self.analyzer = StateMachineAnalyzer()
        self.analyzer.machine = self
        
        states.forEach { $0.machine = self }
        
    }
    
    // MARK: Adding Transitions
    
    /// Adds a *transition* from a single *state* to multiple *states*
    ///
    /// - parameter transition: The transition to add.
    /// - parameter sourceState: The source state.
    /// - parameter destinationStates: The destination states.
    public func add(transition: Transition, from sourceState: State, to destinationStates: State...) {
        destinationStates.forEach {
            add(transition: transition, from: sourceState, to: $0)
        }
    }
    
    /// Adds a *transition* from a single *state* to a single *state*
    ///
    /// - parameter transition: The transition to add.
    /// - parameter sourceState: The source state.
    /// - parameter destinationState: The destination state.
    public func add(transition transition: Transition, from sourceState: State, to destinationState: State) {
        let edge = StateMachineEdge(sourceNode: sourceState, destinationNode: destinationState, arc: transition)
        edge.arc.machine = self
        digraph.add(edge)
    }
    
    /// Adds the *transition* from the *first state* to the *second state* and vice-versa.
    ///
    /// - parameter transition: The transition to add.
    /// - parameter firstState: End point state of the transition.
    /// - parameter secondState: End point state of the transition.
    public func add(bidirectionalTransition transition: Transition, between firstState: State, and secondState: State) {
        add(transition: transition, from: firstState, to: secondState)
        add(transition: transition, from: secondState, to: firstState)
    }
    
    // MARK: Performing Transitions

    /// If the currentState has only one transition, It will be automatically performed,
    /// if it's not the case It will tell the delegate that the transition couldn't be
    /// performed.
    public func tryPerformTransition() {
    
        // Get all the arrows leading away from the current state
        let arrows = self.arrows(fromState: currentState!)
        
        // Check first if the machine can perform the transition
        if let error = analyzer.canPerformTransition(fromState: currentState!, arrows: arrows) {
            delegate?.stateMachine(self, didFailPerformingTransitionWithError: error)
            return
        }
        
        // Performing the transition then update the currentState
        let arrow = arrows.first!
        performTransition(arrow.arc, from: currentState!, to: arrow.destinationNode)
        
    }
    
    /// Fetches all the transitions of the currentState with the specified identifier.
    /// If the `currentState` has only one transition, It will be automatically performed,
    /// if it's not the case It will tell the delegate that the transition couldn't be
    /// performed.
    ///
    /// - parameter identifier: The identifier of the transition to perform.
    public func performTransition(withIdentifier identifier: String) {
        
        // Get all the arrows leading away from the current state with the specified transition identifier
        let arrows = self.arrows(fromState: currentState!, identifier: identifier)
        
        // Check first if the machine can perform the transition
        if let error = analyzer.canPerformTransition(fromState: currentState!, arrows: arrows) {
            delegate?.stateMachine(self, didFailPerformingTransitionWithError: error)
            return
        }
        
        // Performing the transition then update the currentState
        let arrow = arrows.first!
        performTransition(arrow.arc, from: currentState!, to: arrow.destinationNode)

    }
    
    private func performTransition(transition: Transition, from sourceState: State, to destinationState: State) {
        
        // Mark the maching as transitioning
        transitioning = true
        
        // Perform the transition
        transition.sourceState = sourceState
        transition.destinationState = destinationState
        transition.delegate = self
        transition.perform(from: sourceState, to: destinationState)
        
    }
    
    // MARK: Getting Transitions
    
    /// Returns the transitions that are leading away from the specified state.
    ///
    /// - parameter state: The state that you want it's leading away transitions.
    func arrows(fromState state: State) -> [StateMachineEdge] {
        return digraph.arcs(fromNode: state)
    }
    
    /// Returns the transitions that are leading away from the specified state and identifier.
    ///
    /// - parameter state: The state that you want it's leading away transitions.
    /// - parameter identifier: The identifier of the transitions you're looking for.
    func arrows(fromState state: State, identifier: String) -> [StateMachineEdge] {
        return self.arrows(fromState: state).filter { $0.arc.identifier == identifier }
    }
    
}

// MARK: TransitionDelegate Protocol
extension StateMachine: TransitionDelegate {
    
    func transition(transition: Transition, finishedFromState sourceState: State, to destinationState: State) {
        currentState = destinationState
        transitioning = false
        transition.delegate = nil
    }
    
    func transition(transition: Transition, cancelledFromState sourceState: State, to destinationState: State) {
        transitioning = false
        transition.delegate = nil
    }
    
}
