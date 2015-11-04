
**************
Week 6: graphs
**************

General strategy
================

*(This is not really code, nor pseudocode.)*

*This is a description of what the algorithm does. This description is closer than the textual algorithm given in the lecture at 08:00 .*	

Initialise the search tree using the initial state of the problem.

Loop:

#. If there are no candidates for **expansion**, then return failure.
#. Choose a leaf node.
#. If the chosen leaf matches the **goal**, then return the leaf.
#. If not, then expand the node, and use the **strategy** to determine how to re-order the new list of candidates, and perhaps filter out the visited nodes.
   
Note: depending on the expansion, goal, and strategy, there are **two** reasons why this might never finish.

.. collapse::

	1. If we don't filter out visited nodes, it's easy to get in an infinite loop.
	2. If we filter out visited nodes, but there are infinitely many possible nodes, then we can get in an infinite loop.

.. NOTE to Bram: slightly different from the algorithm shown, but matches the implementation.

Exercise: why did we not get in an infinite loop when we searched for the path from B to A in the lecture?

Version 1
=========

.. literalinclude:: week6-graphlec-v1.ml
	:language: ocaml

Version 2
=========

.. literalinclude:: week6-graphlec.ml
	:language: ocaml


Things to explain
=================

- Expand
- Strategy
- Goal

Visualisation of data from the graph
====================================

.. image:: week6-graph.png
	:width: 100%