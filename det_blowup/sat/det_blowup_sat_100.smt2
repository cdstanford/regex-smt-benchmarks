(set-logic QF_S)
(declare-const x String)

(assert (str.in_re x
    (re.+ (re.++ re.all (str.to_re "a") ((_ re.^ 100) re.allchar)))
))

(check-sat)
;(get-model)
