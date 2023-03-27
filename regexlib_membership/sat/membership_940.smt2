;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((8|\+7)-?)?\(?\d{3,5}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}((-?\d{1})?-?\d{1})?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8-(667-799-92-1e"
(define-fun Witness1 () String (str.++ "8" (str.++ "-" (str.++ "(" (str.++ "6" (str.++ "6" (str.++ "7" (str.++ "-" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "e" "")))))))))))))))))
;witness2: "\u00CF8(8290)021-3-54-11-:"
(define-fun Witness2 () String (str.++ "\u{cf}" (str.++ "8" (str.++ "(" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "0" (str.++ ")" (str.++ "0" (str.++ "2" (str.++ "1" (str.++ "-" (str.++ "3" (str.++ "-" (str.++ "5" (str.++ "4" (str.++ "-" (str.++ "1" (str.++ "1" (str.++ "-" (str.++ ":" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.union (re.range "8" "8") (str.to_re (str.++ "+" (str.++ "7" "")))) (re.opt (re.range "-" "-"))))(re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 5) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9") (re.opt (re.++ (re.opt (re.++ (re.opt (re.range "-" "-")) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-")) (re.range "0" "9"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
