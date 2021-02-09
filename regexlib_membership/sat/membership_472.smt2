;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((8|\+38)-?)?(\(?044\)?)?-?\d{3}-?\d{2}-?\d{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8-(044)7803284"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "-" (seq.++ "(" (seq.++ "0" (seq.++ "4" (seq.++ "4" (seq.++ ")" (seq.++ "7" (seq.++ "8" (seq.++ "0" (seq.++ "3" (seq.++ "2" (seq.++ "8" (seq.++ "4" "")))))))))))))))
;witness2: "8--4788910"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "-" (seq.++ "-" (seq.++ "4" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "0" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "8" "8") (str.to_re (seq.++ "+" (seq.++ "3" (seq.++ "8" ""))))) (re.opt (re.range "-" "-"))))(re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "0" (seq.++ "4" (seq.++ "4" "")))) (re.opt (re.range ")" ")")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)