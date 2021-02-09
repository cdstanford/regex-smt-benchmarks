;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2|887"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "|" (seq.++ "8" (seq.++ "8" (seq.++ "7" ""))))))
;witness2: "F-18769"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "-" (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "6" (seq.++ "9" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "F" (seq.++ "-" ""))))(re.++ (re.union (re.++ (re.range "2" "2") (re.union (re.range "A" "B") (re.range "|" "|"))) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
