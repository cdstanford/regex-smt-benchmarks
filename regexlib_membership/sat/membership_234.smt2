;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FR)?\s?[A-Z0-9-[IO]]{2}[0-9]{9}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "FR\u008590514378578"
(define-fun Witness1 () String (str.++ "F" (str.++ "R" (str.++ "\u{85}" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "1" (str.++ "4" (str.++ "3" (str.++ "7" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "8" "")))))))))))))))
;witness2: "TF192380799"
(define-fun Witness2 () String (str.++ "T" (str.++ "F" (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "7" (str.++ "9" (str.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "F" (str.++ "R" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N") (re.range "P" "Z")))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
