;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0][.]{1}[0-9]{0,}[1-9]+[0-9]{0,}$)|(^[1-9]+[0-9]{0,}[.]?[0-9]{0,}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "257."
(define-fun Witness1 () String (str.++ "2" (str.++ "5" (str.++ "7" (str.++ "." "")))))
;witness2: "481."
(define-fun Witness2 () String (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "." "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "." "")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
