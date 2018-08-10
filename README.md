# MAS-Technical-Test-Ruby

Technical Test for candidate

## Task Description

Create an API that allows a user to search the [Money Advice Service website](https://www.moneyadviceservice.org.uk/en).
The user provides a search term, and gets back the _title_ and _url_ of the first article from the English site search, along with the _title_ and _url_ of the Welsh version of that same article (if a Welsh version exists).
The application shouldn’t have a UI, just an endpoint.

This exercise is for the purpose of assessing your problem solving and technical skills and is not a 'real world' task.

### Example response

```
{
  "en": {
    "title": "Mortgages – a beginner’s guide",
    "url": "https://www.moneyadviceservice.org.uk/en/articles/mortgages-a-beginners-guide"
  },
  "cy": {
    "title": "Morgeisi – canllaw i ddechreuwyr",
    "url": "https://www.moneyadviceservice.org.uk/cy/articles/morgeisi-canllaw-i-ddechreuwyr"
  }
}
```

## Purpose of the exercise

This is to enable us to evaluate your technical skills, as a second stage of the interview process. This test is meant to be unattended. It will be reviewed by the MAS developers after it is submitted and if the candidate is put through to the next interview may be used as part of said interview.

## Requirements

As well as addressing the objective of the exercise, the solution should include the following:

### Testing

The code should to be written in TDD (BDD) fashion. We should be able to run your tests via the usual commands for the testing framework utilised.

### Commits

Commit regularly, as a real project would require. Commits should have an appropriate size, content, and message. Use Github commit message standards. A private repository with push/pull permissions will be provided.  You may work in a branch (or branches) if you like, but the final code to be evaluated
must be merged into master.  We will only evaulate code in the master branch.

### Documentation & Comments

* Document and comment as appropriate bearing in mind that well-written Ruby code is a documentation of itself.  
* Change the existing readme file with information covering how to run your solution, run the tests and anything else you think is appropriate.

### Time

Take as much time as you need (please no more than a day's worth, but it can be much less) to implement a solution that addresses the evaluation criteria below. We care primarily about your approach to the problem and implementing a “perfect” solution is not desirable or necessary.  The test does not have to be completed in a single sitting, you are welcome to do the work in serpate chunks of time. 

### Finishing the test

When you feel you are done, please notify us (via your recruiter, if appropriate) that you have finished the test.  Once we get the notification that you have finished, we will evaluate the test.  We will not begin evaluating the test until you have notified us that you have finished.

## Evaluation criteria

We will be considering the following aspects of your solution:

* Code structure
  * Clarity and maintainability of application and test code
  * Adherence to Ruby and Rails community conventions
* Technical design
* Overall architecture and design (not visual)
* Appropriate use of object-oriented design principles
* Design should be appropriate for the objective
* Extensibility of your API
* Suitability of technologies used
* Use of gems and third party libraries
* Ruby on Rails is a must
