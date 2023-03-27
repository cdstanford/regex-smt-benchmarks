(set-logic QF_S)
(declare-const x String)

(assert (str.in_re x (re.inter
    (re.++ re.all (str.to_re "a") ((_ re.^ 3) re.allchar))
    (re.++ re.all (str.to_re "b") ((_ re.^ 3) re.allchar))
)))

(check-sat)
;(get-model)
