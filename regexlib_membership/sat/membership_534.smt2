;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]{1}(\d+)?)(\.\d+)?)|([0]\.(\d+)?([1-9]{1})(\d+)?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.80083"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "8" (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "3" ""))))))))
;witness2: "\u008E0.18789"
(define-fun Witness2 () String (str.++ "\u{8e}" (str.++ "0" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "9" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9")))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))))) (re.++ (re.++ (str.to_re (str.++ "0" (str.++ "." "")))(re.++ (re.opt (re.+ (re.range "0" "9")))(re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
