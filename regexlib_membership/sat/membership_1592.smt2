;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{1,3}.?\d{0,3}\s[a-zA-Z]{2,30}\s[a-zA-Z]{2,15}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "84\u00C77\xBSe OV"
(define-fun Witness1 () String (str.++ "8" (str.++ "4" (str.++ "\u{c7}" (str.++ "7" (str.++ "\u{0b}" (str.++ "S" (str.++ "e" (str.++ " " (str.++ "O" (str.++ "V" "")))))))))))
;witness2: "8\xB\u00A0PP\xCoNY\x1B\u008A\u00A6"
(define-fun Witness2 () String (str.++ "8" (str.++ "\u{0b}" (str.++ "\u{a0}" (str.++ "P" (str.++ "P" (str.++ "\u{0c}" (str.++ "o" (str.++ "N" (str.++ "Y" (str.++ "\u{1b}" (str.++ "\u{8a}" (str.++ "\u{a6}" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ ((_ re.loop 0 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 2 30) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 2 15) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
