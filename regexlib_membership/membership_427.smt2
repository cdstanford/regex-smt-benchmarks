;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /([^\x00-\xFF]\s*)/u
;---
;(set-info :status unsat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.++ re.none (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) (str.to_re (str.++ "/" (str.++ "u" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
(check-sat)
