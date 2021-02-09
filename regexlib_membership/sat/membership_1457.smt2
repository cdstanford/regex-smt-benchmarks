;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\()?(787|939)(\)|-)?([0-9]{3})(-)?([0-9]{4}|[0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "939)7098698"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ ")" (seq.++ "7" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "8" ""))))))))))))
;witness2: "939)653-8773"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ ")" (seq.++ "6" (seq.++ "5" (seq.++ "3" (seq.++ "-" (seq.++ "8" (seq.++ "7" (seq.++ "7" (seq.++ "3" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (seq.++ "7" (seq.++ "8" (seq.++ "7" "")))) (str.to_re (seq.++ "9" (seq.++ "3" (seq.++ "9" "")))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "-" "-")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
