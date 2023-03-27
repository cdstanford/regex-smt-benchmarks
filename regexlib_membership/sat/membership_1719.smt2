;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^-\d*\.?\d*[1-9]+\d*$)|(^-[1-9]+\d*\.\d*$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-4819"
(define-fun Witness1 () String (str.++ "-" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "9" ""))))))
;witness2: "-71."
(define-fun Witness2 () String (str.++ "-" (str.++ "7" (str.++ "1" (str.++ "." "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "-" "-")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9")) (str.to_re "")))))))) (re.++ (str.to_re "")(re.++ (re.range "-" "-")(re.++ (re.+ (re.range "1" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
