;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{3}\s?(\d{3}|\d{2}|d{1})\s?[A-Z])|([A-Z]\s?(\d{3}|\d{2}|\d{1})\s?[A-Z]{3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "S 98\x9ZXG"
(define-fun Witness1 () String (str.++ "S" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "\u{09}" (str.++ "Z" (str.++ "X" (str.++ "G" "")))))))))
;witness2: "yZ 2TAY"
(define-fun Witness2 () String (str.++ "y" (str.++ "Z" (str.++ " " (str.++ "2" (str.++ "T" (str.++ "A" (str.++ "Y" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "d" "d")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "A" "Z")))))) (re.++ (re.++ (re.range "A" "Z")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 3) (re.range "A" "Z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
