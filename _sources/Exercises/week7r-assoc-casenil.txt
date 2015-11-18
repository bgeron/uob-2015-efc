************************************************************
Week 7: Proof of Exercise 7.3. Casenil Part (Induction Base)
************************************************************







Signatures::


    app  : _a list -> _a list -> _a list ;
  
	
	
	
	
	
	

Definitions::


    [app nil] : forall xs : _a list .
                app [] xs = xs : _a list ;
    [app xs]  : forall xs : _a list . forall x : _a . forall ys : _a list .
                app (x::xs) ys = x :: app xs ys : _a list ;
    







Theorem [Lemma]:: 

    Statement: forall xs: _a list . forall ys : _a list . forall zs: _a list . 
    app (app xs ys) zs = app xs (app ys zs)	: _a list 
	Proof: 
	by induction on list: 
	
	
	case nil: 
	    assume ys : _a list . 
		assume zs : _a list . 
		we know [prem 1] : app [] ys = ys : _a list 
		   because [app nil] with (ys).
		   
		we know [prem 2] : app [] (app ys zs) = (app ys zs) : _a list
           because [app nil] with (app ys zs). 
		   
        we know [step 1] : app (app [] ys) zs = app ys zs : _a list 
	       because equality on ([prem 1]).
   
        we know [step 2] : app (app [] ys) zs = app [] (app ys zs): _a list 
           because equality on ([step 1];[prem 2]). 
		   
		by [step 2]   
		
	case (x::xs) : [IH] . 
        TODO 
    QED.	