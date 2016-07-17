//
//  StateMachineAnalyzer.swift
//  StateMachine
//
//  Created by Salim Braksa on 7/15/16.
//  Copyright © 2016 Salim Braksa. All rights reserved.
//

import Foundation

// MARK: - Main Structure
struct StateMachineAnalyzer {
    
    // MARK: Properties
    
    weak var machine: StateMachine!
    
    // MARK: Initializer
    
    init(machine: StateMachine) {
        self.machine = machine
    }
    
    init() {
        
    }

    // MARK: Analyzers
    
    func canPerformTransition(fromState state: State, arrows: [StateMachineEdge]) -> NSError? {

        var userInfo: [String: String]?
        if machine.transitioning {
            userInfo = [NSLocalizedDescriptionKey: StateMachineAnalyzer.ErrorMessage.AnotherTransitionIsRunning]
        } else if arrows.count > 1 {
            userInfo = [NSLocalizedDescriptionKey: StateMachineAnalyzer.ErrorMessage.AmbiguisTransition]
        } else if arrows.count == 0 {
            userInfo = [NSLocalizedDescriptionKey: StateMachineAnalyzer.ErrorMessage.NoTransitionAvailable]
        } else {
            return nil
        }
        
        let error = NSError(domain: StateMachineAnalyzer.ErrorDomain, code: StateMachineAnalyzer.ErrorCode.CannotPerformTransition, userInfo: userInfo)
        return error
        
    }
    
    
    
}

// MARK: - Errors Data Structure
extension StateMachineAnalyzer {
    
    // MARK: - Error Domain
    
    static var ErrorDomain: String {
        return "SMErrorDomain"
    }
    
    // MARK: - Error Data Structures
    
    struct ErrorCode {
        static let CannotPerformTransition = 1
    }
    
    struct ErrorMessage {
        static let AmbiguisTransition = "Too many transitions from state"
        static let NoTransitionAvailable = "No transition is available from state"
        static let AnotherTransitionIsRunning = "Another transition is running"
    }
    
}
