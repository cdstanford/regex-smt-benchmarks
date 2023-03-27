;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(b|B)(f|F)(p|P)(o|O)(\s*||\s*C(/|)O\s*)[0-9]{1,4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "bFpoC/O108"
(define-fun Witness1 () String (str.++ "b" (str.++ "F" (str.++ "p" (str.++ "o" (str.++ "C" (str.++ "/" (str.++ "O" (str.++ "1" (str.++ "0" (str.++ "8" "")))))))))))
;witness2: "bFPo60"
(define-fun Witness2 () String (str.++ "b" (str.++ "F" (str.++ "P" (str.++ "o" (str.++ "6" (str.++ "0" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "B" "B") (re.range "b" "b"))(re.++ (re.union (re.range "F" "F") (re.range "f" "f"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "O" "O") (re.range "o" "o"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.union (str.to_re "") (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "C" "C")(re.++ (re.union (re.range "/" "/") (str.to_re ""))(re.++ (re.range "O" "O") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))) ((_ re.loop 1 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
