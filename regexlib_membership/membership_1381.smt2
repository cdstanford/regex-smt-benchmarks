;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\(?[0-9]{3}[\)-\.]?\ ?)?[0-9]{3}[-\.]?[0-9]{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(474 180-3493"
(define-fun Witness1 () String (str.++ "(" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ " " (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ "3" (str.++ "4" (str.++ "9" (str.++ "3" ""))))))))))))))
;witness2: "(747 948.5758"
(define-fun Witness2 () String (str.++ "(" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ " " (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "5" (str.++ "7" (str.++ "5" (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ".")) (re.opt (re.range " " " "))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
