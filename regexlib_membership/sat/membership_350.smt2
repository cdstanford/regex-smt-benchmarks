;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]\d|[1][0-2]\/([0-2]\d|[3][0-1])\/([2][0]\d{2})\s([0-1]\d|[2][0-3])\:[0-5]\d\:[0-5]\d)?\s(AM|am|aM|Am|PM|pm|pM|Pm)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "09\u00A0AM"
(define-fun Witness1 () String (str.++ "0" (str.++ "9" (str.++ "\u{a0}" (str.++ "A" (str.++ "M" ""))))))
;witness2: "\x9AmR"
(define-fun Witness2 () String (str.++ "\u{09}" (str.++ "A" (str.++ "m" (str.++ "R" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "2")(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.++ (str.to_re (str.++ "2" (str.++ "0" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" ""))) (str.to_re (str.++ "P" (str.++ "m" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
