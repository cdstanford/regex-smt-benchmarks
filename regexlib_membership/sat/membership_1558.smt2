;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*\$AVE|\$ave.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$aveQ#S\u00E9+"
(define-fun Witness1 () String (seq.++ "$" (seq.++ "a" (seq.++ "v" (seq.++ "e" (seq.++ "Q" (seq.++ "#" (seq.++ "S" (seq.++ "\xe9" (seq.++ "+" ""))))))))))
;witness2: "$ave"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "a" (seq.++ "v" (seq.++ "e" "")))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "$" (seq.++ "A" (seq.++ "V" (seq.++ "E" "")))))) (re.++ (str.to_re (seq.++ "$" (seq.++ "a" (seq.++ "v" (seq.++ "e" ""))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
