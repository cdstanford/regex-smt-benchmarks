;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{6}|[0-9]{3}\s[0-9]{3})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x13o792388"
(define-fun Witness1 () String (str.++ "\u{13}" (str.++ "o" (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "3" (str.++ "8" (str.++ "8" "")))))))))
;witness2: "398\xD978"
(define-fun Witness2 () String (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "7" (str.++ "8" ""))))))))

(assert (= regexA (re.union ((_ re.loop 6 6) (re.range "0" "9")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 3 3) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
