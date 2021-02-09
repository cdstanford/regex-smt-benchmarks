;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:1\d{0,2}|[3-9]\d?|2(?:[0-5]{1,2}|\d)?|0)\.){3}(?:1\d{0,2}|[3-9]\d?|2(?:[0-5]{1,2}|\d)?|0)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "88.1.99.0"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "0" ""))))))))))
;witness2: "1.38.24.3"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "." (seq.++ "3" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "." (seq.++ "3" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.range "1" "1") ((_ re.loop 0 2) (re.range "0" "9")))(re.union (re.++ (re.range "3" "9") (re.opt (re.range "0" "9")))(re.union (re.++ (re.range "2" "2") (re.opt (re.union ((_ re.loop 1 2) (re.range "0" "5")) (re.range "0" "9")))) (re.range "0" "0")))) (re.range "." ".")))(re.++ (re.union (re.++ (re.range "1" "1") ((_ re.loop 0 2) (re.range "0" "9")))(re.union (re.++ (re.range "3" "9") (re.opt (re.range "0" "9")))(re.union (re.++ (re.range "2" "2") (re.opt (re.union ((_ re.loop 1 2) (re.range "0" "5")) (re.range "0" "9")))) (re.range "0" "0")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
