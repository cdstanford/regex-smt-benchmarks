;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "t2.20.90.18\u00FF\x2]\x1C\u00B3"
(define-fun Witness1 () String (str.++ "t" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "0" (str.++ "." (str.++ "9" (str.++ "0" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "\u{ff}" (str.++ "\u{02}" (str.++ "]" (str.++ "\u{1c}" (str.++ "\u{b3}" "")))))))))))))))))
;witness2: "98.99.89.7<i\u0096"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "." (str.++ "9" (str.++ "9" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "." (str.++ "7" (str.++ "<" (str.++ "i" (str.++ "\u{96}" ""))))))))))))))

(assert (= regexA (re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
