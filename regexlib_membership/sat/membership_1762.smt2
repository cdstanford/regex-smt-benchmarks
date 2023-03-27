;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(V-|I-)?[0-9]{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "I-9689"
(define-fun Witness1 () String (str.++ "I" (str.++ "-" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "9" "")))))))
;witness2: "0088"
(define-fun Witness2 () String (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "V" (str.++ "-" ""))) (str.to_re (str.++ "I" (str.++ "-" "")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
