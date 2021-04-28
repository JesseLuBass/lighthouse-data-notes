Dictionary is also called associative arrays or hashes 
additional ways of creating dictionary:

ID = dict(name = 'Abder-Rahman', number = 1234)

ID = dict([('name','Abder-Rahman'),('number',1234)])

ID = dict(zip(['name','number'],['Abder-Rahman',1234])) # keys and values as Lists

to iterate over keys: 
for word in dictname.iterkeys():

to iterate over values:
for word in dictname.itervalues():

Tuples are accessed by an index 

conditional statements consists of three parts:
a test that evalutes to either true or false 
a block of codes that run if the test is true 
an optional block of codes if the test is false 

if we have a statement with a mix of or, and, not operations, the order priority is or runs first, then and, then not 

the value 1 is another form of the boolean value True 

the statement break causes the loop to terminate, and program execution is continued on the next statement 
the statement continue returns control back to the beginning of the loop, ignoring any statements in the loop coming afterward.
the statement pass is a placeholder that allow the program to run even if you didn't decide yet what required statements has to go in
some place of code 

lambda funcions are anonymous functions Python creates at runtime using the lambda construct
syntax
lambda arguments: expression 
Generally used as an argument to a higher-order function 

map()
takes in a function and a list 
called with all the items in the list and a new list is returned which contains items returned by that function for each item 

set type
sets are unordered 
set elements are unique. duplicate elements are not allowed 
a set itself may be modified, but the elements contained in the set must be of an immutable type 

```python 
x = set(<iter>)
```

original order not necessarily perserved 

the argument to set() is an iterable. It generates a list of elements to be placed into the set. 
the objects in curly braces are placed into the set intact, even if they are iterable 

```python 
{'foo'}
{'foo'}

set('foo')
{'o', 'f'}
```

the only way to define an empty set is with the set() function, otherwise it turns into a dictionary
lists and dictionaries are mutable and therefore can't be set elements 

where a set is expected, methods typically accept any iterable as an argument, but operators require actual set as operands 

there are two ways of creating copies. Using the rqual sign only creates a new variable that shares the reference of the original subject 

shallow copies contain references to original nested objects stored in old_list. which means any changes within the nested object will appear in the new copy. 

a deep copy creates a new object and recursively adds the copies of nested obejcts present in the original elements 