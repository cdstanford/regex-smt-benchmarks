(set-logic QF_S)
(declare-const x String)
(declare-const R RegLan)

;(echo "====== More Complement Examples (unsat) ======")

(assert (= R (re.comp (re.* (re.comp (str.to_re "cab"))))))
(assert (str.in_re x R))
(check-sat)
