(declare-const x String)
(assert (str.in_re x (re.inter
    ((_ re.^ 1) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 2) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 3) (re.++ (re.* re.allchar) (str.to_re "a")))
)))
(check-sat)
