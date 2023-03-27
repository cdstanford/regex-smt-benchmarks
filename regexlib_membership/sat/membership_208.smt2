;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-]?[0-9]*\.?[0-9]?[0-9]?[0-9]?[0-9]?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "98T\u0083l>\u00BB\u00DD\u00A2"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "T" (str.++ "\u{83}" (str.++ "l" (str.++ ">" (str.++ "\u{bb}" (str.++ "\u{dd}" (str.++ "\u{a2}" ""))))))))))
;witness2: "997"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "7" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
