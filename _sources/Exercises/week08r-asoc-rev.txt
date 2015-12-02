************************************
Week 8: Full Proof of Associativity: 
************************************


Last time we proved associativity for the base case (aka case nil). This time we aim to fill the gap for the inductive step and complete the proof. 
Remember we try to prove ::

    app (app xs ys) zs = app xs (app ys zs)

The base case is when ``xs = []`` and we proved ::

    app (app [] ys) zs = app [] (app ys zs)   

For inductive step, we first give a diagrammatic proof. (On the board)

Notice that the inductive step which should be proved is ::

    app (app (x::xs) ys) zs = app (x::xs) (app ys zs) 

While the induction hypothesis is ::

    app (app xs ys) zs = app xs (app ys zs)






The full proof is as follows ::


    Signatures:
        app  : _a list -> _a list -> _a list ;
        rev  : _a list -> _a list ;

    Definitions:
        [app nil] : forall xs : _a list . app [] xs = xs : _a list ;
        [app xs]  : forall x : _a . forall xs : _a list . forall ys : _a list . app (x::xs) ys = x :: app xs ys : _a list ;
        [rev nil] : rev [] = [] : _a list ;
        [rev xs]  : forall xs : _a list . forall x : _a . rev (x :: xs) = app (rev xs) (x :: []) : _a list ;	


    Theorem [lemma]:
        Statement: forall xs : _a list . forall ys : _a list . forall zs : _a list .
                   app (app xs ys) zs = app xs (app ys zs) : _a list
        Proof:
            by induction on list:
            case nil:
                assume ys : _a list.
                assume zs : _a list.
                we know [prem 1] : app [] ys = ys : _a list because [app nil] with (ys).
                we know [prem 2] : app [] (app ys zs) = (app ys zs) : _a list because [app nil] with (app ys zs).

                we know [step 1] : app (app [] ys) zs = app ys zs : _a list because equality on ([prem 1]).
                we know [step 2] : app (app [] ys) zs = app [] (app ys zs) : _a list because equality on ([step 1];[prem 2]).
                by [step 2]
				
            case (x::xs): [IH] : forall ys : _a list . forall zs : _a list .
                            app (app xs ys) zs = app xs (app ys zs) : _a list .
                assume ys : _a list.
                assume zs : _a list.
                we know [prem 1] : app (x::xs) ys = x::(app xs ys) : _a list because [app xs] with (x;xs;ys).
                we know [prem 2] : app (x::(app xs ys)) zs = x::(app (app xs ys) zs) : _a list because [app xs] with (x;app xs ys;zs).
                we know [prem 3] : app (app xs ys) zs = app xs (app ys zs) : _a list because [IH] with (ys;zs).
                we know [prem 4] : app (x::xs) (app ys zs) = x::(app xs (app ys zs)) : _a list because [app xs] with (x;xs;app ys zs).

                we know [step 1] : app (app (x::xs) ys) zs = app (x::(app xs ys)) zs : _a list because equality on ([prem 1]).
                we know [step 2] : app (app (x::xs) ys) zs = x::(app (app xs ys) zs) : _a list because equality on ([step 1];[prem 2]).
                we know [step 3] : app (app (x::xs) ys) zs = x::(app xs (app ys zs)) : _a list because equality on ([step 2];[prem 3]).
                we know [step 4] : app (app (x::xs) ys) zs = app (x::xs) (app ys zs) : _a list because equality on ([step 3];[prem 4]).
                by [step 4]
        QED.

	
	
	
	
	
	
	

	
	

Now we can prove a more specific proposition ::



    Theorem [example 6]:
        Statement: forall xs : _a list . forall x : _a . forall ys : _a list .
               app (app (rev ys) (rev xs)) (x::[]) = app (rev ys) (app (rev xs) (x::[])) : _a list
        Proof:
            assume xs : _a list .
            assume x : _a .
            assume ys : _a list .
            [lemma] with (rev ys; rev xs; x::[])
        QED.