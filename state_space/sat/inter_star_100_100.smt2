(set-logic QF_S)
(declare-const x String)
(assert (str.in_re x (re.inter
    ((_ re.^ 100) (re.++ (re.* re.allchar) (str.to_re "a")))
    (re.* ((_ re.^ 100) (re.++ (re.* re.allchar) (str.to_re "a"))))
)))
(check-sat)
