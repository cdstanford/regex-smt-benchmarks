;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(?082|083|084|072\)?[\s-]?[\d]{3}[\s-]?[\d]{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "083"
(define-fun Witness1 () String (str.++ "0" (str.++ "8" (str.++ "3" ""))))
;witness2: "084"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "4" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "(")) (str.to_re (str.++ "0" (str.++ "8" (str.++ "2" ""))))))(re.union (str.to_re (str.++ "0" (str.++ "8" (str.++ "3" ""))))(re.union (str.to_re (str.++ "0" (str.++ "8" (str.++ "4" "")))) (re.++ (str.to_re (str.++ "0" (str.++ "7" (str.++ "2" ""))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
