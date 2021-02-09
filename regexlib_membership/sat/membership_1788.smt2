;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \$[0-9]?[0-9]?[0-9]?((\,[0-9][0-9][0-9])*)?(\.[0-9][0-9]?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0085u\x19a^$064,678,493.97"
(define-fun Witness1 () String (seq.++ "\x85" (seq.++ "u" (seq.++ "\x19" (seq.++ "a" (seq.++ "^" (seq.++ "$" (seq.++ "0" (seq.++ "6" (seq.++ "4" (seq.++ "," (seq.++ "6" (seq.++ "7" (seq.++ "8" (seq.++ "," (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "." (seq.++ "9" (seq.++ "7" "")))))))))))))))))))))
;witness2: "$38,023"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "3" (seq.++ "8" (seq.++ "," (seq.++ "0" (seq.++ "2" (seq.++ "3" ""))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.* (re.++ (re.range "," ",")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))(re.++ (re.opt (re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
