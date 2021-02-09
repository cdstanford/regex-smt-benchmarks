;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((8|\+7)-?)?\(?\d{3,5}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}((-?\d{1})?-?\d{1})?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8-(667-799-92-1e"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "-" (seq.++ "(" (seq.++ "6" (seq.++ "6" (seq.++ "7" (seq.++ "-" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "2" (seq.++ "-" (seq.++ "1" (seq.++ "e" "")))))))))))))))))
;witness2: "\u00CF8(8290)021-3-54-11-:"
(define-fun Witness2 () String (seq.++ "\xcf" (seq.++ "8" (seq.++ "(" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "0" (seq.++ ")" (seq.++ "0" (seq.++ "2" (seq.++ "1" (seq.++ "-" (seq.++ "3" (seq.++ "-" (seq.++ "5" (seq.++ "4" (seq.++ "-" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ ":" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.union (re.range "8" "8") (str.to_re (seq.++ "+" (seq.++ "7" "")))) (re.opt (re.range "-" "-"))))(re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 5) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9") (re.opt (re.++ (re.opt (re.++ (re.opt (re.range "-" "-")) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-")) (re.range "0" "9"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
