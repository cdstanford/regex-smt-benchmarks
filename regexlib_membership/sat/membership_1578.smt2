;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d+\x20*([pP][xXtT])?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9987   "
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ " " (str.++ " " (str.++ " " ""))))))))
;witness2: "94"
(define-fun Witness2 () String (str.++ "9" (str.++ "4" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "T" "T")(re.union (re.range "X" "X")(re.union (re.range "t" "t") (re.range "x" "x")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
