
Auxiliary exercises
===================

Go to http://efc.2015.uob.bram.xyz/, or check out branch `gh-pages`. 


To publish in this repository
-----------------------------

::

	bgeron@tinker /tmp> git clone https://github.com/bgeron/uob-2015-efc ex
	bgeron@tinker /tmp> cd ex/
	bgeron@tinker /tmp/ex> git checkout gh-pages 
	bgeron@tinker /tmp/ex> git checkout master
	bgeron@tinker /tmp/ex> git clone -b gh-pages . _gh-pages
	bgeron@tinker /tmp/ex> # work work
	bgeron@tinker /tmp/ex> make # to put a HTML preview in _build/html
	bgeron@tinker /tmp/ex> make pages # to build a new version to the gh-pages branch
	bgeron@tinker /tmp/ex> git push --all # to publish your new versions
	bgeron@tinker /tmp/ex>

