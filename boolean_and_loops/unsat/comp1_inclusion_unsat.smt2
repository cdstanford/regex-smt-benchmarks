(set-logic QF_S)
(assert (= re.none (re.diff ((_ re.^ 9) re.allchar) (re.comp (re.++ (re.++ re.all (str.to_re "a")) ((_ re.^ 8) re.allchar))))))
(check-sat)
