;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\([2-9]|[2-9])(\d{2}|\d{2}\))(-|.|\s)?\d{3}(-|.|\s)?\d{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(8300667809"
(define-fun Witness1 () String (str.++ "(" (str.++ "8" (str.++ "3" (str.++ "0" (str.++ "0" (str.++ "6" (str.++ "6" (str.++ "7" (str.++ "8" (str.++ "0" (str.++ "9" ""))))))))))))
;witness2: "281999G8599"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "G" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "(" "(") (re.range "2" "9")) (re.range "2" "9"))(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range ")" ")")))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
