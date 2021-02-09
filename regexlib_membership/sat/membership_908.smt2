;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\(0?[1-9][0-9]\))|(0?[1-9][0-9]))[ -.]?([1-9][0-9]{3})[ -.]?([0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(078)72298998"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ ")" (seq.++ "7" (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" ""))))))))))))))
;witness2: "(079)-96989918"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ ")" (seq.++ "-" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "(" "(")(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range ")" ")"))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "1" "9") (re.range "0" "9"))))(re.++ (re.opt (re.range " " "."))(re.++ (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.range " " "."))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
