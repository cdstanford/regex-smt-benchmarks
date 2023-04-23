;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d{1,6}\-\d{1,6})|(\d{1,6}\\\d{1,6})|(\d{1,6})(\/)(\d{1,6})|(\w{1}\-?\d{1,6})|(\w{1}\s\d{1,6})|((P\.?O\.?\s)((BOX)|(Box))(\s\d{1,6}))|((([R]{2})|([H][C]))(\s\d{1,6}\s)((BOX)|(Box))(\s\d{1,6}))?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "A-8"
(define-fun Witness1 () String (str.++ "A" (str.++ "-" (str.++ "8" ""))))
;witness2: "\u00F95898"
(define-fun Witness2 () String (str.++ "\u{f9}" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "8" ""))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "\u{5c}" "\u{5c}") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "/" "/") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.++ (re.range "P" "P")(re.++ (re.opt (re.range "." "."))(re.++ (re.range "O" "O")(re.++ (re.opt (re.range "." ".")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.union (str.to_re (str.++ "B" (str.++ "O" (str.++ "X" "")))) (str.to_re (str.++ "B" (str.++ "o" (str.++ "x" ""))))) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 1 6) (re.range "0" "9"))))) (re.opt (re.++ (re.union ((_ re.loop 2 2) (re.range "R" "R")) (str.to_re (str.++ "H" (str.++ "C" ""))))(re.++ (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 1 6) (re.range "0" "9")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.union (str.to_re (str.++ "B" (str.++ "O" (str.++ "X" "")))) (str.to_re (str.++ "B" (str.++ "o" (str.++ "x" ""))))) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 1 6) (re.range "0" "9"))))))))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
