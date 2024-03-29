;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{3}\s?(\d{3}|\d{2}|d{1})\s?[A-Z])|([A-Z]\s?(\d{3}|\d{2}|\d{1})\s?[A-Z]{3})|(([A-HK-PRSVWY][A-HJ-PR-Y])\s?([0][2-9]|[1-9][0-9])\s?[A-HJ-PR-Z]{3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "DWSd\u00A0F\x3"
(define-fun Witness1 () String (str.++ "D" (str.++ "W" (str.++ "S" (str.++ "d" (str.++ "\u{a0}" (str.++ "F" (str.++ "\u{03}" ""))))))))
;witness2: "X0ZQXK"
(define-fun Witness2 () String (str.++ "X" (str.++ "0" (str.++ "Z" (str.++ "Q" (str.++ "X" (str.++ "K" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "d" "d")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "A" "Z"))))))(re.union (re.++ (re.range "A" "Z")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 3) (re.range "A" "Z")))))) (re.++ (re.++ (re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "P")(re.union (re.range "R" "S")(re.union (re.range "V" "W") (re.range "Y" "Y"))))) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "2" "9")) (re.++ (re.range "1" "9") (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 3) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Z")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
