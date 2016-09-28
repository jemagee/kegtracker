# Keg Tracker Project

### Goal:

To build a system to track the kegs used at my company to proudce our nitrogenated tea product across all steps, and states, of the process of getting, filling, consigning, returning, and cleaning kegs until they are again ready to use for new product.    

### Accomplished

* Basic models built for
  * Kegs
  * Batches 
  * Flavors
  * Users
  * Components (recipes of flavors)

* Basic CRUD for models above built and tested
* Lot number & best by date generation in Batches is are functions of Flavor abbreivation_attr and creation date.  Code created (and tested) to automatically generate these entries after a new batch is initiated.  
* Lot number sequencing set up based on established methodology of pilot program - will automatically create proper lot number for each batch of same flavor on the same day.
* Pattern matching via RegEx implemented to verify proper keg serial number entry
* Basic component adding set up, must be number, must not exceed 100% and must be present.


### Needs Doing

* Extending the Compopnent Model
	* Using AJAX so that comoponents can be added directly on a flavor page
	* Using AJAX so that the drop down list only allows for component not already in the recipe
	* Using custom validation to ensure that an ingredient recipe never exceeds 100%
	* "Remaining Quantity" option?
* Recipe Model set up will be a be the intermediate table of a has_many through for ingredients and flavors.  Not necessary for pilot program per se but appropiate to future building and expansion of application
* Each batch can fill X (as an integer) number of kegs, no more than 7, however, two batches might each make enough to fill one keg with a mixture of both batches
* Changing the state of the kegs along the way and making it obvious which is where.  For instance, after a batch is made, kegs are filled, and so should be selected and have their state changed.
* Each keg requires multiple 'nitrogenation' steps before done - this must be part of the application and 'auto-notify' appropriate people to make sure they do it daily
* Full Kegs are consigned to customers - customers must be accounted for and their 'deposit' amount should equal a multiple of kegs they have and default keg deposit amount
* Batch sheet creation - will have recipe for flavor and spaces for sign off and lot number of specific ingredients.  Should format as an 8.5 x 11 PDF

### Gems Introduced During Development

### New Skills Learned 

* Working with minimums and maximums with custom validation messages
* Modifying an attr_reader to format a date field display the way I want to see it.
* Using pattern matching in validation.
* Expanding devise basics to include attributes representing first and last name of user.
* Creating a child record via the childs 'new' method but starting with the parent when the parent is part of a drop down on the child new form