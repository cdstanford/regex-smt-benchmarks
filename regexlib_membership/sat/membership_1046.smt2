;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = e(vi?)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E7e\u00E8"
(define-fun Witness1 () String (seq.++ "\xe7" (seq.++ "e" (seq.++ "\xe8" ""))))
;witness2: "k\u00C6\u00AE\u00BD}evi"
(define-fun Witness2 () String (seq.++ "k" (seq.++ "\xc6" (seq.++ "\xae" (seq.++ "\xbd" (seq.++ "}" (seq.++ "e" (seq.++ "v" (seq.++ "i" "")))))))))

(assert (= regexA (re.++ (re.range "e" "e") (re.opt (re.++ (re.range "v" "v") (re.opt (re.range "i" "i")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
