;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \$[0-9]?[0-9]?[0-9]?((\,[0-9][0-9][0-9])*)?(\.[0-9][0-9]?)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085u\x19a^$064,678,493.97"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "u" (str.++ "\u{19}" (str.++ "a" (str.++ "^" (str.++ "$" (str.++ "0" (str.++ "6" (str.++ "4" (str.++ "," (str.++ "6" (str.++ "7" (str.++ "8" (str.++ "," (str.++ "4" (str.++ "9" (str.++ "3" (str.++ "." (str.++ "9" (str.++ "7" "")))))))))))))))))))))
;witness2: "$38,023"
(define-fun Witness2 () String (str.++ "$" (str.++ "3" (str.++ "8" (str.++ "," (str.++ "0" (str.++ "2" (str.++ "3" ""))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.* (re.++ (re.range "," ",")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))(re.++ (re.opt (re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
