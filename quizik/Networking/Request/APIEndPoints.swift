//
//  APIEndPoints.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import Foundation

let url = "https://opentdb.com/api.php?"
let correct_url = "https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple"


//Opentrivia Category list
let category_url = "https://opentdb.com/api_category.php"
//Using a Session Token:
let using_ssession_token = "https://opentdb.com/api.php?amount=10&token=YOURTOKENHERE"

//Retrieve a Session Token:
let retrieve_session_token = "https://opentdb.com/api_token.php?command=request"

//Reset a Session Token:
let reset_session_toke = "https://opentdb.com/api_token.php?command=reset&token=YOURTOKENHERE"
