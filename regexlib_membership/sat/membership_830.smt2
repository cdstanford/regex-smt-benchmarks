;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "(""|[^"])*"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009A\"\""
(define-fun Witness1 () String (seq.++ "\x9a" (seq.++ "\x22" (seq.++ "\x22" ""))))
;witness2: "$\"\"\"\u00FF \""
(define-fun Witness2 () String (seq.++ "$" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\xff" (seq.++ " " (seq.++ "\x22" ""))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (str.to_re (seq.++ "\x22" (seq.++ "\x22" ""))) (re.union (re.range "\x00" "!") (re.range "#" "\xff")))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
